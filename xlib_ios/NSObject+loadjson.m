//
//  NSObject+loadjson.m
//  SHIJIABIEYUAN
//
//  Created by Peng Yunchou on 13-8-22.
//  Copyright (c) 2013年 Peng Yunchou. All rights reserved.
//

#import "NSObject+loadjson.h"
#import "JSONKit.h"
@implementation NSObject (loadjson)
-(id)loadJson:(NSString *)filename{
    NSString *path=[[NSBundle mainBundle] pathForResource:filename ofType:@"json"];
    NSString *content=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return [content objectFromJSONString];
}
@end
