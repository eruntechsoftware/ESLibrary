//
//  ButtonColose.m
//  Eruntech
//
//  Created by 杜明悦 on 13-2-22.
//
//

#import "ESButtonClose.h"

@implementation ESButtonClose

@synthesize viewController=_viewController;
@synthesize sign=_sign;
@synthesize isValidate=_isValidate;

/**
 初始化方法
 **/
-(void)initializ
{
    [self redStyle];
    [self addEvent];
    _viewController=(BaseViewController*)[self searchViewController];
}

/**
 添加事件
 **/
-(void) addEvent
{
    [self addTarget:self action:@selector(btnCloseClick:) forControlEvents:UIControlEventTouchUpInside];
}

/**
 单击事件执行
 **/
-(void)btnCloseClick:(id)sender
{
    if(_isValidate == YES){
        BOOL result = [self.viewController validator];
        if(self.viewController != nil && result==YES){
            [self close];
        }
    }else{
        [self close];
    }
}

/**
 关闭视图控制器
 **/
-(void) close
{
    @try
    {
        if ([[_sign trim] isEqualToString:@""]==NO) {
            ESCollectViewController *viewCollect=[[ESCollectViewController new] initWithViewController:_viewController sign:_sign];
            DataCollection *params = [viewCollect collect];
            
            if(self.viewController.baseNavigationController != nil){
                [self.viewController.baseNavigationController popViewControllerAnimated:params animated:YES];
            }
            if(self.viewController != nil){
                [self.viewController dismissViewControllerAnimated:YES params:params completion:nil];
            }
        }
        else
        {
            if(self.viewController.baseNavigationController != nil){
                [self.viewController.baseNavigationController popViewControllerAnimated:nil animated:YES];
            }
            if(self.viewController != nil){
                [self.viewController dismissViewControllerAnimated:YES params:nil completion:nil];
            }
        }
        
    }
    @catch (NSException *exception) {
        @throw exception;
    }
    @finally {
        
    }
}
@end
