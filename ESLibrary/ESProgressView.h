//
//  ESProgressView.h
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

@interface ESProgressView : UIProgressView<ICollectible,IReleasable,IValidatible,Initializble,IStateProtected,UITextFieldDelegate>
/**
 设置或获取采集标记
 */
@property(nonatomic, copy)IBInspectable NSString* collectSign;

/**
 设置或获取UIView名称
 */
@property(nonatomic, copy)IBInspectable NSString *name;

/**
 设置或获取进度条最大值
 */
@property(nonatomic)IBInspectable float maxValue;

/**
 设置或获取进度值
 */
@property(nonatomic)IBInspectable float progressValue;

/**
 设置或获取进度条高度
 */
@property(nonatomic)IBInspectable float progressHeight;

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
