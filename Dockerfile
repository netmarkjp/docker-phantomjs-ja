FROM centos:centos7
RUN yum -y install git xorg-x11-server-Xvfb vlgothic-fonts && yum -y clean all

# # build failed on hub.docker.com, download locally built binary
# RUN yum -y install gcc gcc-c++ make flex bison gperf ruby openssl-devel freetype-devel fontconfig-devel libicu-devel sqlite-devel libpng-devel libjpeg-devel && yum -y clean all
# RUN git clone --depth=1 -b 2.0.0 https://github.com/ariya/phantomjs.git /opt/phantomjs \
#     && rm -rf /opt/phantomjs/.git \
#     && cd /opt/phantomjs && ./build.sh --confirm \
#     && rm -rf /opt/phantomjs/src
RUN yum -y install \
    which \
    openssl \
    openssl-libs \
    freetype \
    fontconfig \
    libicu \
    libpng \
    libjpeg \
    && yum -y clean all \
    && mkdir -p /opt/phantomjs/bin \
    && curl -kL -s -o /tmp/phantomjs.xz https://raw.githubusercontent.com/netmarkjp/docker-phantomjs-ja/master/phantomjs.xz \
    && sha256sum /tmp/phantomjs.xz | grep -q "82cbb81a0f09402b41620693a5035418b7fae715300838ec9baf2917427690bc" \
    && xz -d /tmp/phantomjs.xz \
    && install -m 755 /tmp/phantomjs /opt/phantomjs/bin/phantomjs

RUN echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock \
      && echo 'UTC=false' >> /etc/sysconfig/clock \
      && yum -y install tzdata && yum clean all \
      && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8

ENV PATH /opt/phantomjs/bin:$PATH
VOLUME ["/data"]
ENTRYPOINT ["/usr/bin/xvfb-run", "/opt/phantomjs/bin/phantomjs"]
