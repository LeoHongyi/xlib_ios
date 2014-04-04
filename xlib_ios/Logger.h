//
//  Person.h
//  LibDemo
//
//  Created by pengyunchou on 14-4-3.
//  Copyright (c) 2014年 pengyunchou. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 * common log function
 * @parameter category - log cateogry
 * @parameter level - log level
 * @parameter fmt -log formate string
 * @parameter other format values
 */
#define KLog(category,level,fmt,...) do{[[Logger defaultLoger] logLevel:KLogLevelDebug message:(@"%@ [%@] %@ [%@] %@[%d] " fmt @"\n"),[[Logger defaultLoger] getTime],category,[[Logger defaultLoger] levelToString:level],[[Logger defaultLoger] threadName],[[NSString stringWithFormat:@"%s",__FILE__] lastPathComponent],__LINE__,##__VA_ARGS__];}while(0)

typedef enum{
    KLogLevelDebug=0x01,
    KLogLevelInfo=0x02,
    KLogLevelWarning=0x03,
    KLogLevelError=0x04
}KLogLevel;
@interface Logger : NSObject
@property (nonatomic,strong)NSString* logpath;
/**
 *
 *convert to level to level string.
 */
-(NSString *)levelToString:(KLogLevel )level;
-(void)logLevel:(KLogLevel)level message:(NSString *)vString,...;
/*
 * get log time
 * you can set time format by setting a NSDateformater to Loger.
 * default time formater is yyyy/MM/dd hh:mm:ss
 */
-(NSString *)getTime;
/*
 * formate thread name.
 * if a thread name is not set,return 'noname'
 */
-(NSString *)threadName;
+(Logger *)defaultLoger;
@end

#ifndef KeepNSLog
#define NSLog(...) KLog(@"nslog",KLogLevelDebug,__VA_ARGS__)
#endif

/*
 *KLogI: Info log
 */
#define KLogI(...) KLog(@"default",KLogLevelInfo,__VA_ARGS__)
/*
 *KLogA: Debug log
 */
#define KLogD(...) KLog(@"default",KLogLevelDebug,__VA_ARGS__)

/*
 *KLogA: Warmming log
 */
#define KLogW(...) KLog(@"default",KLogLevelWarning,__VA_ARGS__)
/*
 *KLogA: Error log
 */
#define KLogE(...) KLog(@"default",KLogLevelError,__VA_ARGS__)
