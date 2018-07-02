```shell
# Nginx
        location / {
            #root   html;
            #index  index.html index.htm;
            proxy_set_header Host $host;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_pass http://list1;
            if ($request_uri ~ ^/qrs-web/(.*)){
                rewrite ^(.*)$ $1 break;
                }
            if ($request_uri ~ ^/NginxStatus/(.*)){
                rewrite ^(.*)$ $1 break;
                }
           rewrite ^(.*)$ /qrs-web$1 break;
		   #if ( $request_uri !~ ^/dtm-web ){
           #     rewrite (.*) /dtm-web$1 break;
           #}
        }
#       if ($host = "qrssit.cnsuning.com"){
#            rewrite ^(.*)$ /qrs-web$1 last;   #500
#        }
location =/ {index index.html ; rewrite /(.*) /ssrc-web/ last ;}
```

