//
//  CollectForm.h
//  Eruntech
//
//  Created by 杜明悦 on 12-10-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DataCollection.h"
#import "ICollector.h"
#import "ICollectible.h"
#import "IControlSearcherHandler.h"
#import "ESControlSearcher.h"


@interface ESCollectViewController : NSObject<ICollector,IControlSearcherHandler> {
    UIViewController * _viewController;
    NSString * _sign;
    DataCollection *_result;
}

/**
 设置或获取视图控制器
 ***/
@property(nullable,nonatomic, retain) UIViewController * viewController;

/**
 设置或获取采集标记
 ***/
@property(nullable,nonatomic, copy) NSString * sign;

/**
 设置或获取数据结果集
 ***/
@property(nullable,nonatomic, strong) DataCollection *result;

/**
 初始化数据收集控制器
 @param viewController 当前视图控制器
 @return 数据收集器
 **/
-(nonnull id) initWithViewController:(nonnull UIViewController*) viewController;

/**
 初始化数据收集控制器
 @param viewController 当前视图控制器
 @param strSign 采集标记
 @return 数据收集器
 **/
-(nonnull id) initWithViewController:(nonnull UIViewController*)viewController sign:(nonnull NSString*) strSign;

/**
 收集视图控制器的数据
 @return DataCollection数据集
 **/
-(nonnull DataCollection*) collect;

/**
 循环基类实现接口，循环接口调用此接口实现方法
 @param obj uiview对象
 **/
-(void) handle:(nonnull id)obj;

/**
 循环基类实现接口，调用此方法实现，以决定是否继续执行
 @param obj 采集对象
 **/
-(BOOL) isPicked:(nonnull id)obj;

/**
 检查是否可以匹配采集标记
 @param target 目标标记
 @param strings 标记数组
 **/
-(BOOL) matchSign:(nonnull NSString*) target :(nonnull NSArray*) strings;
@end
