//
//  xauth.h
//  JingMaoGC
//
//  Created by pengyunchou on 13-10-8.
//  Copyright (c) 2013年 skysent.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

#define xauth_notification @"xauth_notification"

typedef enum{
    xauth_status_fail=0,
    xauth_status_success=1
} xauth_status;

@interface xauth : NSObject
+(xauth *)sharedInstanse;
-(void)begin;
@end
