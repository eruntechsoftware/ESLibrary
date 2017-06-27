//
//  ControlSearcher.m
//  Eruntech
//
//  Created by 杜明悦 on 12-10-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ESControlSearcher.h"


@implementation ControlSearcher

@synthesize handlers=_handlers;

/**
 初始化循环类
 @param mutableHandlers 实现IControlSearcherHandler协议类
 @return ControlSearcher
 **/
-(ControlSearcher*) initControlSearcherWithHandler:(NSMutableArray *)mutableHandlers
{
    self = [super init];
    if (self) {
        [self setHandlers:mutableHandlers];
        return self;
    }
    return self;
}


/**
 遍历对象方法
 @param viewController 视图控制器
 **/
-(void) search:(id)viewController
{
    //主线程执行
//    dispatch_async(dispatch_get_main_queue(), ^{
        if ([viewController isKindOfClass:[UIViewController class]]) {
            UIViewController *view =(UIViewController*)viewController;
            NSArray *subviews = [view.view subviews];
            NSEnumerator *enumerator =  [subviews objectEnumerator];
            for (id ui in enumerator) {
                [self search:ui];
            }
        }
        else
        {
            if([viewController isKindOfClass:[UIView class]]){
                UIView *view = (UIView*)viewController;
                if([view.subviews count]>0){
                    NSArray *subviews = view.subviews;
                    NSEnumerator *enumerator =  [subviews objectEnumerator];
                    for (id ui in enumerator) {
                        [self search:ui];
                    }
                }
            }
            //迭代遍历
            NSEnumerator *enumerator = [_handlers objectEnumerator];
            for (id handler in enumerator) {
                if ([handler respondsToSelector:@selector(isPicked:)]) {
                    if ([handler isPicked:viewController]) {
                        [handler handle:viewController];
                    }
                }
            }
        }

//    });
}
@end
