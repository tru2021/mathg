echo root:c68.300OQa|chpasswd

#需要手动安装一下 go https://go.dev/doc/install ，添加环境变量 PATH /etc/profile，然后 source /etc/profile
#记得在 /etc/nginx/nginx.conf 的 http 域里的最后一行添加 client_max_body_size 1024m; 然后重载一下 nginx 的配置文件 nginx -s reload
#client_max_body_size 0;代表大小不限制

#Ubuntu安装LaTeX，以VS Code为编辑器，支持中文字体简单教程_努力做无毒的Pb的博客-程序员宝宝
#https://www.cxybb.com/article/weixin_44715583/109553033

#解压网站模板
unzip -o /grad_school.zip -d /
chmod -Rf +rw /templatemo_557_grad_school

rm -rf /usr/bin/python
ln -s /usr/bin/python3 /usr/bin/python

wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl

#install ttyd
git clone https://github.com/tsl0922/ttyd.git
cd ttyd && mkdir build && cd build
cmake ..
make && make install

#run code-server
#screen_name="code-server"
#screen -dmS $screen_name
#cmd="code-server --host 0.0.0.0 --port 8722";
#screen -x -S $screen_name -p 0 -X stuff "$cmd"
#screen -x -S $screen_name -p 0 -X stuff '\n'

#run ttyd
#screen_name="ttyd"
#screen -dmS $screen_name
#cmd="ttyd login";
#screen -x -S $screen_name -p 0 -X stuff "$cmd"
#screen -x -S $screen_name -p 0 -X stuff '\n'

curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash
#filebrowser -r /
filebrowser config set -b '/file'
filebrowser config set -p 60002

#run filebrowser
#screen_name="filebrowser"
#screen -dmS $screen_name
#cmd="filebrowser";
#screen -x -S $screen_name -p 0 -X stuff "$cmd"
#screen -x -S $screen_name -p 0 -X stuff '\n'
#filebrowser username:admin password:admin

#run rclone
#screen_name="rclone"
#screen -dmS $screen_name
#cmd="rclone rcd --rc-web-gui --rc-addr 127.0.0.1:5572 --rc-user root --rc-pass $PASSWORD";
#screen -x -S $screen_name -p 0 -X stuff "$cmd"
#screen -x -S $screen_name -p 0 -X stuff '\n'

supervisord -c /supervisord.conf

service redis-server start &
/etc/init.d/redis-server restart >/dev/null 2>&1 &
service nginx start &
/etc/init.d/nginx restart >/dev/null 2>&1 &

#wstunnel -s 0.0.0.0:80 &
/usr/sbin/sshd -D
