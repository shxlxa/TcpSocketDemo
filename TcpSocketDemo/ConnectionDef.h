//
//  ConnectionDef.h
//  TcpSocketDemo
//
//  Created by aoni on 16/9/29.
//  Copyright © 2016年 aoni. All rights reserved.
//

#ifndef ConnectionDef_h
#define ConnectionDef_h

#define DEF_STR_ENCODING    NSUTF8StringEncoding
//连接超时时间为60秒
#define CONNECT_TIMEOUT     60
#define READ_TIMEOUT        -1
//发送数据超时时间为60秒
#define WRITE_TIMEOUT       60

#define SERVER_QUEUE        "tcpServerQueue"
#define CLIENT_QUEUE        "tcpClientQueue"

#define SERVER_ADDRESS      @"127.0.0.1"
#define SERVER_PORT         12345


#endif /* ConnectionDef_h */
