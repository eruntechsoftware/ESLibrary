//
//  ESCheckBox.h
//  IndicatorPan
//
//  Created by 吕英良 on 2017/5/25.
//  Copyright © 2017年 吕英良. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<CoreText/CoreText.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "ICollectible.h"
#import "IReleasable.h"
#import "IValidatible.h"
#import "Validator.h"
#import "Initializble.h"
#import "Toast.h"
#import "ESView.h"
#import "DataType.h"
#import "DataTypeExpression.h"
#import "ESNSString.h"
#import "ESViewGroup.h"
#import "UIImage+ESImage.h"
@class ESViewGroup;

typedef void(^ESCheckBoxBlock)(BOOL isChecked);
@interface ESCheckBox : UIButton<IReleasable,Initializble>
{
    UIViewController* _viewController;
    UIImageView *_stateNormalImageView;
    UIImageView *_stateCheckedImageView;
    UIView *_viewGroup;
}

/**
 设置或获取采集标记
 */
@property(nonatomic, copy) NSString* collectSign;

/**
 设置或获取UIView名称
 */
@property(nonatomic, copy)IBInspectable NSString *name;

/**
 设置或获取控件值
 **/
@property(nonatomic, copy)IBInspectable NSString *value;

/**
 设置或获取当前所属的视图控制器
 **/
@property(retain,nonatomic)UIViewController* viewController;

/**
 设置或获取选中时的图片
 **/
@property(retain,nonatomic)IBInspectable UIImage *stateCheckedImage;

/**
 设置或获取未选中时的图片
 **/
@property(retain,nonatomic)IBInspectable UIImage *stateNormalImage;

/**
 设置或获取选中时颜色
 **/
@property(retain,nonatomic) UIColor *stateCheckedColor;

/**
 设置或获取选中时颜色
 **/
@property(retain,nonatomic) UIColor *stateNormalColor;

/**
 设置或获取选中状态
 **/
@property(nonatomic)IBInspectable BOOL checked;

/**
 设置或获取点击处理回调
 **/
@property (strong, nonatomic) ESCheckBoxBlock checkedBlock;

/**
 初始化事件
 **/
-(void)initializ;

-(void)setViewGroup:(id)viewGroup;

- (void)setTagWithChecked:(BOOL)checked;

@end
