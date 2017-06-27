//
//  SQLiteDatabase.h
//  Eruntech
//
//  Created by 杜明悦 on 13-2-25.
//
//

#import <Foundation/Foundation.h>
#import "ICollector.h"
#import "IReleaser.h"
#import "Database.h"
#import "DataTable.h"
#import "DataCollection.h"
#import "BaseViewController.h"
@interface SQLiteDatabase : NSObject
{
    Database *_database;
    NSString *_sql;
    NSMutableArray *_collectors;
    NSMutableArray *_releasers;
}

/**
 获取数据库访问对象
 **/
@property(nullable,retain, nonatomic) Database *database;

/**
 设置或获取执行的sql文件
 **/
@property(nullable,copy, nonatomic) NSString *sql;

/**
 设置或获取收集器列表
 **/
@property(nullable,strong, nonatomic) NSMutableArray *collectors;

/**
 设置或获取发布器列表
 **/
@property(nullable,strong, nonatomic) NSMutableArray *releasers;

/**
 初始化数据库访问对象
 @return 数据库对象
 **/
-(nonnull id) initDatabase;

/**
 执行Sql语句
 @return 是否执行成功
 **/
-(BOOL)execute;

/**
 执行Sql语句，并返回数据集
 @return DataTable数据集
 **/
-(nonnull DataTable *)executeTable;

/**
 执行数据集发布
 **/
-(void)executeTable:(nonnull DataTable*)dataTable;
@end
