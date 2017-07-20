//
//  ESPhotoAddView.h
//  Neighbour
//
//  Created by 松洋 on 2016/11/2.
//  Copyright © 2016年 杜明悦. All rights reserved.
//  添加照片的组件

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "ICollectible.h"
#import "IReleasable.h"
#import "Initializble.h"

IB_DESIGNABLE
@interface ESPhotoAddView : UIView<ZLPhotoPickerBrowserViewControllerDelegate,ICollectible,IReleasable,Initializble>
{
    NSMutableString * _collectSign;
    NSString * _name;
    DataType _dataType;
    BaseViewController *_rootViewController;
}

/**
 设置或获取高度约束
 */
@property (strong,nonatomic)  NSLayoutConstraint *heightConstraint;

/**
 设置或获取添加图片的加号图片
 */
@property (strong,nonatomic)IBInspectable UIImage *placeholderImage;

/**
 设置或获取服务器图片数组分割符
 */
@property (strong,nonatomic)IBInspectable NSString *splitMark;

/**
 设置或获取最多图片数
 */
@property IBInspectable int maxPhotoCount;

/**
 设置或获取view的高度
 */
@property  IBInspectable CGFloat photoAddViewHigh;

/**
   设置或获取时间格式
 */
@property (strong,nonatomic) NSDateFormatter *formatter;

/**
 设置或获取图片宽度
 */
@property  CGFloat photoWidth;

/**
 设置或修改照片动态数组
 */
@property (strong,nonatomic) NSMutableArray *photoArray;

/**
 设置或修改照片路径数组
 */
@property (strong,nonatomic) NSMutableArray *photoPathArray;
    
/**
 当前视图
 */
@property (strong,nonatomic) BaseViewController *rootViewController;

@property (strong,nonatomic) ZLPhotoPickerBrowserViewController *browerVc;

/**
 设置照片数组
 @param photoArray 图片数组
 @return 返回此组件的动态计算高度
 */
-(CGFloat)setMyPhotoArray:(NSMutableArray*)photoArray;



/**
 设置或获取采集标记
 */
@property(nonatomic, copy)IBInspectable NSString *collectSign;

/**
 设置或获取UIView名称
 */
@property(nonatomic, copy)IBInspectable NSString *name;

/**
 设置或获取数据类型
 */
@property(nonatomic) DataType dataType;

/**
 初始化方法
 */
-(void)initializ;

/**
 获取采集标记名
 */
-(NSArray*) getRequest;

/**
 将数据发布到指定位置
 @param dataName 数据名称
 @param data 数据对象
 */
-(void) release:(NSString *)dataName data:(Data *)data;

/**
 获取控件名
 */
-(NSString*) getName;


/**
 数据收集，返回ETDataCollection
 */
-(DataCollection*) collect;

/**
 获取收集标记集合，返回NSString[]
 */
-(NSString *) getCollectSign;

/**
 设置采集标记，多个标记以‘|!’分割
 例如：ForSave|!ForQuery
 @param sign 采集标记
 */
-(void) setCollectSign:(NSMutableString*) sign;

/**
 返回照片数组
 */
-(NSMutableArray*)getPhotoArray;

/**
 返回照片路径数组
 */
-(NSMutableArray*)getPhotoPathArray;

@end
