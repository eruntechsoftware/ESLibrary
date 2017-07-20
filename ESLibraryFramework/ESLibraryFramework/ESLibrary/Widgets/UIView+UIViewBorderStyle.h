//
//  UIView+UIViewBorderStyle.h
//
//  Created by 松洋 on 2017/6/26.
//  Copyright © 2017年 com.du. All rights reserved.
//  扩展UIView，设置边界样式和阴影样式

#import <UIKit/UIKit.h>

@interface UIView (UIViewBorderStyle)


/**
 设置uiview的边框宽度，颜色，圆角读书
  @param borderWidth 边框宽度
  @param borderColor 边框颜色
  @param cornerRadius 圆角读书
 */
-(void) setBorderStyleWithBorderWidth:(CGFloat) borderWidth _borderColor:(UIColor*) borderColor _cornerRadius:(CGFloat) cornerRadius;

/**
 设置阴影效果
 @param shadowOffset 偏移量（>1）
 @param shadowOpacity 透明度（0-1）
 @param shadowRadius 阴影圆角度数
 @param shadowColor 阴影颜色
 */
-(void)setShadowStyleWithShadowOffset:(CGFloat) shadowOffset _shadowOpacity:(CGFloat) shadowOpacity _shadowRadius:(CGFloat) shadowRadius _shadowColor:(UIColor*) shadowColor;
@end
