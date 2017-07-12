//
//  UIActionLoadPage.h
//  Eruntech
//
//  Created by 杜明悦 on 13-7-26.
//  Copyright (c) 2013年 杜明悦. All rights reserved.
//  实现自动执行SQL并将数据展示到相关的UIView组件

#import <UIKit/UIKit.h>
#import "DataType.h"
#import "ESView.h"
#import "SQLiteDatabase.h"
#import "ESCollectViewController.h"
#import "ESReleaseViewController.h"
#import "ESLabel.h"

IB_DESIGNABLE

@interface ESActionLoadPage : UIButton<IDataQuery>
{
    SQLiteDatabase *_SQLiteDatabase;
    NSString *_sql;
    NSString *_sign;
    DataType _dataType;
    BOOL _isAuto;
    ESCollectViewController *collecter;
    ESReleaseViewController *releaser;
    BaseViewController *controller;
}

/**
 设置或获取数据库访问对象
 **/
@property(retain,nonatomic) SQLiteDatabase *SQLiteDatabase;

/**
 设置或获取执行的sql，指sql文件名
 **/
@property(copy, nonatomic)IBInspectable NSString *sql;

/**
 设置或获取采集标记
 **/
@property(copy, nonatomic)IBInspectable NSString *sign;

/**
 设置或获取数据类型，默认NSString类型
 **/
@property(assign,nonatomic) DataType dataType;

/**
 设置或获取是否自动执行查询
 **/
@property(assign,nonatomic)IBInspectable BOOL isAuto;

/**
 初始化屏幕采集、发布集合
 **/
-(void) initialize;

/**
 执行数据查询并发布数据到UIView
 **/
-(void) execute;

/**
 执行数据查询并发布数据到UIView
 **/
-(void) execute:(DataTable*)dataTable;
@end
