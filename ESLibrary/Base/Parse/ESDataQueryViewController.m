//
//  DataQueryForm.m
//  Eruntech
//
//  Created by 杜明悦 on 13-7-31.
//  Copyright (c) 2013年 杜明悦. All rights reserved.
//

#import "ESDataQueryViewController.h"

@implementation ESDataQueryViewController
@synthesize viewController=_viewController;

/**
 初始化查询控制器
 @param viewController 当前视图控制器
 @return 查询控制器
 */
-(id) initWithViewController:(UIViewController*)viewController
{
    self = [super init];
    if (self) {
        self.viewController = viewController;
        return self;
    }
    return nil;
}


/**
 获取数据
 */
-(void) execute
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
 */
-(void) handle:(id) obj
{
    [obj execute];
}

/**
 循环基类实现接口，调用此方法实现，以决定是否继续执行
 @param obj 采集对象
 */
-(BOOL) isPicked:(id) obj
{
    return [obj conformsToProtocol:@protocol(IDataQuery)];
}
@end
