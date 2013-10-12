//
//  UIView+frame.m
//  JingMaoGC
//
//  Created by pengyunchou on 13-10-11.
//  Copyright (c) 2013年 skysent.cn. All rights reserved.
//

#import "UIView+frame.h"
#import <objc/runtime.h>


@implementation UIView (frame)
@dynamic destframe;
@dynamic oldframe;

-(void)setX:(float)x{
    self.frame=CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}
-(float)x{
    return self.frame.origin.x;
}
-(void)setY:(float)y{
    self.frame=CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}
-(float)y{
    return self.frame.origin.y;
}

-(void)setW:(float)w{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, w ,self.frame.size.height);
}
-(float)w{
    return self.frame.size.width;
}
-(void)setH:(float)h{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width ,h);
}
-(float)h{
    return self.frame.size.height;
}
@end
