```
include "host.vcl";
acl purge {
	"localhost";
	"127.0.0.1";
	"192.168.0.0"/16;
	"10.0.0.0"/8;
}


sub vcl_recv {
	set req.backend = ihs_director;

	if (req.request != "GET" &&
		req.request != "HEAD" &&
		req.request != "POST" &&
		req.request != "BAN" &&
		req.request != "PURGE") {
		return (pipe);
	}

	if(req.request == "GET" && 
	(req.url ~ "^[^\?]*\.html"
	|| req.url ~ "^/(|\?[^/]*)$"
	|| req.url ~ "^[^\?]*\.htm"
	|| req.url ~ "^[^\?]*\.jpg"
	|| req.url ~ "^[^\?]*\.jpeg"
	|| req.url ~ "^[^\?]*\.bmp"
	|| req.url ~ "^[^\?]*\.gif"
	|| req.url ~ "^[^\?]*\.png"
	|| req.url ~ "^[^\?]*\.zip"
	|| req.url ~ "^[^\?]*\.exe"
	|| req.url ~ "^[^\?]*\.txt"
	|| req.url ~ "^[^\?]*\.mp40drag"
	|| req.url ~ "^[^\?]*\.js"
	|| req.url ~ "^[^\?]*\.swf"
	|| req.url ~ "^[^\?]*\.mp3"
	|| req.url ~ "^[^\?]*\.apk"
	|| req.url ~ "^[^\?]*\.doc"
	|| req.url ~ "^[^\?]*\.pdf"
	|| req.url ~ "^[^\?]*\.json"
	|| req.url ~ "^[^\?]*\.css")){
	#上述页面类型去除 Cookie（静态文件通常不需要处理 Cookie，varnish默认不会缓存带有cookie的页面），注意是否有重要cookie信息的页面也被unset cookie
		unset req.http.cookie;
		#上述页面类型，去除查询字符串参数，避免重复缓存。注意是否有页面后缀设置不当，导致参数被去除
		set req.url = regsub(req.url,"\.html(\?|\&).*","\.html");
		set req.url = regsub(req.url,"^/\?.*","/");
		set req.url = regsub(req.url,"\.htm(\?|\&).*","\.htm");
		set req.url = regsub(req.url,"\.jpg(\?|\&).*","\.jpg");
		set req.url = regsub(req.url,"\.jpeg(\?|\&).*","\.jpeg");
		set req.url = regsub(req.url,"\.bmp(\?|\&).*","\.bmp");
		set req.url = regsub(req.url,"\.gif(\?|\&).*","\.gif");
		set req.url = regsub(req.url,"\.png(\?|\&).*","\.png");
		set req.url = regsub(req.url,"\.zip(\?|\&).*","\.zip");
		set req.url = regsub(req.url,"\.exe(\?|\&).*","\.exe");
		set req.url = regsub(req.url,"\.txt(\?|\&).*","\.txt");
		set req.url = regsub(req.url,"\.mp40drag(\?|\&).*","\.mp40drag");
		#set req.url = regsub(req.url,"\.js(\?|\&).*","\.js");
		set req.url = regsub(req.url,"\.swf(\?|\&).*","\.swf");
		set req.url = regsub(req.url,"\.mp3(\?|\&).*","\.mp3");
		set req.url = regsub(req.url,"\.apk(\?|\&).*","\.apk");
		set req.url = regsub(req.url,"\.doc(\?|\&).*","\.doc");
		set req.url = regsub(req.url,"\.swf(\?|\&).*","\.swf");
		set req.url = regsub(req.url,"\.pdf(\?|\&).*","\.pdf");
		set req.url = regsub(req.url,"\.json(\?|\&).*","\.json");
		set req.url = regsub(req.url,"\.jsonp(\?|\&).*","\.jsonp");
		#set req.url = regsub(req.url,"\.css(\?|\&).*","\.css");		
		if (! req.backend.healthy) {
			set req.grace = 30m;
		} else {
			set req.grace = 15s;
		}
		if(req.restarts == 0){
			if (req.http.x-forwarded-for){
				set req.http.X-Forwarded-For = req.http.X-Forwarded-For + ", "+ client.ip;
			} else {
				set req.http.X-Forwarded-For = client.ip;
			}
		}
		return(lookup);
	}elseif (req.request == "BAN") {
		if (!client.ip ~ purge) {
			error 405 "Not allowed";
		}
		set req.url = regsuball(req.url,"%28","(");
		set req.url = regsuball(req.url,"%29",")");
		set req.url = regsuball(req.url,"%7C","|");
		if (req.url ~ "^/$") {
			ban("req.url == " + req.url + " && obj.http.x-host ~ " + req.http.X-BAN-HOST);
		} else {
			ban("req.url ~ " + req.url + " && obj.http.x-host ~ " + req.http.X-BAN-HOST);    
		}
			error 200 "Ban added";
	}elseif (req.request == "PURGE") {
			if (!client.ip ~ purge) {
				error 405 "Not allowed";
			}
			return(lookup);
		}
##modified for SSO passport
##	return (pass);
	return (pipe);
} 
 
sub vcl_pass {
	return (pass);
}
 
sub vcl_hit {
	if (req.request == "PURGE") {
		purge;
		error 200 "Purged.";
	} 
}
 
sub vcl_miss {
	if (req.request == "PURGE") {
		purge;
		error 200  "Not in cache.";
	}
}
 
sub vcl_fetch {
    if (beresp.status >=400){
		set beresp.http.Cache-Control = "no-cache,no-store,max-age=0";
        set beresp.ttl = 10s;
	}
	set beresp.http.Server = "SNREVIEW";
	set beresp.http.x-host = req.http.host;
	set beresp.grace = 30m;
	#删除response的s-maxage，防止CDN等其他cache也使用s-maxage为缓存时间
	set beresp.http.Cache-Control = regsuball(beresp.http.Cache-Control,", s-maxage=\d+","");
	set beresp.http.Cache-Control = regsuball(beresp.http.Cache-Control,",s-maxage=\d+","");	
	set beresp.http.Cache-Control = regsuball(beresp.http.Cache-Control,"s-maxage=\d+","");
	#去除response返回的cookie，提升命中率。varnish默认不会缓存带有cookie的页面
	unset beresp.http.set-cookie;
}
 
sub vcl_deliver {
     ##设置hit or miss的标志和具体哪一台标志，方便故障排查和调优
	if (obj.hits > 0) {
		set resp.http.X-Cache = "S-HIT_68";
		set resp.http.X-Cache-Hits = obj.hits;
		set resp.http.Age = 0;
	} else {
		set resp.http.X-Cache = "Suning-MISS_68";
	}
	unset resp.http.X-Varnish;
	unset resp.http.x-host;
	set resp.http.Via = "1.1 Xcache_S_68";
	if (resp.http.magicmarker) {
		/* Remove the magic marker */
		unset resp.http.magicmarker;
		/* By definition we have a fresh object */
		unset resp.http.age;
		unset resp.http.Expires;
	}
}

sub vcl_error {
	return (deliver);
}
```
