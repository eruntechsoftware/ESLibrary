//
//  DataQueryForm.h
//  Eruntech
//
//  Created by 杜明悦 on 13-7-31.
//  Copyright (c) 2013年 杜明悦. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IDataQuery.h"
#import "IControlSearcherHandler.h"
#import "DataCollection.h"
#import "ESControlSearcher.h"
@interface ESDataQueryViewController : NSObject<IDataQuery,IControlSearcherHandler>
{
    UIViewController *_viewController;
}

/**
 设置或获取视图控制器
 ***/
@property(nullable,nonatomic,retain) UIViewController *viewController;

/**
 初始化查询控制器
 @param viewController 当前视图控制器
 @return 查询控制器
 **/
-(nonnull id) initWithViewController:(nonnull UIViewController*)viewController;

/**
 获取数据
 **/
-(void) execute;

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
