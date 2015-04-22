FROM centos:centos7
RUN yum -y install git xorg-x11-server-Xvfb vlgothic-fonts
RUN yum -y install gcc gcc-c++ make flex bison gperf ruby openssl-devel freetype-devel fontconfig-devel libicu-devel sqlite-devel libpng-devel libjpeg-devel
RUN cd /opt && git clone git://github.com/ariya/phantomjs.git
RUN cd /opt/phantomjs && git checkout 2.0
RUN cd /opt/phantomjs && ./build.sh --confirm
VOLUME ["/data"]
ENTRYPOINT ["/usr/bin/xvfb-run", "/opt/phantomjs/bin/phantomjs"]
