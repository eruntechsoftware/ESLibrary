//
//  ReleaseForm.h
//  Eruntech
//
//  Created by 杜明悦 on 12-11-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DataTable.h"
#import "IReleasable.h"
#import "IReleaser.h"
#import "IControlSearcherHandler.h"
#import "ESControlSearcher.h"
#import "ESDataIndexOf.h"
#import "BaseViewController.h"


@interface ESReleaseViewController : NSObject<IReleaser,IControlSearcherHandler>
{
    UIViewController *_viewController;
    DataTable *_result;
}

/**
 设置或获取视图控制器
 */
@property(nullable,nonatomic,retain) UIViewController *viewController;

/**
 设置或获取数据结果集
 */
@property(nullable,nonatomic,retain) DataTable *result;

/**
 初始化数据发布控制器
 @param viewController 当前视图控制器
 @return 数据发布控制器
 */
-(nonnull id) initWithViewController:(nonnull UIViewController*) viewController;

/**
 初始化数据发布控制器
 @param viewController 当前视图控制器
 @param datatable 数据集
 @return 数据发布控制器
 */
-(nonnull id) initWithViewController:(nonnull UIViewController*) viewController dataTable:(nonnull DataTable*)datatable;

/**
 发布数据
 @param result 数据集
 */
-(void) release:(nonnull id)result;

/**
 循环基类实现接口，循环接口调用此接口实现方法
 @param obj uiview对象
 */
-(void) handle:(nonnull id) obj;

/**
 循环基类实现接口，调用此方法实现，以决定是否继续执行
 @param obj 采集对象
 @return 是否继续执行
 */
-(BOOL) isPicked:(nonnull id) obj;
@end
