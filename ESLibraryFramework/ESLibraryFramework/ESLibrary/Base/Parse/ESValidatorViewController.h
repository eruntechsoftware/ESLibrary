//
//  ValidatorForm.h
//  Eruntech
//
//  Created by 杜明悦 on 12-11-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IControlSearcherHandler.h"
#import "IValidator.h"
#import "IValidatible.h"
#import "ESControlSearcher.h"
@interface ESValidatorViewController : NSObject<IControlSearcherHandler, IValidator> {
    UIViewController *_viewController;
    BOOL _result;
}

/**
 设置或获取视图控制器
 **/
@property(nullable,nonatomic, retain)UIViewController *viewController;

/**
 初始化数据校验控制器
 @param viewController 当前视图控制器
 @return 数据校验控制器
 **/
-(nonnull id) initWithViewController:(nonnull UIViewController*)viewController;

/**
 数据校验方法，uiView控件校验错误返回FALSE
 @return 校验错误返回
 **/
-(BOOL) validator;

/**
 循环基类实现接口，循环接口调用此接口实现方法
 @param obj uiview对象
 **/
-(void) handle:(nonnull id)obj;

/**
 循环基类实现接口，调用此方法实现，以决定是否继续执行
 @param obj 采集对象
 @return 是否继续执行
 **/
-(BOOL) isPicked:(nonnull id)obj;
@end
