FROM centos:centos7
RUN yum -y install git xorg-x11-server-Xvfb vlgothic-fonts && yum -y clean all
RUN yum -y install gcc gcc-c++ make flex bison gperf ruby openssl-devel freetype-devel fontconfig-devel libicu-devel sqlite-devel libpng-devel libjpeg-devel && yum -y clean all
RUN git clone --depth=1 -b 2.0.0 https://github.com/ariya/phantomjs.git /opt/phantomjs \
    && rm -rf /opt/phantomjs/.git \
    && cd /opt/phantomjs && ./build.sh --confirm \
    && rm -rf /opt/phantomjs/src
ENV PATH /opt/phantomjs/bin:$PATH
VOLUME ["/data"]
ENTRYPOINT ["/usr/bin/xvfb-run", "/opt/phantomjs/bin/phantomjs"]
