//
//  SQLiteDatabase.m
//  Eruntech
//
//  Created by 杜明悦 on 12-12-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Database.h"


@implementation Database
static NSString *_path;//数据库路径
static NSString *_name;//数据库名称
@synthesize db=_db;
//@synthesize path=_path;

/**
 初始化数据库访问对象
 @return 数据库对象
 **/
-(id) initDatabase
{
    if (self) {
        _name=@"db.sqlite";
        if (sourcePath == nil) {
            sourcePath = [ESFile findFile:@"db" extension:@"sqlite"];
        }
        
        if (targetPath == nil) {
            targetPath = [[ESFile cachesPath] stringByAppendingPathComponent:_name];
        }
        
        //如果目标目录无数据库文件，则复制当前文件到目标目录
        if(![ESFile existsWithPath:targetPath]){
            [ESFile copyFileWithSourcePath:sourcePath target:targetPath];
        }
        _path = [targetPath copy];
    }
    return self;
}

/**
 打开数据库，如果数据库不存在则创建数据库
 @return 是否打开或创建数据库
 **/
-(BOOL) open
{
    if (sqlite3_open([_path UTF8String], &_db)==SQLITE_OK)
    {
        return TRUE;
    }
    else
    {
        NSException *exception = [NSException exceptionWithName:@"打开数据库" reason:@"打开或创建数据库失败！" userInfo:nil];
        @throw exception;
    }
    return FALSE;
}

/**
 关闭数据库
 **/
-(void) close
{
    sqlite3_close(_db);
}

/**
 执行sql语句，切勿用于项目内执行sql语句
 @param sql 执行的语句
 @return 是否成功
 **/
-(BOOL) execute:(NSString *)sql
{
    //错误消息
    char* errmsg;
    const char* charsql = [sql UTF8String];
    //打开数据库
    if ([self open]==TRUE) {
        //执行Sql
        if (sqlite3_exec(_db, charsql, NULL, NULL, &errmsg)==SQLITE_OK) {
            //关闭数据库
            [self close];
            return TRUE;
        }
        else
        {
            //关闭数据库
            [self close];
            //获取错误信息，并将错误抛出
            NSString* errString = [[NSString alloc] initWithUTF8String:errmsg];
            NSException *exception = [NSException exceptionWithName:@"SQLiteDatabase Exception" reason:errString userInfo:nil];
            @throw exception;
        }
    }
    return FALSE;
}

/**
 执行sql文件
 @param sqlFile sql文件
 @param dataParams 参数集
 @return 是否成功
 **/
-(BOOL) execute:(nonnull NSString*)sqlFile params:(nullable DataCollection*)dataParams{

    BOOL result = NO;
    @try{
        //读取sql文件
        NSString*sqlItems = [SQLExpression readSqlFile:sqlFile];
        
        //如果不为空或nil，则继续执行
        if(sqlItems!=nil && ![[sqlItems trim]isEqualToString:@""]){
            
            //用参数格式化为目标执行sql
            sqlItems = [SQLExpression formatWithSql:sqlItems params:dataParams];
            
            //按go字符拆解为数组
            NSArray* array = [sqlItems componentsSeparatedByString:@"GO"];
            
            //检查是否为空或nil
            if(array!=nil && [array count]>0){
                //循环执行语句
                for(NSString* sql in array){
                    
                    //判断是否是SELECT查询
                    if ([sql rangeOfString:@"SELECT"].location == NSNotFound){
                        result = [self execute:sql];
                    }else{
                        [self executeTable:sql];
                    }
                }
            }
        }
    }
    @catch(NSException* ex){
        NSString* reason = @"数据库查询执行失败！原因:";
        [reason stringByAppendingString:ex.reason];
        NSException *exception = [NSException exceptionWithName:@"数据库查询" reason:ex.reason userInfo:nil];
        @throw exception;
    }
    return result;
}


/**
 执行sql语句并返回结果集，切勿用于项目内执行sql语句
 @param sql 执行的语句
 @return DataTable数据集
 **/
-(DataTable*) executeTable:(NSString *)sql
{
    //返回参数
    DataTable *table=nil;
    //打开数据库
    if([self open]==TRUE)
    {
        //错误消息
        const char* errmsg;
        const char* charsql = [sql UTF8String];
        //结果集
        sqlite3_stmt * statement;
        //列数
        int columns;

        if (sqlite3_prepare_v2(_db, charsql, -1, &statement, &errmsg)==SQLITE_OK) {
            
            if(statement!=nil){
                //获取列长度
                columns = sqlite3_column_count(statement);
                
                if(columns>0){
                    //实例化 DataTable对象
                    table = [[DataTable alloc] initWithCapacity:1];
                    //循环集合
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        //声明并实例化DataCollection对象
                        DataCollection *datas = [[DataCollection alloc] initWithCapacity:columns];
                        //循环列集合
                        for (int i=0; i<columns; i++) {
                            //获取列名称字段，将字段值char类型转换为NSString类型
                            NSString *name = [[NSString alloc] initWithUTF8String:sqlite3_column_name(statement, i)];
                            //获取列值字段，将字段值char类型转换为NSObject类型
                            NSObject *value = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(statement, i)];
                            
                            Data *data =  [[Data alloc] initWithDataName:name dataValue:value];
                            [datas addObject:data];
                        }
                        [table addObject:datas];
                    }
                }
                //释放结果集
                sqlite3_finalize(statement);
            }
        }
        else
        {
            //获取错误信息，并将错误抛出
            NSString* errString = [[NSString alloc] initWithUTF8String:errmsg];
            NSException *exception = [NSException exceptionWithName:@"SQLiteDatabase Exception" reason:errString userInfo:nil];
            @throw exception;
        }
    }
    //关闭数据库
    [self close];
    return table;
}

/**
 执行sql语句并返回结果集，切勿用于项目内执行sql语句
 @param sql 执行的语句
 @return DataTable数据集
 **/
-(DataTable*) executeTable:(NSString *)sql esencoding:(ESEncoding)encoding
{
    //返回参数
    DataTable *table=nil;
    //打开数据库
    if([self open]==TRUE)
    {
        //错误消息
        const char* errmsg;
        const char* charsql = [sql UTF8String];
        
        //结果集
        sqlite3_stmt * statement;
        //列数
        int columns;
        
        if (sqlite3_prepare_v2(_db, charsql, -1, &statement, &errmsg)==SQLITE_OK) {
            
            if(statement!=nil){
                //获取列长度
                columns = sqlite3_column_count(statement);
                
                if(columns>0){
                    NSStringEncoding encGBK = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                    //实例化 DataTable对象
                    table = [[DataTable alloc] initWithCapacity:1];
                    //循环集合
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        //声明并实例化DataCollection对象
                        DataCollection *datas = [[DataCollection alloc] initWithCapacity:columns];
                        //循环列集合
                        for (int i=0; i<columns; i++) {
                            //获取列名称字段，将字段值char类型转换为NSString类型
                            NSString *name = [[NSString alloc] initWithUTF8String:sqlite3_column_name(statement, i)];
                            //获取列值字段，将字段值char类型转换为NSObject类型
                            NSObject *value;
                            if(encoding == UTF8){
                                value = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(statement, i)];
                            }
                            if(encoding == GBK){
                                value = [[NSString alloc] initWithCString:(char*)sqlite3_column_text(statement, i) encoding:encGBK];
                            }
                        
                            Data *data =  [[Data alloc] initWithDataName:name dataValue:value];
                            [datas addObject:data];
                        }
                        [table addObject:datas];
                    }
                }
                //释放结果集
                sqlite3_finalize(statement);
            }
        }
        else
        {
            //获取错误信息，并将错误抛出
            NSString* errString = [[NSString alloc] initWithUTF8String:errmsg];
            NSException *exception = [NSException exceptionWithName:@"SQLiteDatabase Exception" reason:errString userInfo:nil];
            @throw exception;
        }
    }
    //关闭数据库
    [self close];
    return table;
}


/**
 执行sql语句并返回结果集
 @param sqlFile 执行的sql文件
 @param dataParams 参数集
 @return DataTable数据集
 **/
-(DataTable*)executeTable:(NSString *)sqlFile params:(DataCollection *)dataParams {
    
    DataTable* result=[[DataTable alloc] initWithCapacity:0];
    @try{
        //读取sql文件
        NSString*sqlItems = [SQLExpression readSqlFile:sqlFile];
        
        //如果不为空或nil，则继续执行
        if(sqlItems!=nil && ![[sqlItems trim]isEqualToString:@""]){
            
            //用参数格式化为目标执行sql
            sqlItems = [SQLExpression formatWithSql:sqlItems params:dataParams];
            
            //按go字符拆解为数组
            NSArray* array = [sqlItems componentsSeparatedByString:@"GO"];
            
            //检查是否为空或nil
            if(array!=nil && [array count]>0){
                //循环执行语句
                for(NSString* sql in array){
                    
                    //判断是否是SELECT查询
                    if ([sql rangeOfString:@"SELECT"].location == NSNotFound){
                        [self execute:sql];
                    }else{
                        result = [self executeTable:sql];
                    }
                }
            }
        }
    }
    @catch(NSException* ex){
        NSString* reason = @"数据库查询执行失败！原因:";
        [reason stringByAppendingString:ex.reason];
        NSException *exception = [NSException exceptionWithName:@"数据库查询" reason:reason userInfo:nil];
        @throw exception;
    }
    return result;
}

/**
 执行sql语句并返回结果集
 @param sqlFile 执行的sql文件
 @param dataParams 参数集
 @return DataTable数据集
 **/
-(nonnull DataTable*) executeTable:(nonnull NSString*)sqlFile params:(nullable DataCollection*)dataParams esencoding:(ESEncoding)encoding{
    
    DataTable* result=[[DataTable alloc] initWithCapacity:0];
    @try{
        //读取sql文件
        NSString*sqlItems = [SQLExpression readSqlFile:sqlFile];
        
        //如果不为空或nil，则继续执行
        if(sqlItems!=nil && ![[sqlItems trim]isEqualToString:@""]){
            
            //用参数格式化为目标执行sql
            sqlItems = [SQLExpression formatWithSql:sqlItems params:dataParams esencoding:encoding];
            
            //按go字符拆解为数组
            NSArray* array = [sqlItems componentsSeparatedByString:@"GO"];
            
            //检查是否为空或nil
            if(array!=nil && [array count]>0){
                //循环执行语句
                for(NSString* sql in array){
                    
                    //判断是否是SELECT查询
                    if ([sql rangeOfString:@"SELECT"].location == NSNotFound){
                        [self execute:sql];
                    }else{
                        result = [self executeTable:sql esencoding:encoding];
                    }
                }
            }
        }
    }
    @catch(NSException* ex){
        NSString* reason = @"数据库查询执行失败！原因:";
        [reason stringByAppendingString:ex.reason];
        NSException *exception = [NSException exceptionWithName:@"数据库查询" reason:reason userInfo:nil];
        @throw exception;
    }
    return result;
}


@end
