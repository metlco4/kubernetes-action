FROM alpine:3.15

RUN apk add py-pip curl
RUN pip install awscli

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh && \
    apk add --no-cache --update openssl curl ca-certificates

ARG EKS_VERSION="1.21.2/2021-07-05"
RUN curl -o /usr/bin/kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/$EKS_VERSION/bin/linux/amd64/kubectl && \
    chmod +x /usr/bin/kubectl

RUN curl -o /usr/bin/aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/$EKS_VERSION/bin/linux/amd64/aws-iam-authenticator && \
    chmod +x /usr/bin/aws-iam-authenticator && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/entrypoint.sh"]

