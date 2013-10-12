//
//  xauth.m
//  JingMaoGC
//
//  Created by pengyunchou on 13-10-8.
//  Copyright (c) 2013年 skysent.cn. All rights reserved.
//

#import "xauth.h"

@implementation xauth
-(void)start_auth{
    
}
-(void)begin{
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self start_auth];
    });
}
+(xauth *)sharedInstanse{
    static xauth* _xauth=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _xauth=[[xauth alloc] init];
    });
    return _xauth;
}
@end
