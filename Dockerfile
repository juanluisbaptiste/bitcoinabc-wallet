FROM juanluisbaptiste/xpra-base:latest
MAINTAINER Juan Luis Baptiste <juan.baptiste@gmail.com>
ENV BTCABC_VERSION "0.16.1"
ENV BTCABC_GUI_DOWNLOAD_URL https://download.bitcoinabc.org/0.16.1/result/linux/bitcoin-abc-${BTCABC_VERSION}-x86_64-linux-gnu.tar.gz
ENV DISPLAY=:100
ENV WEB_VIEW_PORT 10000
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y curl zip libfontconfig1 libfreetype6 && \
    apt-get clean && \
    useradd -ms /bin/bash -G xpra user
COPY local-entrypoint.sh /
RUN  chmod 755 /local-entrypoint.sh

USER user
WORKDIR /home/user
RUN curl ${BTCABC_GUI_DOWNLOAD_URL} -O
RUN tar zxf bitcoin-abc-${BTCABC_VERSION}-x86_64-linux-gnu.tar.gz && \
    mv bitcoin-abc-${BTCABC_VERSION} bitcoin-abc && \
    rm bitcoin-abc-${BTCABC_VERSION}-x86_64-linux-gnu.tar.gz

CMD ["/local-entrypoint.sh"]
EXPOSE 10000
