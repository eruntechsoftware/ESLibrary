//
//  UIView+UIViewBorderStyle.m
//  MvvmTest2
//
//  Created by 松洋 on 2017/6/26.
//  Copyright © 2017年 com.du. All rights reserved.
//  扩展UIView，设置边界样式和阴影样式

#import "UIView+UIViewBorderStyle.h"

@implementation UIView (UIViewBorderStyle)

/**
 设置uiview的边框宽度，颜色，圆角读书
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @param cornerRadius 圆角读书
 **/
-(void) setBorderStyleWithBorderWidth:(CGFloat) borderWidth _borderColor:(UIColor*) borderColor _cornerRadius:(CGFloat) cornerRadius{

    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
}

/**
 设置阴影效果
 @param shadowOffset 偏移量（>1）
 @param shadowOpacity 透明度（0-1）
 @param shadowRadius 阴影圆角度数
 @param shadowColor 阴影颜色
 **/
-(void)setShadowStyleWithShadowOffset:(CGFloat) shadowOffset _shadowOpacity:(CGFloat) shadowOpacity _shadowRadius:(CGFloat) shadowRadius _shadowColor:(UIColor*) shadowColor{

    self.layer.shadowColor = shadowColor.CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(shadowOffset,shadowOffset);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = shadowOpacity;//阴影透明度，默认0
    self.layer.shadowRadius = shadowRadius;//阴影半径，默认3

}

@end
