//
//  SQLExpression.h
//  CatvMobile
//  SQL语句规范类
//  Created by 杜明悦 on 12-12-14.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataCollection.h"
#import "ESDataIndexOf.h"
#import "ESEncoding.h"
#import "ESFile.h"

@interface SQLExpression : NSObject {
    
}

/**
 将SQL模板格式化成执行目标SQL
 @param sql 执行的语句
 @param dataParams 参数集
 @return 格式化后的SQL
 */
+(nonnull NSString*) formatWithSql:(nonnull NSString*)sql params:(nullable DataCollection*)dataParams;

/**
 将SQL模板格式化成执行目标SQL
 @param sql 执行的语句
 @param dataParams 参数集
 @param encoding  字符编码
 @return 格式化后的SQL
 */
+(NSString*) formatWithSql:(NSString*)sql params:(DataCollection*)dataParams esencoding:(ESEncoding)encoding;

/**
 从指定目录读取sql文件，并返回sql内容
 @param fileName sql文件
 @return 读取SQL
 */
+(nonnull NSString*) readSqlFile:(nullable NSString*)fileName;

@end
