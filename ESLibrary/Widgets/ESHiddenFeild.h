//
//  ESHiddenFeild.h
//  ESLibraryFramework
//
//  Created by 杜明悦 on 2018/10/29.
//  Copyright © 2018 杜明悦. All rights reserved.
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


NS_ASSUME_NONNULL_BEGIN

@interface ESHiddenFeild :UIButton<ICollectible,IReleasable,IValidatible,Initializble>
{
    Validator *_validator;
}

/**
 设置或获取采集标记
 */
@property(nonatomic, copy)IBInspectable NSString *collectSign;

/**
 设置或获取是否必填项
 */
@property(nonatomic)IBInspectable BOOL isRequired;

/**
 设置或获取正则表达式
 */
@property(copy, nonatomic)IBInspectable NSString *regularExpression;


/**
 设置或获取控件名
 **/
@property(nonatomic, copy)IBInspectable NSString *name;



/**
 设置或获取当前所属的视图控制器
 **/
@property(retain,nonatomic)UIViewController* viewController;

/**
 设置或获取当前占位提示
 **/
@property(retain,nonatomic)IBInspectable NSString *placeholder;

/**
 设置或获取当前占位提示颜色
 **/
@property(retain,nonatomic)IBInspectable UIColor *placeholderColor;

@end

NS_ASSUME_NONNULL_END
