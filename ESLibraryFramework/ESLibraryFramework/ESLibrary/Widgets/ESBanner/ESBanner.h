//
//  Banner.h
//  OcTest
//
//  Created by 松洋 on 16/10/12.
//  Copyright © 2016年 com.du. All rights reserved.
//  func 轮播图头文件（再带10个分类网格）
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ICollectible.h"
#import "IReleasable.h"
#import "Initializble.h"
#import "ESView.h"
#import "ESPageControl.h"

@interface ESBanner : UIView<UIScrollViewDelegate,ICollectible,IReleasable,Initializble,UIGestureRecognizerDelegate>{
   
    NSString * _name;
    DataType _dataType;
}

/**
 设置或获取UIPageControl的默认圆点颜色
 **/
@property  (strong,nonatomic) IBInspectable UIColor *defaultPageControlColor;

/**
 设置或获取UIPageControl的选中圆点颜色
 **/
@property  (strong,nonatomic)IBInspectable  UIColor *currentPageControlColor;


/**
 设置或获取UIPageControl的未选中图片
 **/
@property  (strong,nonatomic) IBInspectable UIImage *defaultPageControlImg;

/**
 设置或获取UIPageControl的选中图片
 **/
@property  (strong,nonatomic)IBInspectable  UIImage *currentPageControlImg;


/**
 设置或获取banner切换时间
 **/
@property IBInspectable int timeInterval;

/**
 设置或获取当前视图控制器
 **/
@property (strong,nonatomic) BaseViewController *vc;

/**
 设置或获取服务器图片数组分割符
 **/
@property (strong,nonatomic)IBInspectable NSString *splitMark;


/**
 设置或获取高度约束
 **/
@property (strong,nonatomic)  NSLayoutConstraint *heightConstraint;

/**
设置或获取滑动view
 **/
@property (strong, nonatomic,readwrite)  UIScrollView* uiScollView;

/**
 设置或获取轮播图数组
 **/
@property (strong, nonatomic)  NSMutableArray* imgsArray;

/**
 设置或获取轮播图小圆点
 **/
@property (strong, nonatomic)  ESPageControl* esPageControl;;

/**
 设置或获取定时器
 **/
@property (strong, nonatomic)  NSTimer* timer;


/**
 设置或获取变量，当前轮播图的所在pageindex
 **/
@property int current;

/**
 设置或获取轮播图数量
 **/
@property int imgsCount;



/**
 初始化小圆点
 **/
-(UIPageControl*)myPageControl;

/**
 初始化定时器
 **/
-(void)addTimer;

/**
 当轮播图到最后一页时处理
 **/
-(void)next;

/**
 把图片放进轮播组件
 **/
-(void)addImgInBanner: (NSMutableArray*) imgArray;

/**
 初始化滑动试图
 **/
-(void)setMyScollViewWithWidth:(CGFloat) width viewHigh:(CGFloat) high;

///**
// 设置或获取采集标记
// **/
//@property(nonatomic, copy)IBInspectable NSString *collectSign;

/**
 设置或获取UIView名称
 **/
@property(nonatomic, copy)IBInspectable NSString *name;

/**
 设置或获取数据类型
 **/
@property(nonatomic) DataType dataType;

/**
 初始化方法
 **/
-(void)initializ;

/**
 获取采集标记名
 **/
-(NSArray*) getRequest;

/**
 将数据发布到指定位置
 @param dataName 数据名称
 @param data 数据对象
 **/
-(void) release:(NSString *)dataName data:(Data *)data;

/**
 获取控件名
 **/
-(NSString*) getName;


/**
 数据收集，返回ETDataCollection
 **/
-(DataCollection*) collect;

/**
 获取收集标记集合，返回NSString[]
 **/
-(NSString *) getCollectSign;

/**
 设置采集标记，多个标记以‘|!’分割
 例如：ForSave|!ForQuery
 @param sign 采集标记
 **/
-(void) setCollectSign:(NSMutableString*) sign;
@end
