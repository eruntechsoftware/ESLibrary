//
//  BaseTableViewController.h
//  Neighbour
//
//  Created by 杜明悦 on 2016/10/24.
//  Copyright © 2016年 杜明悦. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ESInitializeViewController.h"
#import "ESValidatorViewController.h"
#import "DataTable.h"
#import "DataCollection.h"
#import "Data.h"
#import "ESReleaseViewController.h"
#import "ESDataQueryViewController.h"
#import "UIViewPassValueDelegate.h"
#import "ESCollectViewController.h"
#import "UIView+Toast.h"
@class MJRefreshNormalHeader;
@class MJRefreshAutoNormalFooter;

// 获得屏幕尺寸
#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height

IB_DESIGNABLE
@class BaseNavigationController;

@interface BaseTableViewController:BaseViewController<UIViewPassValueDelegate,UITableViewDelegate,UITableViewDataSource>
{
    //下拉或上拉刷新组件
    MJRefreshNormalHeader *_header;
    MJRefreshAutoNormalFooter *_footer;
}

/**
 获取UITableView头部视图
 **/
@property (strong, nonatomic, null_unspecified) MJRefreshNormalHeader *header;

/**
 获取UITableView页脚视图
 **/
@property (strong, nonatomic, null_unspecified) MJRefreshAutoNormalFooter *footer;


/**
 设置上拉下拉刷新组件
 @param tableView 刷新的tableView
 **/
-(void)setRefreshView:(null_unspecified UITableView*)tableView;

/**
 下拉刷新操作，重写该方法实现下拉刷新后的处理
 **/
-(void)pullDownToRefresh;

/**
 上拉加载更多操作，重写该方法实现下拉刷新后的处理
 **/
-(void)pullUpToRefresh;

/**
 头部和底部停止刷新状态
 **/
-(void)stopRefreshing;

@end
