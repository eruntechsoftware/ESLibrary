//
//  BaseTableViewController.m
//  Neighbour
//
//  Created by 杜明悦 on 2016/10/24.
//  Copyright © 2016年 杜明悦. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseNavigationController.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshAutoNormalFooter.h"

@implementation BaseTableViewController

@synthesize header=_header;
@synthesize footer = _footer;

- (void)viewDidLoad {
    [super viewDidLoad];
}


/**
 设置上拉下拉刷新组件
 @param tableView 刷新的tableView
 */
-(void)setRefreshView:(UITableView*)tableView{
    // 1. 添加刷新头部控件的方法
    _header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉头部执行
        [self pullDownToRefresh];
    }];
    _header.lastUpdatedTimeLabel.hidden = YES;
    tableView.mj_header = _header;
    
    
    //2. 添加刷新尾部控件的方法
    _footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //上拉底部执行
        [self pullUpToRefresh];
    }];
    
    tableView.mj_footer = _footer;

    tableView.dataSource=self;
    tableView.delegate=self;
    //    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(stopRefreshing) userInfo:nil repeats:NO];
    //    [timer fire];
}

/**
 下拉刷新操作，重写该方法实现下拉刷新后的处理
 */
-(void)pullDownToRefresh{
    [_header beginRefreshing];
}

/**
 上拉加载更多操作，重写该方法实现下拉刷新后的处理
 */
-(void)pullUpToRefresh{
    [_footer beginRefreshing];
}

/**
 头部和底部停止刷新状态
 */
-(void)stopRefreshing{
    [_header endRefreshing];
    [_footer endRefreshing];
}
@end
