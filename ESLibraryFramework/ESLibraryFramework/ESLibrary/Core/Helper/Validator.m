//
//  Validation.m
//  Neighbour
//
//  Created by 明悦 on 16/1/26.
//  Copyright © 2016年 ray. All rights reserved.
//

#import "Validator.h"
#import "ESNSString.h"

@implementation Validator

/**
 正则表达式校验器
 @param expression 校验表达式
 @return 校验器
 **/
-(id)initWithExpression:(NSString*) expression{
    self = [super init];
    if(expression!=nil && ![expression isEmpty]){
        _expression = expression;
        _regex = [[NSRegularExpression alloc] initWithPattern:expression options:0 error:nil];
    }
    return self;
}

-(BOOL) validataWithValue:(NSString*)value{
    if(_regex!=nil){
        NSRange range = [value rangeOfString:_expression
                                     options:NSRegularExpressionSearch | NSAnchoredSearch | NSCaseInsensitiveSearch
                                       range:NSMakeRange(0, value.length)
                                      locale:[NSLocale currentLocale]];
        // 断言/检索/替换
        bool exist = range.location != NSNotFound;
        return exist;
    }
    return NO;
}
@end

