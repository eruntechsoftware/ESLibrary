//
//  SQLiteDatabase.h
//  Eruntech
//
//  Created by 杜明悦 on 12-12-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ESNSString.h"
#import "DataTable.h"
#import "SQLExpression.h"
#import "ESEncoding.h"


@interface Database : NSObject {
    sqlite3 *_db;//数据库访问对象
    NSString *sourcePath;
    NSString *targetPath;
    @public
    const NSString *name;//数据库路径
}

/**
 获取数据库访问对象
 */
@property(nullable,nonatomic) sqlite3 *db;
//@property(nonatomic, copy) NSString *path;

/**
 初始化数据库访问对象
 @return 数据库对象
 */
-(instancetype) initDatabase;

/**
 初始化数据库访问对象
 @param databaseName 数据库文件名
 @return 数据库对象
 */
-(instancetype) initDatabaseWithName:(NSString*)databaseName;

/**
 打开数据库，如果数据库不存在则创建数据库  
 @return 是否打开或创建数据库
 */
-(BOOL) open;

/**
 是否成功关闭数据库
 */
-(void) close;

/**
 执行sql语句
 @param sql 执行的语句
 @return 是否成功
 */
-(BOOL) execute:(nonnull NSString*)sql;

/**
 执行sql文件
 @param sqlFile sql文件
 @param dataParams 参数集
 @return 是否成功
 */
-(BOOL) execute:(nonnull NSString*)sqlFile params:(nullable DataCollection*)dataParams;

/**
 执行sql语句并返回结果集
 @param sql 执行的语句
 @return DataTable数据集
 */
-(nonnull DataTable*) executeTable:(nonnull NSString*)sql;

/**
 执行sql语句并返回结果集
 @param sql 执行的语句
 @param encoding  字符编码
 @return DataTable数据集
 */
-(nonnull DataTable*) executeTable:(nonnull NSString*)sql esencoding:(ESEncoding)encoding;

/**
 执行sql语句并返回结果集
 @param sql 执行的语句
 @param dataParams 参数集
 @param encoding  字符编码
 @return DataTable数据集
 */
-(nonnull DataTable*) executeTable:(nonnull NSString*)sql params:(nullable DataCollection*)dataParams;

/**
 执行sql语句并返回结果集
 @param sqlFile 执行的sql文件
 @param dataParams 参数集
 @param encoding  字符编码
 @return DataTable数据集
 */
-(nonnull DataTable*) executeTable:(nonnull NSString*)sqlFile params:(nullable DataCollection*)dataParams esencoding:(ESEncoding)encoding;
@end
