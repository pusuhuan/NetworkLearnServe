//
//  ViewController.m
//  NetworkLearnServe
//
//  Created by iceman on 16/5/27.
//  Copyright © 2016年 iceman. All rights reserved.
//

#import "ViewController.h"
#import "AsyncSocket.h"

@interface ViewController ()

@property (nonatomic,strong)AsyncSocket *serverSocket;
@property (nonatomic,strong)NSMutableArray *socketArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createService];
}

-(void)createService
{
    _serverSocket=[[AsyncSocket alloc] initWithDelegate:self];
    //开始监听有没有客服端来接连
    [_serverSocket acceptOnPort:1025 error:nil];
}

//当客户端来连接时, newSocket 是新生成的套接字，和客户端连接
-(void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket
{
    [self.socketArray addObject:newSocket];
    
    //等待客户端发送消息
    [newSocket readDataWithTimeout:-1 tag:0];//表示一直等客户端发送消息
}

//当接受到客户端发送的消息
-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
    NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //继续监听客户端发送的消息
    [sock readDataWithTimeout:-1 tag:0];
}



- (IBAction)connnect:(id)sender
{
//    _clientSocket=[[AsyncSocket alloc] initWithDelegate:self];
//    //如果客户端已经连接，先断开
//    if (_clientSocket.isConnected) {
//        [_clientSocket disconnect];
//    }
//    //连接
//    [_clientSocket connectToHost:self.iptext.text onPort:[self.port.text integerValue] error:nil];
}
//连接成功
-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    
    NSLog(@"连接成功！");
}


- (IBAction)send:(id)sender
{
//    NSData *data=[self.content.text dataUsingEncoding:NSUTF8StringEncoding];
//    
//    [_clientSocket writeData:data withTimeout:10 tag:0];
}
-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"发送成功");
//    [self.contenStr appendString:[NSString stringWithFormat:@"我：%@\n",self.content.text]];
//    self.showTextView.text=self.contenStr;
//    self.content.text=@"";
}
@end
