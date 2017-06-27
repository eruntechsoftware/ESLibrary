//
//  InitializeForm.m
//  Eruntech
//
//  Created by 杜明悦 on 12-11-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ESInitializeViewController.h"


@implementation ESInitializeViewController
@synthesize viewController=_viewController;

/**
 初始化UIView初始化控制器
 @param viewController 当前视图控制器
 @return 初始化控制器
 **/
-(id)initWithViewController:(UIViewController *)viewController
{
    self = [super init];
    if (self) {
        self.viewController = viewController;
        return self;
    }
    return nil;
}

/**
 为控件提供初始化服务
 **/
-(void) dataInitialize
{
    if (self.viewController) {
        NSMutableArray *controllist = [NSMutableArray new];
        [controllist addObject:self];
        ControlSearcher* searcher=[[ControlSearcher alloc] initControlSearcherWithHandler:controllist];
        [searcher search:self.viewController];
    }
}

/**
 循环基类实现接口，循环接口调用此接口实现方法
 @param obj uiview对象
 **/
-(void) handle:(id)obj
{
    [obj initializ];
}

/**
 循环基类实现接口，调用此方法实现，以决定是否继续执行
 @param obj 采集对象
 **/
-(BOOL) isPicked:(id)obj
{
    return [obj conformsToProtocol:@protocol(Initializble)];
}
@end
