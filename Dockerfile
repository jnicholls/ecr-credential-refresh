FROM infrastructureascode/aws-cli
ENV KUBECTL_VERSION 1.15.2
ENV KUBECTL_CHECKSUM daf020f5dc07314f4e388e4a6c9cc201

ADD https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN echo "${KUBECTL_CHECKSUM}  /usr/local/bin/kubectl" > kubectl.md5
RUN md5sum -c kubectl.md5
RUN chmod +x /usr/local/bin/kubectl

RUN apk update \
    && apk add jq

ENTRYPOINT ["/bin/sh"]
