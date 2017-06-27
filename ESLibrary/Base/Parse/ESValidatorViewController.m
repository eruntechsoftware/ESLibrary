//
//  ValidatorForm.m
//  Eruntech
//
//  Created by 杜明悦 on 12-11-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ESValidatorViewController.h"


@implementation ESValidatorViewController
@synthesize viewController=_viewController;


/**
 初始化数据校验控制器
 @param viewController 当前视图控制器
 @return 数据校验控制器
 **/
-(id)initWithViewController:(UIViewController *)viewController
{
    self=[super init];
    if (self) {
        self.viewController=viewController;
        self->_result=YES;
        return self;
    }
    return nil;
}

/**
 数据校验方法，uiView控件校验错误返回FALSE
 @return 校验错误返回
 **/
-(BOOL) validator
{
    if (self.viewController) {        
        NSMutableArray *controllist = [NSMutableArray new];
        [controllist addObject:self];
        ControlSearcher* searcher=[[ControlSearcher alloc] initControlSearcherWithHandler:controllist];
        [searcher search:self.viewController];
    }
    return _result;
}

/**
 循环基类实现接口，循环接口调用此接口实现方法
 @param obj uiview对象
 **/
-(void) handle:(id)obj
{
//    if ([obj dataValidator]==NO) {
//        _result=NO;
//    }else{
//        _result=YES;
//    }
}

/**
 循环基类实现接口，调用此方法实现，以决定是否继续执行
 @param obj 采集对象
 @return 是否继续执行
 **/
-(BOOL) isPicked:(id)obj
{
    //如果验证状态为通过，则继续验证下一个UIView，否则就略过
    if(self->_result==YES){
        if([obj conformsToProtocol:@protocol(IValidatible)]==YES){
            if ([obj dataValidator]==NO) {
                _result=NO;
            }else{
                _result=YES;
            }
        }
    }
    return _result;
}
@end
