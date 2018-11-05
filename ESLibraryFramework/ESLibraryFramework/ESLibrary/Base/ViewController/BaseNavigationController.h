//
//  BaseNavigationController.h
//  Neighbour
//
//  Created by 杜明悦 on 16/10/12.
//  Copyright © 2016年 杜明悦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewPassValueDelegate.h"
#import "DataCollection.h"
#import "UINavigationBar+Hidden.h"

@class BaseViewController;
@interface BaseNavigationController : UINavigationController
{
    /**当前ViewController对象*/
    BaseViewController* _baseViewController;
}

/**
 设置或获取当前ViewController对象
 */
@property(nullable,strong,nonatomic) BaseViewController* baseViewController;

/**
  设置或获取当前ViewController的搜索框
 */
@property (strong,nonatomic) UITextField *seacherFild;

/**
 初始化视图控制器
 @param baseViewController 视图控制器
 @return BaseNavigationController
 */
- (nonnull id)initWithViewController:(nonnull BaseViewController*)baseViewController;

/**
 初始化视图控制器
 @param baseViewController 视图控制器
 @param flag 是否隐藏返回按钮
 @return BaseNavigationController
 */
- (nonnull id)initWithViewController:(nonnull BaseViewController*)baseViewController isLeftBackHidden:(BOOL)flag;

/**
 设置NavigationBar颜色
 @param barTintColor 标题颜色
 */
+(void)setNavigationBar_barTintColor:(nonnull UIColor*)barTintColor;

/**
 获取NavigationBar颜色
 */
+(UIColor*)getNavigationBar_barTintColor;

/**
 推入视图控制器
 @param viewController 目标视图控制器
 @param dataParams DataCollection类型数据集
 @param delegate 传值委托实现对象
 @param flag 是否动画方式展示
 */
- (void) pushViewController:(nonnull BaseViewController*)viewController params:(nullable DataCollection*)dataParams passValueDelegate:(nonnull id<UIViewPassValueDelegate>)delegate animated:(BOOL)flag;


/**
 弹出viewController
 @param params 类型数据集
 @param flag 是否动画方式展示
 */
- (void) popViewControllerAnimated:(nullable DataCollection*)params animated:( BOOL)flag;

/**
 弹出viewController
 @param params 类型数据集
 @param closed 通知父页面是否关闭
 @param flag 是否动画方式展示
 */
- (void) popViewControllerAnimated:(DataCollection*)params isClosed:(BOOL)closed animated:(BOOL)flag;

/**
 推入视图控制器
 @param viewController 目标视图控制器
 @param backHidden 是否隐藏返回按钮
 @param flag 是否动画方式展示
 */
- (void) pushViewController:(nonnull UIViewController *)viewController leftBackHidden:(BOOL)backHidden animated:(BOOL)flag;

/**
 创建左侧按钮,并添加到导航视图控制器
 @param text 按钮文本
 */
- (nullable UIBarButtonItem*) leftBarButtonItem:(nonnull UIViewController*)viewController text:(nonnull NSString*)text;

/**
 创建右侧按钮,并添加到导航视图控制器
 @param text 按钮文本
 */
- (UIBarButtonItem*) rightBarButtonItem:(UIViewController*)viewController text:(NSString*)text;

/**
 创建右侧图形按钮,并添加到导航视图控制器
 @param img 图片
 */
- (nullable UIBarButtonItem*) rightImageBarButtonItem:(nonnull UIViewController*)viewController rightImageButton:(nonnull UIImage*)img;

/**
 导航视图控制器右侧按钮单击事件处理方法
 */
-(void)btnRightOnClick;

/**
 导航视图控制器左侧按钮单击事件处理方法
 */
-(void)btnLeftOnClick;

/**
 为当前的topbar添加搜索框
 @param placeholderStr 提示文字
 */
-(void)addSeacherView:(NSString*) placeholderStr;

/**
 设置透明的topbar
 @param viewController 当前视图控制器
 @param textColor 标题文本颜色
 */
-(void)setTransparentStyleBarWithViewController:(BaseViewController*)viewController titleTextColor:(UIColor*)textColor;

/**
 恢复topbar的普通状态
 @param viewController 当前视图控制器
 */
-(void)resumeNormalStyleBarWithViewController:(BaseViewController*)viewController;

/**
 设置透明的topbar并设置左侧返回按钮
 @param viewController 当前视图控制器
 @param textColor 标题文本颜色
 @param backImg 左侧返回按钮
 */
-(void)setTransparentStyleBarWithViewController:(BaseViewController*)viewController titleTextColor:(UIColor*)textColor backImage:(UIImage*)backImg;
@end
