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
#import "UIView+Toast.h"
#import "ESView.h"
#import "DataType.h"
#import "DataTypeExpression.h"
#import "ESNSString.h"

@interface ESCheckBox : UIButton<ICollectible,IReleasable,IValidatible,Initializble>
{
    UIViewController* _viewController;
}


/**
 设置或获取采集标记
 **/
@property(nonatomic, copy)IBInspectable NSString *collectSign;


/**
 设置或获取控件名
 **/
@property(nonatomic, copy)IBInspectable NSString *name;



/**
 设置或获取当前所属的视图控制器
 **/
@property(retain,nonatomic)UIViewController* viewController;

/**
 设置或获取当前占位提示颜色
 **/
@property(retain,nonatomic)IBInspectable UIColor *placeholderColor;

/**
 初始化方法
 **/
-(void)initializ;

/**
 添加事件
 **/
-(void) addEvent;

/**
 获取采集标记名
 **/
-(NSArray*) getRequest;

/**
 将数据发布到指定位置
 @param dataName 数据名称
 @param data 数据对象
 **/
-(void) release:(NSString *)dataName data:(Data *)data;

/**
 获取控件名
 **/
-(NSString*) getName;


/**
 数据收集，返回ETDataCollection
 **/
-(DataCollection*) collect;

/**
 获取收集标记集合，返回NSString[]
 **/
-(NSString *) getCollectSign;

/**
 设置采集标记，多个标记以‘|!’分割
 例如：ForSave|!ForQuery
 @param sign 采集标记
 **/
-(void) setCollectSign:(NSMutableString*) sign;

/**
 数据校验，验证输入内容合法性
 **/
-(BOOL) dataValidator;

@end
