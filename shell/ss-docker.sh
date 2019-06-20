# This is an example file
# This is an example file
# This is an example file
# This is an example file


docker pull shadowsocks/shadowsocks-libev
docker run -e PASSWORD=examplepassword -e METHOD=aes-256-cfb -p 21000:8388 -p 21000:8388/udp -d --restart always shadowsocks/shadowsocks-libev
