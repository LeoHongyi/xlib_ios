//
//  XVideoView.h
//  JingMaoGC
//
//  Created by pengyunchou on 13-10-8.
//  Copyright (c) 2013年 skysent.cn. All rights reserved.
//

#import "XView.h"

@class XVideoView;

typedef enum{
    xvideoview_state_stop=1
} xvideoview_state;

@protocol XVideoViewDelegate <NSObject>
-(void)xvideoview:(XVideoView *)view playStateChanged:(xvideoview_state)state para:(id)para;
@end

@interface XVideoView : XView
@property (nonatomic,strong)id<XVideoViewDelegate> delegate;
-(void)playVideoWithURL:(NSURL *)url;
@end
