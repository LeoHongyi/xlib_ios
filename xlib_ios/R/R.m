//
//  R.m
//  JingMaoGC
//
//  Created by pengyunchou on 13-10-8.
//  Copyright (c) 2013年 skysent.cn. All rights reserved.
//

#import "R.h"

@implementation R
+(NSString *)pathForName:(NSString *)name type:(NSString *)atype{
    return [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"resourse.bundle/%@",name] ofType:atype];
}
@end
