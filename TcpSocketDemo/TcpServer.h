//
//  TcpServer.h
//  TcpSocketDemo
//
//  Created by aoni on 16/9/29.
//  Copyright © 2016年 aoni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
#import "ConnectionDef.h"

typedef void(^ServerComplection)(NSString *);


@interface TcpServer : NSObject  <GCDAsyncSocketDelegate> {
    GCDAsyncSocket *serverSocket;
    NSMutableArray *clientArray;
    long readTag;
    long writeTag;
}

@property (nonatomic, copy)   ServerComplection  serverComplection;

-(long)getReadTag;
-(long)getWriteTag;
-(void)createTcpSocket:(const char *)queueName acceptOnPort:(uint16_t)port;
-(void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket;
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag;
-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag;
-(void)socket:(GCDAsyncSocket *)sock writeString:(NSString *)str withTag:(long)tag;
-(void)broadcastStr:(NSString *)str;
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err;

@end
