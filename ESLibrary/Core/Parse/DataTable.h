//
//  ETDataTable.h
//  Eruntech
//
//  Created by 杜明悦 on 12-10-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataCollection.h"

@interface DataTable : NSMutableArray<NSObject> {
@private
    //存储数据的容器
    NSMutableArray* _array;
}

/**
 创建DataTable对象
 @param numbers 初始容量
 @return DataTable
 */
-(nonnull id)initWithCapacity:(NSInteger)numbers;

/**
 添加DataCollection元素
 @param anObject Data
 */
-(void)addObject:(nonnull DataCollection*)anObject;

/**
 添加DataTable
 @param dataTable DataTable
 */
-(void)addAllObjects:(nonnull DataTable*)dataTable;

/**
 移除Data元素
 @param anObject Data
 */
-(void)removeObject:(nonnull DataCollection*)anObject;

/**
 移除所有元素
 */
-(void)removeAllObjects;

/**
 获取指定索引位置的数据集
 @param index 索引位置
 @return DataCollection
 */
-(nonnull DataCollection*)objectAtIndex:(NSUInteger)index;

/**
 获取元素长度
 @return 元素长度
 */
-(NSUInteger)count;

/**
 获取当前对象的迭代器
 */
-(nonnull NSEnumerator*)objectEnumerator;

@end
