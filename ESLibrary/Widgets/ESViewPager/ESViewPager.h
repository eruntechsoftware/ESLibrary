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
{
    //ViewPager委托
    id<ESViewPagerDelegate> _viewPagerDelegate;
    //标题数组
    NSMutableArray *_titleArray;
    //标题视图数组
    NSMutableArray *_titleLabelArray;
    //标题颜色
    UIColor *_titleColor;
    //标题选中时颜色
    UIColor *_titleHighlightedColor;
    
    //标识线
    UIView *_flagView;
    //标识线颜色
    UIColor *_flagColor;
    
    //定义标题文本宽、高、标识线宽、高
    CGFloat _titleHeight, _titleWidth, _flagHeight, _flagWidth;
    //FlagView起始位置
    CGFloat _flagStartX;
    //标题区域高度，含标识线
    CGFloat _titleViewHeight;
    
    //滚动视图
    UIScrollView *_scrollView;
    //viewController视图容器
    NSMutableArray *_viewControllerArray;
    //导航栏控制器
    BaseViewController *_rootViewController;
    
    //视图容器容量
    NSInteger _count;
    //当前视图索引
    NSInteger _index;
    
    //记录原索引
    NSInteger _oldIndex;
    
    //记录SCrollView正在滚动时的索引
    NSInteger _scrollIndex;
    //屏幕宽度
    CGFloat _screenWidth;
    //屏幕高度
    CGFloat _screenHeight;
}


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
@property(strong,nonatomic)IBInspectable UIColor *titleColor;

/**
 设置或获取标题选中时颜色
 */
@property(strong,nonatomic)IBInspectable UIColor *titleHighlightedColor;

/**
 设置或获取标识线颜色
 */
@property(strong,nonatomic)IBInspectable UIColor *flagColor;


/**
 初始化ESViewPager布局
 @param array 视图容器
 @return ESViewPager
 */
-(id)initWithArray:(NSMutableArray*) array;

/**
 初始化ESViewPager布局
 @param array 视图容器
 @param rootViewController 根视图控制器
 @return ESViewPager
 */
-(id)initWithArray:(NSMutableArray*) array rootViewController:(BaseViewController*) rootViewController;

/**
 初始化ESViewPager布局
 @param array 视图容器
 @param rootViewController 根视图控制器
 @param titleArray 标题数组
 @return ESViewPager
 */
-(id)initWithArray:(NSMutableArray*) array rootViewController:(BaseViewController*) rootViewController titles:(NSMutableArray*)titleArray;

/**
 初始化ESViewPager布局
 @param frame 布局范围
 @param array 视图容器
 @return ESViewPager
 */
-(id)initWithFrame:(CGRect)frame viewControllerArray:(NSMutableArray*) array;

/**
 根据视图容器布置当期滚动视图布局
 */
-(void)show;

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
@end
