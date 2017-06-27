//
//  ButtonColose.h
//  Eruntech
//
//  Created by 杜明悦 on 13-2-22.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Initializble.h"
#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "ESView.h"
#import "ESButton+Bootstrap.h"
#import "ESButton.h"

IB_DESIGNABLE
@interface ESButtonClose : ESButton<Initializble>
{
    BaseViewController *_viewController;
    NSString *_sign;
    BOOL _isValidate;
}

/**
 设置或获取当前所属的视图控制器
 **/
@property (retain,nonatomic) BaseViewController *viewController;

/**
 设置或获取按钮采集标记
 **/
@property (copy,nonatomic)IBInspectable NSString *sign;

/**
 设置或获取按钮执行之前是否调用校验方法
 **/
@property (assign,nonatomic)IBInspectable BOOL isValidate;

/**
 初始化方法
 **/
-(void)initializ;

/**
 添加事件
 **/
-(void) addEvent;

/**
 关闭视图控制器
 **/
-(void) close;
@end
