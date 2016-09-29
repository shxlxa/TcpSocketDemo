//
//  TcpClient.h
//  TcpSocketDemo
//
//  Created by aoni on 16/9/29.
//  Copyright © 2016年 aoni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
#import "ConnectionDef.h"

@interface TcpClient : NSObject<GCDAsyncSocketDelegate> {
    GCDAsyncSocket *clientSocket;
    long readTag;
    long writeTag;
}

-(long)getReadTag;
-(long)getWriteTag;
-(void)createTcpSocket:(const char *)queueName connectToHost:(NSString *) host onPort:(uint16_t)port;
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port;
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag;
-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag;
-(void)writeString:(NSString *)str withTag:(long)tag;
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err;

@end
