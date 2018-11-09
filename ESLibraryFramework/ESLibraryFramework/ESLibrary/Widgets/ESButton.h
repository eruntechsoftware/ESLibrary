//
//  ESButton.h
//  Neighbour
//
//  Created by 杜明悦 on 2016/10/15.
//  Copyright © 2016年 杜明悦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESNSString.h"
#import "ESView.h"
#import "UIButton+Bootstrap.h"

IB_DESIGNABLE
@interface ESButton : UIButton
{
    
}

/**
 设置或获取控边框宽度
 */
@property(nonatomic, assign)IBInspectable CGFloat borderWidth;

/**
 设置或获取控边框颜色
 */
@property(nonatomic, assign)IBInspectable UIColor *borderColor;

/**
 设置或获取控圆角角度
 */
@property(nonatomic, assign)IBInspectable CGFloat cornerRadius;

/**
 设置或获取控阴影透明度
 */
@property(nonatomic, assign)IBInspectable CGFloat shadowOpacity;

/**
 设置或获取控阴影颜色
 */
@property(nonatomic, assign)IBInspectable  UIColor *shadowColor;

/**
 设置或获取控标题颜色
 */
@property(nonatomic, assign)IBInspectable  UIColor *titleNormalColor;

/**
 设置或获取控标题高亮颜色
 */
@property(nonatomic, assign)IBInspectable  UIColor *titleHighlightedColor;

/**
 设置或获取控背景颜色
 */
@property(nonatomic, assign)IBInspectable  UIColor *backgroundNormalColor;

/**
 设置或获取控背景高亮颜色
 */
@property(nonatomic, assign)IBInspectable  UIColor *backgroundHighlightedColor;

-(void)applyStyle;
@end
