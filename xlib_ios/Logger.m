//
//  Person.m
//  LibDemo
//
//  Created by pengyunchou on 14-4-3.
//  Copyright (c) 2014年 pengyunchou. All rights reserved.
//

#import "Logger.h"
#import <UIKit/UIKit.h>
@interface Logger()
@property (nonatomic,strong)NSDateFormatter *dateformate;
@property (nonatomic,strong)NSArray* levelstrs;
@property (nonatomic,strong)dispatch_queue_t logqueue;
@property FILE *logfile;
@end
@implementation Logger
+(void)load{
    [super load];
#ifdef KDefaultHandlCrash
    [self handleCrash];
#endif
}
-(void)setLogpath:(NSString *)logpath{
    [self closeOutputStream];
    self.logfile=fopen([logpath UTF8String], "a+");
    if (self.logfile==NULL) {
        NSLog(@"open log file error:%@",logpath);
    }else{
        fprintf(self.logfile, "\n#[%s]open logfile.\n",[[self getTime] UTF8String]);
    }
}
void __uncaughtExceptionHandler(NSException* exception)
{
    NSString* name = [exception name];
    NSString* reason = [exception reason];
    NSArray* symbols = [exception callStackSymbols]; // 异常发生时的调用栈
    NSMutableString* strSymbols = [[NSMutableString alloc] init ]; //将调用栈拼成输出日志的字符串
    for ( NSString* item in symbols )
    {
        [strSymbols appendString: item];
        [strSymbols appendString: @"\r\n" ];
    }
    //将crash日志保存到Document目录下,默认文件名称为crash.log
    NSString *logFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/crash.log"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    NSString *crashString = [NSString stringWithFormat:@"%@ [ Uncaught Exception ]\r\nName: %@, Reason: %@\r\n[Symbols start]\r\n%@[Symbols End]\r\n\r\n", dateStr, name, reason, strSymbols];
    [crashString writeToFile:logFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

-(NSString *)getTime{
    //return [NSString stringWithFormat:@"%u",(unsigned)time(NULL)];
    return [self.dateformate stringFromDate:[NSDate date]];
}
/*
 * formate thread name.
 * if a thread name is not set,return 'noname'
 */
-(NSString *)threadName{
    NSThread *t=[NSThread currentThread];
    if ([t isMainThread]) {
        return @"main";
    }else{
        if (t.name!=nil&t.name.length>0) {
            return t.name;
        }else{
            return @"noname";
        }
    }
}
-(NSString *)levelToString:(KLogLevel )level{
    return self.levelstrs[level];
}
+(void)handleCrash{
    NSSetUncaughtExceptionHandler (&__uncaughtExceptionHandler);
}

-(void)logLevel:(KLogLevel)level message:(NSString *)fmt,...{
    va_list args;
    va_start(args, fmt);
    NSString* msgString=[[NSString alloc] initWithFormat:fmt arguments:args];
    dispatch_async(self.logqueue, ^{
        //if can write file, we write to file fist
        if (self.logfile!=NULL) {
            fprintf(self.logfile, "%s",[msgString UTF8String]);
        //can not write to file,we pirnt to stderr
        }else{
           fprintf(stderr, "%s",[msgString UTF8String]);
        }
    });
    va_end(args);
}
-(id)init{
    self=[super init];
    if (self) {
        self.logqueue=dispatch_queue_create("klog.queue", DISPATCH_QUEUE_SERIAL);
        self.levelstrs=@[
                         @"DBG",
                         @"INF",
                         @"WAR",
                         @"ERR"
                         ];
        self.dateformate=[[NSDateFormatter alloc] init];
        [self.dateformate setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appwillExit:) name:UIApplicationWillTerminateNotification object:nil];
    }
    return self;
}
-(void)appwillExit:(NSNotification *)notification{
    [self closeOutputStream];
}
-(void)closeOutputStream{
    if (self.logfile!=NULL) {
        fprintf(self.logfile, "\n#[%s]close logfile.\n",[[self getTime] UTF8String]);
        fflush(self.logfile);
        fclose(self.logfile);
        self.logfile=NULL;
    }
}
-(void)dealloc{
    [self closeOutputStream];
}
+(Logger *)defaultLoger{
    static Logger* p;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        p=[[Logger alloc] init];
    });
    return p;
}
@end
