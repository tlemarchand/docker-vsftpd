FROM debian:bookworm-slim

COPY version /tmp/

RUN apt-get update && apt-get install -y vsftpd=`cat /tmp/version` && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd -g 1000 -r vsftpd && useradd --no-log-init -u 1000 -r -g vsftpd vsftpd && \
    sed -i 's/listen=NO/listen=YES/' /etc/vsftpd.conf && \
    sed -i 's/listen_ipv6=YES/listen_ipv6=no/' /etc/vsftpd.conf && \
    sed -i 's/anonymous_enable=NO/anonymous_enable=YES/' /etc/vsftpd.conf && \
    sed -i 's/local_enable=YES/local_enable=NO/' /etc/vsftpd.conf && \
    sed -i 's/#write_enable=YES/write_enable=YES/' /etc/vsftpd.conf && \
    sed -i 's/#anon_upload_enable=YES/anon_upload_enable=YES/' /etc/vsftpd.conf && \
    sed -i 's/#xferlog_file=\/var\/log\/vsftpd.log/xferlog_file=\/dev\/stdout/' /etc/vsftpd.conf && \
#    sed -i 's/#chown_uploads=YES/chown_uploads=YES/' /etc/vsftpd.conf && \
#    sed -i 's/#chown_username=whoever/chown_username=x/' /etc/vsftpd.conf && \
    echo 'anon_root=/srv/ftp' >> /etc/vsftpd.conf && \
    echo 'vsftpd_log_file=/dev/stdout' >> /etc/vsftpd.conf && \
    echo 'run_as_launching_user=YES' >> /etc/vsftpd.conf && \
    echo 'listen_port=2121' >> /etc/vsftpd.conf && \
    chown vsftpd: /etc/vsftpd.conf

EXPOSE 2121/tcp

USER vsftpd

ENTRYPOINT /usr/sbin/vsftpd
CMD ['']