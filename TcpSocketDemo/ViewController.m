//
//  ViewController.m
//  TcpSocketDemo
//
//  Created by aoni on 16/9/29.
//  Copyright © 2016年 aoni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tcpServer = [[TcpServer alloc] init];
    _tcpClient = [[TcpClient alloc] init];
    [_tcpServer createTcpSocket:SERVER_QUEUE acceptOnPort:SERVER_PORT];
    
    [_tcpClient createTcpSocket:CLIENT_QUEUE connectToHost:SERVER_ADDRESS onPort:SERVER_PORT];
}

- (IBAction)serverSendButtonClick:(id)sender {
    [_tcpServer broadcastStr:_serverSendTextField.text];
}

- (IBAction)clientSendButtonClick:(id)sender {
    [_tcpClient writeString:_clientSendTextField.text withTag:[_tcpClient getWriteTag]];
}

@end
