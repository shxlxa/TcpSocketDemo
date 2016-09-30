//
//  ViewController.m
//  TcpSocketDemo
//
//  Created by aoni on 16/9/29.
//  Copyright © 2016年 aoni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelServer;
@property (weak, nonatomic) IBOutlet UILabel *labelClient;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tcpServer = [[TcpServer alloc] init];
    _tcpClient = [[TcpClient alloc] init];
    [_tcpServer createTcpSocket:SERVER_QUEUE acceptOnPort:SERVER_PORT];
    
    [_tcpClient createTcpSocket:CLIENT_QUEUE connectToHost:SERVER_ADDRESS onPort:SERVER_PORT];
    
    __weak typeof(self)  weakSelf = self;
     _tcpServer.serverComplection=^(NSString *receiveStr){
         dispatch_async(dispatch_get_main_queue(), ^{
             weakSelf.labelServer.text = receiveStr;
         });
    };
    
    _tcpClient.clientComplection = ^(NSString *receiveStr){
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.labelClient.text = receiveStr;
        });
    };
    
}

- (IBAction)serverSendButtonClick:(id)sender {
    [_tcpServer broadcastStr:_serverSendTextField.text];
}

- (IBAction)clientSendButtonClick:(id)sender {
    [_tcpClient writeString:_clientSendTextField.text withTag:[_tcpClient getWriteTag]];
}

@end
