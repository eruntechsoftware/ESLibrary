//
//  ESImageView.h
//
//  Created by 松洋 on 2017/6/26.
//  Copyright © 2017年 com.du. All rights reserved.
//  自定义UIIamgeview

#import <UIKit/UIKit.h>
#import "ICollectible.h"
#import "IReleasable.h"
#import "Initializble.h"
#import "UIImageView+WebCache.h"

IB_DESIGNABLE  // 动态刷新

static NSString *IMAGE_URL_HEAD = @"";

@interface ESImageView : UIImageView<ICollectible,IReleasable,Initializble>

/**
 设置或获取占位图片
 */
@property (strong,nonatomic)IBInspectable UIImage *placeholderImage;

/**
 设置或获取圆角度数
 */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/**
 设置或获取边框宽度
 */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

/**
 设置或获取边框颜色
 */
@property (nonatomic, assign) IBInspectable UIColor *borderColor;

/**
 设置或获取采集标记
 */
@property(nonatomic, copy)IBInspectable NSString *collectSign;

/**
 设置或获取UIView名称
 */
@property(nonatomic, copy)IBInspectable NSString *name;

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
 显示网络图片
 @param urlBody  图片网络尾地址
 */
-(void) setImgWithUrlBody:(NSString*) urlBody;

+(NSString*) getImageUrlHead;

@end
