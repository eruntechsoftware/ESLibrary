//
//  ButtonOpen.m
//  Eruntech
//
//  Created by 杜明悦 on 13-2-21.
//
//

#import "ESButtonOpen.h"

@implementation ESButtonOpen

@synthesize openViewController=_openViewController;
@synthesize sign=_sign;
@synthesize isValidate=_isValidate;
@synthesize viewController=_viewController;



/**
 初始化事件
 */
-(void)initializ
{
    [self defaultStyle];
    [self addEvent];
    _viewController=(BaseViewController*)[self searchViewController];
}

/**
 添加事件
 */
-(void)addEvent
{
    [self addTarget:self action:@selector(btnOpenClick:) forControlEvents:UIControlEventTouchUpInside];
}

/**
 单击事件执行
 */
-(void)btnOpenClick:(id)sender
{
    if(_isValidate == YES){
        BOOL result = [self.viewController validator];
        if(self.viewController != nil && result==YES){
            [self open];
        }
    }else{
        [self open];
    }
}

/**
 实例化并呈现目标UIViewController
 */
-(void) open
{
    @try
    {
        if (_openViewController!=nil && ![[_openViewController trim] isEqualToString:@""]) {
            //反射获取目标UIViewController实例
            id obj = [[NSClassFromString(_openViewController) alloc] init];
            UIViewController* tagViewController = [obj initWithNibName:_openViewController bundle:nil];
            BaseViewController* baseTagViewController = (BaseViewController*)tagViewController;
            
            DataCollection *params = [[DataCollection alloc] initWithCapacity:1];
            //获取采集标记并收集参数
            if ([[_sign trim] isEqualToString:@""]==NO) {
                ESCollectViewController *viewCollect=[[ESCollectViewController new] initWithViewController:_viewController sign:_sign];
                params = [viewCollect collect];
            }
            
            //判断跳转方式
            if(self.viewController.baseNavigationController != nil){
                [self.viewController.baseNavigationController pushViewController:baseTagViewController params:params passValueDelegate:self.viewController animated:YES];
            }else{
                [self.viewController presentViewController:tagViewController params:params passValueDelegate:self.viewController animated:YES completion:nil];
            }
            
        }else{
            [self.viewController.view makeToast:@"未设置跳转目标视图控制器" duration:3.0 position:CSToastPositionCenter];
        }
        
    }
    @catch (NSException *exception) {
        @throw exception;
    }
    @finally {
        
    }
}

@end
