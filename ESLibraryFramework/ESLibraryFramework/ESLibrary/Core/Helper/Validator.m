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
        _regex = [[NSRegularExpression alloc] initWithPattern:expression options:0 error:nil];
    }
    return self;
}

-(BOOL) validataWithValue:(NSString*)value{
    if(_regex!=nil){
        NSArray *results = [_regex matchesInString:value options:0 range:NSMakeRange(0, value.length)];
        if (results!=nil && results.count>0) {
            return YES;
        }
    }
    return NO;
}
@end

