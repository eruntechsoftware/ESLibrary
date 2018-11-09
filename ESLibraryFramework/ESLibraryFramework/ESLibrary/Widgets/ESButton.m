//
//  ESButton.m
//  Neighbour
//
//  Created by 杜明悦 on 2016/10/15.
//  Copyright © 2016年 杜明悦. All rights reserved.
//

#import "ESButton.h"

@implementation ESButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

-(void)applyStyle
{
    if(self)
    {
        self.layer.borderWidth = _borderWidth;
        self.layer.cornerRadius = _cornerRadius;
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        self.layer.borderColor = [self borderColor].CGColor;
        
        [self setAdjustsImageWhenHighlighted:NO];
        
        self.layer.shadowOffset =  CGSizeMake(3, 5);
        self.layer.shadowOpacity = _shadowOpacity;
        self.layer.shadowColor =  [self shadowColor].CGColor;
        
        [self setBackgroundImage:[self buttonImageFromColor:[self backgroundNormalColor]] forState:UIControlStateNormal];
        [self setBackgroundImage:[self buttonImageFromColor:[self backgroundHighlightedColor]] forState:UIControlStateHighlighted];
        
        self.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1] CGColor];
    }
}

-(UIColor*)backgroundNormalColor
{
    if(_backgroundNormalColor==nil)
    {
        return UIColor.whiteColor;
    }
    return _backgroundNormalColor;
}

- (UIColor *)backgroundHighlightedColor
{
    if(_backgroundHighlightedColor==nil)
    {
        return UIColor.whiteColor;
    }
    return _backgroundHighlightedColor;
}

- (UIColor *)shadowColor
{
    if(_shadowColor==nil)
    {
        return UIColor.clearColor;
    }
    return _shadowColor;
}

- (UIColor *)borderColor
{
    if(_borderColor==nil)
    {
        return UIColor.whiteColor;
    }
    return _borderColor;
}

@end
