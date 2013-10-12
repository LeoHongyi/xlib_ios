//
//  XImageFlowView.h
//  JingMaoGC
//
//  Created by pengyunchou on 13-10-8.
//  Copyright (c) 2013年 skysent.cn. All rights reserved.
//

#import "XView.h"
@class XImageFlowView;


typedef enum{
    ximageflowview_action_touched
} ximageflowview_action;

@protocol XImageFlowViewDelegate <NSObject>

-(void)ximageflowview:(XImageFlowView *)fv onAction:(ximageflowview_action)action;

@end

@interface XImageFlowView : XView
@property BOOL isPlaying;
@property BOOL touchEnable;
@property (nonatomic,strong)id<XImageFlowViewDelegate> delegate;
-(void)setWithImages:(NSArray *)images speed:(float) speed loop:(BOOL)isloop;
-(void)play;
-(void)pause;
-(void)resume;
-(void)stop;
@end
