//
//  XImageFlowView.m
//  JingMaoGC
//
//  Created by pengyunchou on 13-10-8.
//  Copyright (c) 2013年 skysent.cn. All rights reserved.
//

#import "XImageFlowView.h"

@interface XImageFlowView()
@property (nonatomic,strong)UIImageView *imageview;
@property (nonatomic,strong)NSArray* images;
@property int currentIndex;
@property float speed;
@property BOOL loop;
@property (nonatomic,strong)NSTimer* playTimer;

@end

@implementation XImageFlowView

-(void)setWithImages:(NSArray *)images speed:(float) speed loop:(BOOL)isloop{
    self.images=images;
    self.speed=speed;
    self.loop=isloop;
    self.currentIndex=0;
    if ([self.images count]>0) {
        self.imageview.image=[UIImage imageWithContentsOfFile:
                              [self.images objectAtIndex:self.currentIndex]];
    }
}
-(void)onTimer:(NSTimer *)timer{
    if (!self.isPlaying) {
        return;
    }
    if (self.currentIndex>=[self.images count]) {
        self.currentIndex=0;
    }
    NSString *imagepath=[self.images objectAtIndex:self.currentIndex];
    self.imageview.image=[UIImage imageWithContentsOfFile:
                          imagepath];
    self.currentIndex++;
}
-(void)play{
    if (self.playTimer==nil) {
        self.playTimer=[NSTimer scheduledTimerWithTimeInterval:self.speed target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
        self.isPlaying=YES;
    }
}
-(void)pause{
    self.isPlaying=NO;
}
-(void)resume{
    self.isPlaying=YES;
}
-(void)stop{
    self.isPlaying=NO;
    [self.playTimer invalidate];
    self.playTimer=nil;
}
-(void)setTouchEnable:(BOOL)touchEnable{
    [self.imageview setUserInteractionEnabled:touchEnable];
    [self.imageview setMultipleTouchEnabled:touchEnable];
}
-(BOOL)touchEnable{
    return [self.imageview isUserInteractionEnabled];
}
-(void)setup{
    self.imageview=[[UIImageView alloc] initWithFrame:self.bounds];
    self.imageview.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.imageview.backgroundColor=[UIColor redColor];
    [self addSubview:self.imageview];
}


@end
