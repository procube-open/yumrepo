FROM centos:7
MAINTAINER "Mitsuru Nakakawaji" <mitsuru@procube.jp>
RUN yum -y install httpd rpm-sign expect createrepo make
RUN echo "LoadModule mpm_event_module modules/mod_mpm_event.so" > /etc/httpd/conf.modules.d/00-mpm.conf
RUN groupadd -g 111 builder
RUN useradd -g builder -u 111 builder
RUN setcap CAP_NET_BIND_SERVICE+ep /usr/sbin/httpd
RUN chown builder:builder /var/run/httpd /var/www/html /var/log/httpd /etc/httpd/conf.d
USER builder
ENV HOME /home/builder
WORKDIR ${HOME}
COPY generate-gpgkey.sh generate-repo.sh Makefile Makefile.repo rpmsign-batch.expect start.sh ${HOME}/
ENV REPO_NAME chip-in
ENV SRCDIR $HOME/RPMS
ENV OUTDIR /var/www/html/${REPO_NAME}
ENV EMAIL support@procube.jp
ENV FQDN yum-repo.chip-in.net
EXPOSE 80
CMD ["./start.sh"]
