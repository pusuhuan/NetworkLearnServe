//
//  Server.m
//  NetworkLearnServe
//
//  Created by iceman on 16/5/31.
//  Copyright © 2016年 iceman. All rights reserved.
//

#import "Server.h"
#import <sys/socket.h>
#import <netdb.h>
#import        "IPManager.h"

@interface Server()

@property (nonatomic ,assign) int socketFD;

@end


@implementation Server


- (void)open
{
    int err;
    _socketFD = socket(AF_INET, SOCK_STREAM, 0);
    BOOL success=(_socketFD!=-1);
    //        1
    
    //   2
    if (success) {
        NSLog(@"socket success");
        struct sockaddr_in addr;
        memset(&addr, 0, sizeof(addr));
        addr.sin_len=sizeof(addr);
        addr.sin_family=AF_INET;
        //          ==========================================================================
        addr.sin_port=htons(1025);
        //          ==========================================================================
        addr.sin_addr.s_addr=INADDR_ANY;
        err=bind(_socketFD, (const struct sockaddr *)&addr, sizeof(addr));
        success=(err==0);
    }
    //   2
    
    
    //        ============================================================================
    if (success) {
        NSLog(@"bind(绑定) success");
        NSLog([IPManager deviceIPAdress]);
        err=listen(_socketFD, 5);//开始监听
        success=(err==0);
    }
    //    ============================================================================
    
    //3
    if (success) {
        NSLog(@"listen success");
        while (true) {
            struct sockaddr_in peeraddr;
            int peerfd;
            socklen_t addrLen;
            addrLen=sizeof(peeraddr);
            NSLog(@"prepare accept");
            peerfd=accept(_socketFD, (struct sockaddr *)&peeraddr, &addrLen);
            success=(peerfd!=-1);
            //    ============================================================================
            if (success) {
                char buf[1024] = "12341234567aaaa";
                ssize_t count;
                size_t len=sizeof(buf);
                do {
                    count=recv(peerfd, buf, len, 0);
                    NSString* str = [NSString stringWithCString:buf encoding:NSUTF8StringEncoding];
                    NSLog(@"%@",str);
                } while (strcmp(buf, "exit")!=0);
            }
            //    ============================================================================
            close(peerfd);
        }
    }
    //3
}

@end
