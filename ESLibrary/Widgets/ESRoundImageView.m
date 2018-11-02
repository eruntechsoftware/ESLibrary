//
//  RoundImageView.m
//  Neighbour
//
//  Created by 杜明悦 on 2016/10/24.
//  Copyright © 2016年 杜明悦. All rights reserved.
//

#import "ESRoundImageView.h"

@implementation ESRoundImageView

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    [self setContentMode:UIViewContentModeScaleAspectFill];
    self.clipsToBounds = YES;
//    self.frame = CGRectMake(0, 0, 50, 50);
    //缓存渲染
    self.layer.shouldRasterize = YES;
    //边缘抗锯齿处理
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    CGFloat radius = self.bounds.size.width/2;
    self.layer.cornerRadius=radius;
    self.layer.masksToBounds=YES;
    self.layer.borderWidth=0.2;
    self.layer.borderColor=[UIColor lightGrayColor].CGColor;
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    //缓存渲染
    self.layer.shouldRasterize = YES;
    //边缘抗锯齿处理
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.cornerRadius=frame.size.height/2;
    self.layer.masksToBounds=YES;
    self.layer.borderWidth=0.2;
    self.layer.borderColor=[UIColor lightGrayColor].CGColor;
    return self;
}

@end
