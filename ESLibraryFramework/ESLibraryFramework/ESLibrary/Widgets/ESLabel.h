//
//  UILabelEx.h
//  Eruntech
//
//  Created by 杜明悦 on 13-7-26.
//  Copyright (c) 2013年 杜明悦. All rights reserved.
//  封装UILabel实现数据自动收集、发布、校验

#import <UIKit/UIKit.h>
#import "ICollectible.h"
#import "IReleasable.h"
#import "Initializble.h"
#import "IStateProtected.h"
#import "ESNSString.h"
#import "ESView.h"

IB_DESIGNABLE
@interface ESLabel : UILabel<ICollectible,IReleasable,Initializble,IStateProtected>
{
    NSMutableString * _collectSign;
    NSString * _name;
    DataType _dataType;
}

/**
 设置或获取采集标记
 */
@property(nonatomic, copy)IBInspectable NSMutableString* collectSign;

/**
 设置或获取UIView名称
 */
@property(nonatomic, copy)IBInspectable NSString *name;

/**
 设置或获取数据类型
 */
@property(nonatomic)IBInspectable DataType dataType;

/**
 设置或获取UIView显示时的目标ID
 */
@property(nonatomic)IBInspectable NSString* stateHiddenId;

/**
 设置或获取UIView显示时的目标值
 */
@property(nonatomic)IBInspectable NSString* wantedStateValue;

/**
 设置或获取UIView对比类型，YES：条件全部满足才可以显示，NO：满足一个即可显示
 */
@property(nonatomic)IBInspectable BOOL wantedModeType;

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

@end
