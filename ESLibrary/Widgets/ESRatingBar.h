//
//  ESRatingBar.h
//  ESLibraryFramework
//
//  Created by 杜明悦 on 2018/12/7.
//  Copyright © 2018年 杜明悦. All rights reserved.
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
#import "IStateProtected.h"
#import "Toast.h"
#import "ESView.h"
#import "DataType.h"
#import "DataTypeExpression.h"
#import "ESNSString.h"
#import "UIView+LayerEffects.h"
#import <ReactiveObjC/ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN
/**
 *  星级评分条代理
 */
@protocol RatingBarDelegate <NSObject>

/**
 *  评分改变
 *
 *  @param newRating 新的值
 */
- (void)ratingChanged:(float)newRating;

@end
@interface ESRatingBar : UIView<ICollectible,IReleasable,IValidatible,Initializble,IStateProtected,UITextFieldDelegate>

/**
 *  初始化设置未选中图片、半选中图片、全选中图片，以及评分值改变的代理（可以用
 *  Block）实现
 *
 *  @param deselectedName   未选中图片名称
 *  @param halfSelectedName 半选中图片名称
 *  @param fullSelectedName 全选中图片名称
 *  @param delegate          代理
 */
- (void)setImageDeselected:(NSString *)deselectedName halfSelected:(NSString *)halfSelectedName fullSelected:(NSString *)fullSelectedName andDelegate:(id<RatingBarDelegate>)delegate;

/**
 *  设置评分值
 *  @param rating 评分值
 */
- (void)displayRating:(float)rating;

@property (strong,nonatomic)IBInspectable UIImage *ratingUnSelectedImage;

@property (strong,nonatomic)IBInspectable UIImage *ratingHalfSelectedImage;

@property (strong,nonatomic)IBInspectable UIImage *ratingFullSelectedImage;

/**
 *  是否是指示器，如果是指示器，就不能滑动了，只显示结果，不是指示器的话就能滑动修改值
 *  默认为NO
 */
@property (nonatomic,assign) BOOL isIndicator;

/**
 设置或获取采集标记
 */
@property(nonatomic, copy)IBInspectable NSString* collectSign;

/**
 设置或获取UIView名称
 */
@property(nonatomic, copy)IBInspectable NSString *name;

/**
 设置或获取分数值
 */
@property(nonatomic)IBInspectable float rating;

/**
 设置或获取是否必填项
 */
@property(nonatomic)IBInspectable BOOL isRequired;

/**
 设置或获取当前占位提示
 **/
@property(retain,nonatomic)IBInspectable NSString *placeholder;

/**
 设置或获取数据类型
 */
@property(nonatomic)IBInspectable DataType dataType;

/**
 设置或获取UIView显示时的目标ID
 */
@property(nonatomic)IBInspectable NSString* stateHiddenId;

/**
 设置或获取UIView显示时的目标值
 */
@property(nonatomic)IBInspectable NSString* wantedStateValue;

/**
 设置或获取UIView对比类型，YES：条件全部满足才可以显示，NO：满足一个即可显示
 */
@property(nonatomic)IBInspectable BOOL wantedModeType;

/**
 设置或获取当前所属的视图控制器
 */
@property(retain,nonatomic)UIViewController* viewController;
@end

NS_ASSUME_NONNULL_END
