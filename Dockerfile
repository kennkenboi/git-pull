FROM alpine:latest

MAINTAINER Kenboi <kennkenboi+docker@gmail.com>

RUN apk update \
	&& apk upgrade \
	&& apk add --no-cache dos2unix openssh-client \
	&& rm -rf /var/cache/apk/*


COPY entrypoint.sh /script/entrypoint.sh

WORKDIR /workspace

ENTRYPOINT ["/bin/sh", "/script/entrypoint.sh"]

CMD ["deploy"]
