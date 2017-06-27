//
//  Validation.h
//  Neighbour
//
//  Created by 明悦 on 16/1/26.
//  Copyright © 2016年 ray. All rights reserved.
//

#import <Foundation/Foundation.h>

/**数据校验类***/
@interface Validator : NSObject{
    NSRegularExpression *_regex;
}

/**
 正则表达式校验器
 @param expression 校验表达式
 @return 校验器
 **/
-(id)initWithExpression:(NSString*) expression;

/**
 校验数据是否正确，并返回校验结果
 @param value 校验值
 @return 校验结果
 **/
-(BOOL) validataWithValue:(NSString*)value;
@end
