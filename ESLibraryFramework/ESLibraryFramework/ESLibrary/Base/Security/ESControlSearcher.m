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
 */
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
 @param subview 视图控制器
 */
-(void) search:(id)subview
{
    //主线程执行
//    dispatch_async(dispatch_get_main_queue(), ^{
        if ([subview isKindOfClass:[UIViewController class]]) {
            UIViewController *vc =(UIViewController*)subview;
            [self search:vc.view];
        }
        else
        {
            if([subview isKindOfClass:[UIView class]]){
                UIView *views = (UIView*)subview;
                if([views.subviews count]>0){
                    for (UIView *view in views.subviews) {
                        [self search:view];
                    }
                }
            }
            //迭代遍历
            NSEnumerator *enumerator = [_handlers objectEnumerator];
            for (id handler in enumerator) {
                if ([handler respondsToSelector:@selector(isPicked:)]) {
                    if ([handler isPicked:subview]) {
                        [handler handle:subview];
                    }
                }
            }
        }

//    });
}
@end
