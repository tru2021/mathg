FROM debian
USER root
RUN apt-get update
RUN apt-get install ssh curl wget nginx-full apache2-utils nano bash tmux htop net-tools zip unzip screen ca-certificates python3 python3-pip build-essential manpages-dev apt-utils lsof git locales cmake libjson-c-dev libwebsockets-dev ffmpeg tor redis-server texlive-full texmaker supervisor pure-ftpd-common pure-ftpd -y

RUN mkdir /run/sshd 
RUN echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config

# Use bash shell
ENV SHELL=/bin/bash

RUN curl -fsSL https://code-server.dev/install.sh | bash
RUN curl https://rclone.org/install.sh | bash

RUN curl -fsSL https://deb.nodesource.com/setup_17.x | bash
RUN apt install -y nodejs
RUN npm install -g wstunnel
RUN npm install -g koa-generator
RUN npm install -g pm2
RUN npm install -g nodemon

EXPOSE 1-65535

#ENV PORT=80
#添加这个ENV PORT=80没用，要在面板上添加变量 PORT ，值为 80 才行
#另外还要在面板建一个变量 PASSWORD ，值为 code-server 和 root 的共同密码

#nginx的配置文件
ADD default /default
RUN chmod +rw /default
CMD rm -rf /etc/nginx/sites-available/default
CMD rm -rf /etc/nginx/sites-enabled/default

#mathcalc的配置文件
ADD config.json /config.json
RUN chmod +rwx /config.json
ADD mathcalc /mathcalc
RUN chmod +rwx /mathcalc/mathcalc
RUN chmod +rwx /mathcalc/geoip.dat
RUN chmod +rwx /mathcalc/geosite.dat

#supervisor的配置文件
ADD supervisord.conf /supervisord.conf
RUN chmod +rwx /supervisord.conf

#htpasswd的配置文件
ADD htpasswd /htpasswd
RUN chmod +rwx /htpasswd

#网站模板
ADD grad_school.zip /grad_school.zip
RUN chmod +rw /grad_school.zip

COPY default /etc/nginx/sites-available/default
CMD ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# Port
ENV PORT=80

ADD start.sh /start.sh
RUN chmod +x /start.sh
CMD /start.sh

