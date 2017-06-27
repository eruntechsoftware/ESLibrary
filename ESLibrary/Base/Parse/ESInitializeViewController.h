//
//  InitializeForm.h
//  Eruntech
//
//  Created by 杜明悦 on 12-11-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IControlSearcherHandler.h"
#import "IDataInitialize.h"
#import "Initializble.h"
#import "ESControlSearcher.h"
@interface ESInitializeViewController : NSObject<IControlSearcherHandler, IDataInitialize> {
    UIViewController *_viewController;
}

/**
 设置或获取视图控制器
 **/
@property(nullable,nonatomic, retain) UIViewController *viewController;

/**
 初始化UIView初始化控制器
 @param viewController 当前视图控制器
 @return 初始化控制器
 **/
-(nonnull id) initWithViewController:(nonnull UIViewController*) viewController;

/**
 为控件提供初始化服务
 **/
-(void) dataInitialize;

/**
 循环基类实现接口，循环接口调用此接口实现方法
 @param obj uiview对象
 **/
-(void) handle:(nonnull id) obj;

/**
 循环基类实现接口，调用此方法实现，以决定是否继续执行
 @param obj 采集对象
 **/
-(BOOL) isPicked:(nonnull id) obj;
@end
