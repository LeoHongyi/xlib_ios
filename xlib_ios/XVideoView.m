//
//  XVideoView.m
//  JingMaoGC
//
//  Created by pengyunchou on 13-10-8.
//  Copyright (c) 2013年 skysent.cn. All rights reserved.
//

#import "XVideoView.h"
#import <QuartzCore/QuartzCore.h>
#import "AVFoundation/AVFoundation.h"

@interface XVideoView()
@property (nonatomic,strong)AVPlayer *player;
@end

@implementation XVideoView

-(void)playVideoWithURL:(NSURL *)url{
    AVAsset* avAsset = [AVAsset assetWithURL:url];
    AVPlayerItem* avPlayerItem =[[AVPlayerItem alloc]initWithAsset:avAsset];
    [self.player replaceCurrentItemWithPlayerItem:avPlayerItem];
    [self.player play];
}
-(void)setup{
    self.player=[[AVPlayer alloc] init];
    AVPlayerLayer* avPlayerLayer =[AVPlayerLayer playerLayerWithPlayer:self.player];
    [avPlayerLayer setFrame:self.frame];
    [self.layer addSublayer:avPlayerLayer];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:nil];
}
-(void)playerItemDidReachEnd:(NSNotification *)notification{
    [self.delegate xvideoview:self playStateChanged:xvideoview_state_stop para:nil];
}

@end
