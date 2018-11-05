//
//  ETData.m
//  Eruntech
//
//  Created by 杜明悦 on 12-10-17.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Data.h"


@implementation Data
@synthesize name=_name;
@synthesize dataType=_dataType;
@synthesize value=_value;



/**
 初始化Data，输入name、value
 @param name 数据名称
 @param value datavalue
 @return Data
 */
-(id) initWithDataName:(NSString *)name dataValue :(id)value
{
    self = [super init];
    if (self) 
    {
        self.name=name;
        self.dataType=_dataType;
        self.value=value;
    }
    return self;
}

/**
 初始化Data，输入dataName、dataType、dataValue
 @param name 数据名称
 @param type 数据类型
 @param value datavalue
 @return Data
 */
-(id) initWithDataName:(NSString *)name  dataType:(DataType) type dataValue :(id)value
{
    self = [super init];
    if (self) {
        self.name=name;
        self.value=value;
        self.dataType=type;
    }
    return self;
}

/**
 初始化Data，输入dataName、dataType、dataValue
 @param name 数据名称
 @param block 回调方法
 @return Data
 */
-(id) initWithDataName:(NSString *)name  operationBlock :(OperationBlock)block
{
    self = [super init];
    if (self) {
        self.name=name;
        self.dataType=_dataType;
        self.block=block;
    }
    return self;
}

/**
 输出Integer值
 @return 整型数据
 */
-(NSInteger) toInteger{
    if(_value==nil){
        return -100000;
    }
    return [(NSNumber*)_value intValue];
}

/**
 输出String值
 @return String
 */
-(NSString*) toString{
    if(_value==nil){
        return @"";
    }
    return (NSString*)_value;
}

/**
 输出Boolean值
 @return Boolean
 */
-(BOOL) toBoolean{
    if(_value==nil){
        return NO;
    }
    return (BOOL)_value;
}
@end
