//
//  UITextBox.h
//  Eruntech
//
//  Created by 杜明悦 on 12-10-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
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
#import "UIView+Toast.h"
#import "ESView.h"
#import "DataType.h"
#import "DataTypeExpression.h"
#import "ESNSString.h"
#import <ReactiveObjC/ReactiveObjC.h>

IB_DESIGNABLE
@interface ESTextField : UITextField<ICollectible,IReleasable,IValidatible,Initializble>
{
    CGContextRef _context;
    Validator *_validator;
    UIImage *_isRequiredimage;
    NSMutableString * _collectSign;
    BOOL _isRequired;
    NSString * _name;
    UIViewController* _viewController;
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
 设置或获取控件名
 */
@property(nonatomic, copy)IBInspectable NSString *name;

/**
 设置或获取非空提示信息
 */
//@property(nonatomic, copy)IBInspectable NSString *isRequiredTooltip;

//@property(assign,nonatomic) NSInteger dataTypeValue;

/**
 设置或获取正则表达式校验错误提示
 */
//@property(copy, nonatomic)IBInspectable NSString *regularTooltip;

/**
 设置或获取正则表达式
 */
@property(copy, nonatomic)IBInspectable NSString *regularExpression;

/**
 设置或获取绘图设备上下文
 */
@property(nonatomic) CGContextRef context;

/**
 设置或获取数据类型
 */
@property(assign, nonatomic) DataType dataType;

/**
 设置或获取当前所属的视图控制器
 */
@property(retain,nonatomic)UIViewController* viewController;

/**
 获取当前文本控件的错误提示
 */
//@property(retain,nonatomic)UIButton* btnErrorMessage;

/**
 设置或获取当前占位提示颜色
 @property(retain,nonatomic)IBInspectable UIColor *placeholderColor;
 */

/**
 非空校验提示
 */
@property(retain,nonatomic)UIImageView *requiredImageView;

/**
 数据校验错误提示
 */
@property(retain,nonatomic)UIImageView *errorImageView;
/**
 初始化方法
 */
-(void)initializ;

/**
 添加事件
 */
-(void) addEvent;

/**
 获取采集标记名
 */
-(NSArray*) getRequest;

/**
 将数据发布到指定位置
 @param dataName 数据名称
 @param data 数据对象
 */
-(void) release:(NSString *)dataName data:(Data *)data;

/**
 获取控件名
 */
-(NSString*) getName;


/**
 数据收集，返回ETDataCollection
 */
-(DataCollection*) collect;

/**
 获取收集标记集合，返回NSString[]
 */
-(NSString *) getCollectSign;

/**
 设置采集标记，多个标记以‘|!’分割
 例如：ForSave|!ForQuery
 @param sign 采集标记
 */
-(void) setCollectSign:(NSMutableString*) sign;

/**
 数据校验，验证输入内容合法性
 */
-(BOOL) dataValidator;

/**
 * 提示校验错误
 * **/
-(void) hint;

@end
