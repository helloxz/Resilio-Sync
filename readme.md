# Resilio Sync一键安装脚本

### 注意
* Resilio Sync已经被GFW和谐，国内VPS请不要使用该脚本。

### 要求
* CentOS 6/7 X64
* 其它X64系统应该也支持，具体未测试。

### 安装方法
```bash
#安装必要的软件包
yum -y install wget unzip
#下载脚本
wget https://github.com/helloxz/Resilio-Sync/archive/master.zip
#解压并安装
unzip master.zip && cd Resilio-Sync-master && chmod +x *sync.sh && ./sync.sh
```

详细说明请戳这里：[CentOS一键安装Resilio Sync脚本](https://www.xiaoz.me/archives/8219)

### 联系方式
* Blog:[https://www.xiaoz.me/](https://www.xiaoz.me/)
* BBS:[https://bbs.xiaoz.me/](https://bbs.xiaoz.me/)