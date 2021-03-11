FROM node:alpine

ENV AWSEBCLI_VERSION=3.17.1
ENV AWSCLI_VERSION=1.17.17
ENV TERRAFORM_VERSION 0.14.8
ENV CRYPTOGRAPHY_DONT_BUILD_RUST 1

RUN apk add --no-cache --virtual .build-deps gcc musl-dev build-base
RUN apk add --no-cache \
  python3 \
  make \
  python3-dev \
  libffi-dev \
  libressl-dev \
  py3-pip \
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
  zip \
  .build-deps \
  gcc \
  musl-dev

  RUN pip3 install --upgrade pip setuptools_rust && hash -r

  RUN pip3 install --no-cache-dir --upgrade awsebcli==$AWSEBCLI_VERSION awscli==$AWSCLI_VERSION && \
  aws configure set preview.cloudfront true


RUN wget -O terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_arm64.zip && \
  unzip terraform.zip -d /usr/local/bin && \
  rm -f terraform.zip

RUN terraform -v 

RUN mkdir ~/.ssh/
ENTRYPOINT ["/bin/bash", "-c"]