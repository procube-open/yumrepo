FROM centos:7
MAINTAINER "Mitsuru Nakakawaji" <mitsuru@procube.jp>
RUN yum -y install httpd rpm-sign expect createrepo make 
ENV HOME /root
WORKDIR /root
COPY generate-gpgkey.sh generate-repo.sh Makefile Makefile.repo rpmsign-batch.expect start.sh /root/
VOLUME ["/root/RPMS"]
ENV REPO_NAME chip-in
ENV SRCDIR /root/RPMS
ENV OUTDIR /var/www/html/${REPO_NAME}
ENV EMAIL mitsuru@procube.jp
ENV FQDN yum-repo.chip-in.net
RUN echo "LoadModule mpm_event_module modules/mod_mpm_event.so" > /etc/httpd/conf.modules.d/00-mpm.conf
CMD ["./start.sh"]
