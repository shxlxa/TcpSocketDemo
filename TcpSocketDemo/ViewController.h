//
//  ViewController.h
//  TcpSocketDemo
//
//  Created by aoni on 16/9/29.
//  Copyright © 2016年 aoni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TcpServer.h"
#import "TcpClient.h"
#import "ConnectionDef.h"

@interface ViewController : UIViewController

@property (nonatomic, retain) TcpServer *tcpServer;
@property (nonatomic, retain) TcpClient *tcpClient;

@property (weak, nonatomic) IBOutlet UITextField *serverSendTextField;
@property (strong, nonatomic) IBOutlet UIView *serverSendButton;
@property (weak, nonatomic) IBOutlet UITextField *clientSendTextField;
@property (weak, nonatomic) IBOutlet UIButton *clientSendButton;
- (IBAction)serverSendButtonClick:(id)sender;
- (IBAction)clientSendButtonClick:(id)sender;

@end

