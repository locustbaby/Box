# Docker
```dockerfile
# Version 0.0.1
FROM ubuntu:14.04
MAINTAINER JAMES Turnbull
"james@example.com"
RUN apt_get update && apt_get install -y nginx
RUN echo 'HI, i am in ur container'\
	> /usr/share/nginx/html/index.html
EXPOSE 80
```

