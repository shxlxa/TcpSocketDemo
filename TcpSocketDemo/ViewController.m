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
    
   id result = [self getJsonDataJsonname:nil];
    
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

- (id)getJsonDataJsonname:(NSString *)jsonname
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"imageJson" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonData || error) {
        //DLog(@"JSON解码失败");
        return nil;
    } else {
        return jsonObj;
    }
}

- (IBAction)serverSendButtonClick:(id)sender {
    [_tcpServer broadcastStr:_serverSendTextField.text];
}

- (IBAction)clientSendButtonClick:(id)sender {
    [_tcpClient writeString:_clientSendTextField.text withTag:[_tcpClient getWriteTag]];
}

@end
