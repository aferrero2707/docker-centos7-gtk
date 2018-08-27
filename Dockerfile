FROM centos:7

#RUN groupadd --system colord

# Install system packages
RUN yum update -y && yum -y install \
intltool libpng-devel make \
automake fftw-devel libjpeg-turbo-devel \
libwebp-devel libxml2-devel swig ImageMagick-c++-devel \
bc cfitsio-devel gsl-devel matio-devel \
giflib-devel pugixml-devel wget curl git itstool \
bison flex unzip dbus-devel libXtst-devel \
mesa-libGL-devel mesa-libEGL-devel vala \
libxslt-devel docbook-xsl libffi-devel \
libvorbis-devel python-six curl \
openssl-devel readline-devel expat-devel libtool \
pixman-devel libffi-devel gtkmm24-devel gtkmm30-devel libcanberra-devel \
lcms2-devel gtk-doc python-devel python-pip nano OpenEXR-devel
RUN yum groupinstall -y "Development Tools"

ENV AIPREFIX=zyx PATH=/zyx/bin:/work/inst/bin:$PATH LD_LIBRARY_PATH=/zyx/lib:/work/inst/lib64:/work/inst/lib:$LD_LIBRARY_PATH   PKG_CONFIG_PATH=/zyx/share/pkgconfig:/zyx/lib/pkgconfig:/work/inst/lib/pkgconfig:/work/inst/share/pkgconfig:/usr/share/pkgconfig:/usr/lib/pkgconfig:/usr/lib64/pkgconfig:$PKG_CONFIG_PATH 

RUN mkdir -p /$AIPREFIX/bin && mkdir -p /work
COPY show_versions.sh /$AIPREFIX/bin

RUN cd /work && rm -rf cmake* && wget https://cmake.org/files/v3.8/cmake-3.8.2.tar.gz && tar xzvf cmake-3.8.2.tar.gz && cd cmake-3.8.2 && ./bootstrap --prefix=/work/inst --parallel=2 && make -j 2 && make install

ADD build_gcc.sh /work/build_gcc.sh
RUN mkdir -p /work && cd /work && bash build_gcc.sh

# Cleanup
RUN rm -rf /gcc-* && cd /work && rm -rf build gcc-* Python-* cmake* lcms2*
