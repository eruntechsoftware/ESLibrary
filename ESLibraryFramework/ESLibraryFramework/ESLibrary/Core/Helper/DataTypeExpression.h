//
//  DataTypeExpression.h
//  Neighbour
//
//  Created by 杜明悦 on 2016/10/14.
//  Copyright © 2016年 杜明悦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTypeExpression : NSObject

/**
 返回int类型正则表达式
 */
+(NSString*) integer;

/**
 返回Numeric类型正则表达式
 */
+(NSString*) numeric;

/**
 返回Money类型正则表达式
 */
+(NSString*) money;

/**
 返回Date类型正则表达式
 */
+(NSString*) date;

/**
 返回DateTime类型正则表达式
 */
+(NSString*) dateTime;

/**
 返回EMail类型正则表达式
 */
+(NSString*) eMail;

/**
 返回Mobile类型正则表达式
 */
+(NSString*) mobile;

/**
 返回phone类型正则表达式
 */
+(NSString*) phone;


/**
 身份证号正则表达式
 @return 身份证号表达式
 */
+ (NSString*) idCard;
@end
