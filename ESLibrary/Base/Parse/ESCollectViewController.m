//
//  CollectForm.m
//  Eruntech
//
//  Created by 杜明悦 on 12-10-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ESCollectViewController.h"


@implementation ESCollectViewController
@synthesize viewController=_viewController;
@synthesize sign=_sign;
@synthesize result=_result;

/**
 初始化数据收集控制器
 @param viewController 当前视图控制器
 @return 数据收集器
 **/
-(id) initWithViewController:(UIViewController*)viewController
{
    self=[super init];
    if (self) {
        self.viewController=viewController;
        _result = [[DataCollection alloc]initWithCapacity:[[viewController.view subviews]count]];
        return self;
    }
    return nil;
}

/**
 初始化数据收集控制器
 @param view 当前视图控制器
 @param strSign 采集标记
 @return 数据收集器
 **/
-(id) initWithViewController:(UIViewController*)viewController sign:(NSString*) strSign
{
    self=[super init];
    if (self) {
        self.viewController=viewController;
        self.sign=strSign;
        int size = _viewController.view.subviews.count;
        self.result = [[DataCollection alloc] initWithCapacity:size];
        return self;
    }
    return nil;
}

/**
 收集视图控制器的数据
 @return DataCollection数据集
 **/
-(DataCollection*) collect
{
    @try {
        [self.result removeAllObjects];
        if (self.viewController!=nil) {
                NSMutableArray *controllist = [NSMutableArray new];
                [controllist addObject:self];
                ControlSearcher* searcher=[[ControlSearcher alloc] initControlSearcherWithHandler:controllist];
                [searcher search:self.viewController];
        }
    }
    @catch (NSException *exception) {
        @throw exception;
    }
    @finally {
    }
    return self.result;
}

/**
 循环基类实现接口，循环接口调用此接口实现方法
 @param obj uiview对象
 **/
-(void) handle:(id)obj
{
    @try {
        if (obj!=nil) {
                DataCollection *datas = [obj collect];
                if (datas!=nil && [datas count]!=0) {
//                    NSEnumerator *enumerator = [datas objectEnumerator];
                    for(Data * data in datas)
                    {
                        [self.result addObject:data];
                    }
                }
        }
    }
    @catch (NSException *exception) {
        @throw exception;
    }
    @finally {
        
    }
}

/**
 循环基类实现接口，调用此方法实现，以决定是否继续执行
 @param obj 采集对象
 **/
-(BOOL) isPicked:(id)obj
{
    @try {
        if ([self.sign isEqual:nil]==NO ) {
            if ([obj conformsToProtocol:@protocol(ICollectible)]) {                
                {
                    return[self matchSign:self.sign: [[obj getCollectSign] componentsSeparatedByString:NSLocalizedString(@"|!", nil)]]; 
                }
            }
        }
        return FALSE;
    }
    @catch (NSException *exception) {
        @throw exception;
    }
    @finally {
        
    }
}

/**
 检查是否可以匹配采集标记
 @param target 目标标记
 @param strings 标记数组
 **/
-(BOOL) matchSign:(NSString *)target :(NSArray *)strings
{
    NSEnumerator *enumerator = [strings objectEnumerator];
    for (NSString *str in enumerator) {
        if (str !=NULL && [str isEqualToString:target]) {
            return TRUE;
        }
    }
    return FALSE;
}
@end
