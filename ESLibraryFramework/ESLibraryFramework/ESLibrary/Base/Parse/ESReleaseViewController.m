//
//  ReleaseForm.m
//  Eruntech
//
//  Created by 杜明悦 on 12-11-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ESReleaseViewController.h"


@implementation ESReleaseViewController
@synthesize viewController=_viewController;
@synthesize result=_result;

/**
 初始化数据发布控制器
 @param viewController 当前视图控制器
 @return 数据发布控制器
 **/
-(id)initWithViewController:(UIViewController*)viewController
{
    self = [super init];
    if (self) {
        self.viewController = viewController;
        return self;
    }
    return nil;
}

/**
 初始化数据收集控制器
 @param viewController 当前视图控制器
 @param datatable 数据集
 @return 数据发布控制器
 **/
-(id) initWithViewController:(UIViewController*)viewController dataTable:(DataTable*)datatable
{
    self = [super init];
    if (self) {
        self.viewController = viewController;
        self.result = datatable;
        return self;
    }
    return nil;
}

/**
 发布数据
 @param result 数据集
 **/
-(void) release:(id)result
{
    if (result!=nil) {
        self.result = result;
    }
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
-(void) handle:(id) obj
{
    DataCollection *firstDataCollection = [_result objectAtIndex:0];
    NSEnumerator *enumerator = [[obj getRequest] objectEnumerator];
    for (NSString *str in enumerator) {
        Data *data = [ESDataIndexOf dataAtName:str params:firstDataCollection ];
        if (data) {
            [obj release:data.name data:data];
        }
    }
}

/**
 循环基类实现接口，调用此方法实现，以决定是否继续执行
 @param obj 采集对象
 @return 是否继续执行
 **/
-(BOOL) isPicked:(id) obj
{
    return [obj conformsToProtocol:@protocol(IReleasable)];
}
@end
