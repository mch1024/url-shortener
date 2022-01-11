#FROM python:3.9.2-alpine3.13
FROM python:3.10.1-alpine

# application
RUN mkdir /app
COPY requirements.txt /tmp
COPY api.py /app
RUN pip --no-cache-dir install -r /tmp/requirements.txt && \
	rm -f /tmp/requirements.txt

# reverse proxy
RUN apk add --no-cache nginx
#RUN mkdir /run/nginx/ && chmod 770 /run/nginx && chgrp nginx /run/nginx
RUN rm -f /etc/nginx/http.d/*.conf
COPY default.conf /etc/nginx/http.d/

COPY entrypoint.sh /

WORKDIR /app

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["/entrypoint.sh"]
