#!/usr/bin/env python
#本来想写个模块用于ansible,实现一键部署代码的，没想到被这个模拟的con0 卡了一天！
import fire
import select
import telnetlib
import socket
import sys
from time import sleep
import logging


ASA_MORE="--- More ---"
IOS_MORE="--More--"
MORE_LINE=[IOS_MORE,ASA_MORE]


WTIME=1
RBYTES=1024

EOF="#"
TMP_EOF=">"

TEL_UNTIL_USER="ername: "
TEL_UNTIL_PASSWORD="sword: "

class IOSClient:
    def __init__(self,host,port=23,more_line=IOS_MORE):
        self.client = None
        self.host = host
        self.port = port
        self.more_line = more_line
        self.timeout = 10
        self.disable_more = True
        

    def open(self):
        self.client=telnetlib.Telnet(self.host,self.port,self.timeout)
        self.client.set_debuglevel(7)
        #self.client.set_option_negotiation_callback(set_max_window_size)


    def write(self,cmd_str):
        cmd_str+="\n"
        self.client.write(cmd_str.encode("ascii"))
    
    def read_until(self,promot):
        promot = bytes(promot,"ascii")
        echo = self.client.read_until(promot)
        return echo.decode("ascii")

    def con0_show(self,cmds,promot="#"):
        """
          这个在少数情况下有用，比如在IOU实验下；
          这个时候，虽然用telnet连过去，时间上连的时console.
        """
        result = []
        if self.disable_more:  
            #这行必须的，否则会卡在“Press RETURN to get started.” 这个界面
            self.write("\r\n")
            self.write("\n") 
            self.write("\n") 
            self.write("enable")
            self.read_until(promot)
            self.write("terminal length 0")
            self.read_until(promot)

        for cmd in cmds:
            self.write("!")
            self.write(cmd)
                    
        if self.disable_more:
            self.write("terminal length 32")
        self.write("exit")
        
        result = self.client.read_until(b"#exit")
            
        return result

def run_telnet(host,port,cmds):
    cmds = cmds.split(";")
    print(cmds)
    client = IOSClient(host,port)
    client.open()
    print(client.con0_show(cmds).decode("ascii"))


if __name__ == "__main__":
    fire.Fire(run_telnet)
    #run_telnet("172.168.1.118",32769,"sh ip route;sho ver")



