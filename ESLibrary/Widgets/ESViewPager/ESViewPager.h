//
//  ESViewPager.h
//  Neighbour
//
//  Created by 杜明悦 on 2016/10/18.
//  Copyright © 2016年 杜明悦. All rights reserved.
//  视图滑动切换器

#import <UIKit/UIKit.h>
#import "ESViewPagerDelegate.h"
#import "BaseViewController.h"
#import "BaseNavigationController.h"

// 获得屏幕尺寸
#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height
IB_DESIGNABLE
@interface ESViewPager : UIView<UIScrollViewDelegate>


@property(strong,nonatomic)UIScrollView *scrollView;
/**
 设置或获取ESViewPagerDelegate委托
 */
@property(strong,nonatomic)id<ESViewPagerDelegate> viewPagerDelegate;

/**
 设置或获取视图容器
 */
@property(strong,nonatomic)NSMutableArray* viewControllerArray;

/**
 设置或获取导航视图控制器
 */
@property(strong,nonatomic)BaseViewController *rootViewController;

/**
 设置或获取视图容器容量
 */
@property(assign,nonatomic)NSInteger count;

/**
 设置或获取当前视图索引
 */
@property(assign,nonatomic)NSInteger index;

/**
 设置或获取标题颜色
 */
@property(strong,nonatomic)IBInspectable UIColor *tabTitleTextDefaultColor;

/**
 设置或获取标题选中时颜色
 */
@property(strong,nonatomic)IBInspectable UIColor *tabTitleHighlightedColor;

/**
 设置或获取标识线颜色
 */
@property(strong,nonatomic)IBInspectable UIColor *tabIndexerColor;

/**
 游标高度
 **/
@property(nonatomic)IBInspectable CGFloat tabIndexerHeight;

//定义标题文本宽、高、标识线宽、高
@property(nonatomic)IBInspectable CGFloat tabTitleHeight;

//定义标题文本字号
@property(nonatomic)IBInspectable CGFloat tabTitleFontSize;

/**
 初始化ESViewPager布局
 @param viewControllerArray 视图容器
 @param rootViewController 根视图控制器
 @param titleArray 标题数组
 */
-(void)initWithViewController:(NSMutableArray*) viewControllerArray rootViewController:(BaseViewController*) rootViewController titles:(NSMutableArray*)titleArray;

/**
 滑动到指定索引页
 @param index 索引下标
 */
-(void)scrollViewToPageIndex:(NSInteger)index;

/**
 滑动结束后执行的处理
 @param index 索引下标
 */
-(void)viewPagerScrollDid:(NSInteger)index;

/**
 滑动结束后标识线的滚动
 @param index 索引下标
 */
-(void)scrollFlagView:(NSInteger)index;

/**
 滑动到指定索引页
 @param ges 索引手势
 */
-(void)scrollViewToPageIndexByTag:(UITapGestureRecognizer*)ges;

-(void)setTitleTextWithIndex:(NSUInteger)index title:(NSString*)title;

-(void)removeAllSubViews;
@end
