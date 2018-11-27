//
//  ETDataCollection.h
//  Eruntech.BirthStone
//
//  Created by 杜明悦 on 12-9-17.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//  Data数据容器

#import <Foundation/Foundation.h>
#import "Data.h"

@interface DataCollection : NSObject<NSFastEnumeration>{
    
    //存储数据的容器
    NSMutableArray* _array;
    //当前位置索引
    int currIndex;
    Data* __unsafe_unretained _Nullable numbers[80];
}

+(instancetype)dataCollection;

/**
 创建DataCollection对象
 @param numbers 初始容量
 @return DataCollection
 */
-(nonnull id)initWithCapacity:(NSInteger)numbers;

/**
 根据名称查找Data
 @param name 数据名称
 @return Data
 */
-(nullable Data*) dataWithName:(nonnull NSString*) name;

/**
 添加Data元素
 @param anObject Data
 */
-(void)addObject:(nonnull Data*)anObject;

/**
 添加Data元素
 @param name 字段
 @param value 值
 */
-(void)addData:(nonnull NSString*)name value:(id)value;

/**
 添加DataTable
 @param dataCollection DataCollection
 */
-(void)addAllObjects:(nonnull DataCollection *)dataCollection;

/**
 移除Data元素
 @param anObject Data
 */
-(void)removeObject:(nonnull Data*)anObject;

/**
 获取指定索引位置的数据
 @param index 索引位置
 @return Data
 */
-(nonnull Data*)objectAtIndex:(NSUInteger)index;

/**
 移除所有元素
 */
-(void)removeAllObjects;

/**
 获取元素长度
 @return 元素长度
 */
-(NSUInteger)count;

/**
 转换成数组
 */
-(void)convert2Array;

/**
 获取当前对象的迭代器
 */
-(nonnull NSEnumerator*)objectEnumerator;
@end
