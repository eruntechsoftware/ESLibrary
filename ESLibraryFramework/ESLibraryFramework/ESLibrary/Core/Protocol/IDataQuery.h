//
//  IDataQuery.h
//  Eruntech
//
//  Created by 杜明悦 on 13-7-31.
//  Copyright (c) 2013年 杜明悦. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDataQuery <NSObject>

/**
 执行数据库查询，加载自身数据或为控件赋值
 **/
-(void) execute;
@end
