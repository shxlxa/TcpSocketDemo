//
//  TcpClient.m
//  TcpSocketDemo
//
//  Created by aoni on 16/9/29.
//  Copyright © 2016年 aoni. All rights reserved.
//

#import "TcpClient.h"

@implementation TcpClient

-(long)getReadTag {
    return readTag++;
}

-(long)getWriteTag {
    return writeTag++;
}

-(void)createTcpSocket:(const char *)queueName connectToHost:(NSString *) host onPort:(uint16_t)port {
    dispatch_queue_t dispatchQueue = dispatch_queue_create(queueName, NULL);
    clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatchQueue];
    [clientSocket connectToHost:host onPort:port withTimeout:CONNECT_TIMEOUT  error:nil];
}

-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"client didConnectToHost [%@:%d]", host, port);
    [sock readDataWithTimeout:READ_TIMEOUT tag:[self getReadTag]];
}

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSString *ip = [sock connectedHost];
    uint16_t port = [sock connectedPort];
    NSString *str = [[NSString alloc] initWithData:data encoding:DEF_STR_ENCODING];
    NSLog(@"client didReadData [%@:%d] %@", ip, port, str);
    if (self.clientComplection) {
        self.clientComplection(str);
    }
}

-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    NSString *ip = [sock connectedHost];
    uint16_t port = [sock connectedPort];
    NSLog(@"client didWriteDataWithTag [%@:%d]", ip, port);
    
}

-(void)writeString:(NSString *)str withTag:(long)tag {
    NSData *data = [str dataUsingEncoding:DEF_STR_ENCODING];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"imageJson" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    [clientSocket writeData:jsonData withTimeout:WRITE_TIMEOUT tag:[self getWriteTag]];
}

-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    NSString *ip = [sock connectedHost];
    uint16_t port = [sock connectedPort];
    NSLog(@"client socketDidDisconnect [%@:%d]", ip, port);
    //可以在这边实现断线重连机制
}

@end
