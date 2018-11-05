//
//  ETData.h
//  Eruntech.BirthStone
//
//  Created by 杜明悦 on 12-9-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataType.h"
typedef void(^OperationBlock)(id listView, NSIndexPath *indexPath);

@interface  Data :NSObject {
    NSString* _name;
    DataType  _dataType;
    id _value;
}

/**
 数据名称
 */
@property (strong, nonatomic) NSString* name;

/**
 数据类型
 */
@property(assign, nonatomic) DataType dataType;

/**
 值
 */
@property(strong, nonatomic) id value;

/**
 回调
 */
@property(copy, nonatomic) OperationBlock block;

/**
 初始化Data，输入name、value
 @param name 数据名称
 @param value datavalue
 @return Data
 */
-(id) initWithDataName:(NSString *)name dataValue :(id)value;

/**
 初始化Data，输入dataName、dataType、dataValue
 @param name 数据名称
 @param type 数据类型
 @param value datavalue
 @return Data
 */
-(id) initWithDataName:(NSString *)name  dataType:(DataType) type dataValue :(id)value;

/**
 初始化Data，输入dataName、dataType、dataValue
 @param name 数据名称
 @param block 回调方法
 @return Data
 */
-(id) initWithDataName:(NSString *)name  operationBlock :(OperationBlock)block;

/**
 输出Integer值
 @return 整型数据
 */
-(NSInteger) toInteger;

/**
 输出String值
 @return String
 */
-(NSString*) toString;

/**
 输出Boolean值
 @return Boolean
 */
-(BOOL) toBoolean;
@end
