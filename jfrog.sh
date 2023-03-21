sudo apt update
wget -O artifactory-pro.deb "https://releases.jfrog.io/artifactory/artifactory-pro-debs/pool/jfrog-artifactory-pro/jfrog-artifactory-pro-[RELEASE].deb"
sudo apt install ./artifactory-pro.deb -y
sudo apt-get install nginx -y
sudo rm -rf /etc/nginx/sites-enabled/default
sudo rm -rf /etc/nginx/sites-available/default
sudo touch /etc/nginx/sites-available/jfrog
sudo bash -c 'sudo cat <<EOT> /etc/nginx/sites-available/jfrog
server{
    listen      80;
    server_name sonar.robofarming.link;
    access_log  /var/log/nginx/sonar.access.log;
    error_log   /var/log/nginx/sonar.error.log;
    proxy_buffers 16 64k;
    proxy_buffer_size 128k;
    location / {
        proxy_pass  http://127.0.0.1:8082;
        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
        proxy_redirect off;
              
        proxy_set_header    Host            \$host;
        proxy_set_header    X-Real-IP       \$remote_addr;
        proxy_set_header    X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header    X-Forwarded-Proto http;
    }
}
EOT'
ln -s /etc/nginx/sites-available/jfrog /etc/nginx/sites-enabled/jfrog

sudo systemctl enable nginx.service
sudo systemctl restart nginx.service
sudo systemctl restart artifactory.service