//
//  SQLExpression.m
//  CatvMobile
//
//  Created by 杜明悦 on 12-12-14.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "SQLExpression.h"


@implementation SQLExpression

+(instancetype)initSQLExp
{
    SQLExpression *sqlEx = [[SQLExpression alloc] init];
    return sqlEx;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dict = [[NSMutableDictionary alloc] initWithCapacity:1];
    }
    return self;
}

/**
 将SQL模板格式化成执行目标SQL
 @param sql 执行的语句
 @param dataParams 参数集
 @return 格式化后的SQL
 */
+(NSString*) formatWithSql:(NSString*)sql params:(DataCollection*)dataParams
{
//    NSMutableString *realSql = [[NSMutableString alloc] initWithString:sample];
    NSMutableString *realSql = [[NSMutableString alloc] initWithString:sql];
    NSError* error = NULL;
    //创建正则表达式对象
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"(?:@)(\\w+)(?:\\b)"
                                                                           options:0
                                                                             error:&error];
    //获取所有符合表达式的对象
    NSMutableArray *array = [regex matchesInString:sql options:NSMatchingReportCompletion range:NSMakeRange(0, [sql length])];
    NSString *targetRange = nil;
    NSString *targetName = nil;
    NSString *value = @"";

    //创建迭代，循环查找并替换为实际参数
    for (NSTextCheckingResult *key in array) {
        targetRange = [sql substringWithRange:key.range];
        targetName = [targetRange substringWithRange:NSMakeRange(1, [targetRange length]-1)];
        Data *data = [dataParams dataWithName:targetName];
        
        if(data!=nil && data.value!=nil){
            value = @"";
            if(data.dataType==Integer)
            {
                value = [value stringByAppendingString:[data toString]];
            }
            else
            {
                value = [value stringByAppendingString:@"'"];
                value = [value stringByAppendingString:[[data toString] stringByReplacingOccurrencesOfString:@"'" withString:@""]];
                value = [value stringByAppendingString:@"'"];
            }
            if (value!=nil) {
                NSRange range = [realSql rangeOfString:targetRange];
                [realSql replaceCharactersInRange:range withString:value];
                
//                realSql = [realSql stringByReplacingOccurrencesOfString:target withString:value];
            }
        }else{
            realSql = [realSql stringByReplacingOccurrencesOfString:targetRange withString:@"''"];
        }
    }
    NSLog(@"%@", realSql);

    return realSql;
}

/**
 将SQL模板格式化成执行目标SQL
 @param sql 执行的语句
 @param dataParams 参数集
 @return 格式化后的SQL
 */
+(NSString*) formatWithSql:(NSString*)sql params:(DataCollection*)dataParams esencoding:(ESEncoding)encoding
{
    //    NSMutableString *realSql = [[NSMutableString alloc] initWithString:sample];
    NSMutableString *realSql = [[NSMutableString alloc] initWithString:sql];
    NSError* error = NULL;
    //创建正则表达式对象
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"(?:@)(\\w+)(?:\\b)"
                                                                           options:0
                                                                             error:&error];
    //获取所有符合表达式的对象
    NSMutableArray *array = [regex matchesInString:sql options:NSMatchingReportCompletion range:NSMakeRange(0, [sql length])];
    NSString *targetRange = nil;
    NSString *targetName = nil;
    NSString *value = @"";
    NSStringEncoding encGBK = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    //创建迭代，循环查找并替换为实际参数
    for (NSTextCheckingResult *key in array) {
        targetRange = [sql substringWithRange:key.range];
        targetName = [targetRange substringWithRange:NSMakeRange(1, [targetRange length]-1)];
        Data *data = [dataParams dataWithName:targetName];//[ESDataIndexOf dataAtName:targetName params:dataParams];
        
        if(data!=nil && data.value!=nil){
            value = @"";
            if(data.dataType==Integer)
            {
                if(encoding == GBK){
                    NSString *valueStr = [[NSString alloc] initWithCString:[[data toString] UTF8String] encoding:encGBK];;
                    value = [value stringByAppendingString:valueStr];
                }else{
                    value = [value stringByAppendingString:[data toString]];
                }
            }
            else
            {
                value = [value stringByAppendingString:@"'"];
                if(encoding == GBK){
                    NSString *valueStr = [[NSString alloc] initWithCString:[[data toString] UTF8String] encoding:encGBK];;
                    value = [value stringByAppendingString:[valueStr stringByReplacingOccurrencesOfString:@"'" withString:@""]];
                }else{
                    value = [value stringByAppendingString:[[data toString] stringByReplacingOccurrencesOfString:@"'" withString:@""]];
                }
                value = [value stringByAppendingString:@"'"];
            }
            if (value!=nil) {
                NSRange range = [realSql rangeOfString:targetRange];
                [realSql replaceCharactersInRange:range withString:value];
                //                realSql = [realSql stringByReplacingOccurrencesOfString:target withString:value];
            }
        }else{
            realSql = [[NSMutableString alloc] initWithString:[realSql stringByReplacingOccurrencesOfString:targetRange withString:@"''"]];
        }
    }
    NSLog(@"%@", realSql);
    
    return realSql;
}

/**
 从指定目录读取sql文件，并返回sql内容
 @param fileName sql文件
 @return 读取SQL
 */
-(NSString*) readSqlFile:(NSString*)fileName
{
    NSString*sql = @"";
    if([_dict objectForKey:fileName]!=nil)
    {
        sql = [_dict objectForKey:fileName];
    }
    else
    {
        sql = [ESFile readFile:fileName extension:@"sql"];
        [_dict setObject:sql forKey:fileName];
    }
    return [sql copy];
}
@end
