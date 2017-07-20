//
//  ButtonOpen.h
//  Eruntech
//
//  Created by 杜明悦 on 13-2-21.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ESCollectViewController.h"
#import "DataCollection.h"
#import "Initializble.h"
#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "ESView.h"
#import "UIView+Toast.h"
#import "ESButton+Bootstrap.h"
#import "ESButton.h"


IB_DESIGNABLE
@interface ESButtonOpen : ESButton<Initializble>
{
    NSString *_openViewController;
    NSString *_sign;
    BOOL _isValidate;
    BaseViewController *_viewController;
}

/**
 设置或获取跳转的视图控制器
 */
@property (copy,nonatomic)IBInspectable NSString *openViewController;

/**
 设置或获取按钮采集标记
 */
@property (copy,nonatomic)IBInspectable NSString *sign;

/**
 设置或获取按钮执行之前是否调用校验方法
 */
@property (assign,nonatomic)IBInspectable BOOL isValidate;

/**
 获取当前UIView所属视图控制器
 */
@property (retain,nonatomic)BaseViewController *viewController;

/**
 初始化方法
 */
-(void)initializ;

/**
 添加事件
 */
-(void) addEvent;

/**
 跳转视图控制器
 */
-(void) open;
@end
