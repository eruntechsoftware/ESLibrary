//
//  PlaceholderTextView.h
//  SaleHelper
//
//  Created by gitBurning on 14/12/8.
//  Copyright (c) 2014年 Burning_git. All rights reserved.
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
#import <ReactiveObjC/ReactiveObjC.h>


IB_DESIGNABLE
@interface ESTextView : UITextView<ICollectible,IReleasable,IValidatible,Initializble>
{
    NSString * _collectSign;
    BOOL _isRequired;
    NSString * _name;
    DataType _dataType;
//    NSString *_isRequiredTooltip;
    UIImage *_isRequiredimage;
    CGContextRef _context;
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
 设置或获取占位符提示
 */
@property(copy,nonatomic)IBInspectable NSString *placeholder;

/**
 设置或获取占位符颜色
 */
@property(strong,nonatomic)IBInspectable UIColor *placeholderColor;

/**
 设置或获取占位符提示字体
 */
@property(strong,nonatomic)IBInspectable UIFont * placeholderFont;

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
@property(nonatomic)IBInspectable BOOL *wantedModeType;

/**
 杜明悦
 初始化方法
 */
-(void)initializ;

/**
 杜明悦
 添加事件
 */
-(void) addEvent;

/**
 杜明悦
 获取采集标记名
 */
-(NSArray*) getRequest;

/**
 杜明悦
 将数据发布到指定位置
 @param dataName 数据名称
 @param data 数据对象
 */
-(void) release:(NSString *)dataName data:(Data *)data;

/**
 杜明悦
 获取控件名
 */
-(NSString*) getName;


/**
 杜明悦
 数据收集，返回ETDataCollection
 */
-(DataCollection*) collect;

/**
 杜明悦
 获取收集标记集合，返回NSString[]
 */
-(NSString *) getCollectSign;

/**
 杜明悦
 设置采集标记，多个标记以‘|!’分割
 例如：ForSave|!ForQuery
 @param sign 采集标记
 */
-(void) setCollectSign:(NSString*) sign;

/**
 杜明悦
 数据校验，验证输入内容合法性
 */
-(BOOL) dataValidator;

/**
 隐藏占位符提示
 */
-(void) placeholderHidden;
@end
