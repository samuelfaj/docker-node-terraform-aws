FROM node:alpine

RUN apk add --no-cache \
  python \
  py-pip \
  py-setuptools \
  ca-certificates \
  openssl \
  groff \
  less \
  bash \
  curl \
  jq \
  git \
  openssh-client \
  zip && \
  pip install --no-cache-dir --upgrade pip awscli && \
  aws configure set preview.cloudfront true

ENV TERRAFORM_VERSION 0.13.4

RUN wget -O terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  unzip terraform.zip -d /usr/local/bin && \
  rm -f terraform.zip

RUN mkdir ~/.ssh/
ENTRYPOINT ["/bin/bash", "-c"]
