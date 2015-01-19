mkbase64
========

当shadowsocks生成config.json文件，使用此脚本：
> $ mkbase64.sh config.json

将生成一个名为config.base64的文件，内容是:
> ss://method:password@server:server_port 

> ss://base64 code

需要 **注意** 的是，json的文件必须是以下格式，
不要多一行也不要少一行，也不要改变顺序：
```
{
    "server":"my_server_ip",
    "server_port":8388,
    "local_port":1080,
    "password":"barfoo!",
    "timeout":600,
    "method":"table"
}
```

当需要把ss://base64 code制作成QR二维码的时候，
如果base64 code最后有“=”号，需要**忽略**它们，
然后将它复制到Qreator(Ubuntu软件中心可以找到)的“文本”菜单下的文本框中即可得到config.json的二维码。

当需要清空.base64的文件是，运行：
> $ mkbase64.sh remove

即可。
