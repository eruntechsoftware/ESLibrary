//
//  ETDataTable.m
//  Eruntech
//
//  Created by 杜明悦 on 12-10-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataTable.h"


@implementation DataTable


/**
 创建DataTable对象
 @param numbers 初始容量
 @return DataTable
 ***/
-(id)initWithCapacity:(NSInteger)numbers{
    self = [super init];
    _array = [NSMutableArray arrayWithCapacity:numbers];
    return self;
}

/**
 添加Data元素
 @param anObject Data
 **/
-(void)addObject:(nonnull id)anObject{
    if(_array!=nil){
        [_array addObject:anObject];
//        [self convert2Array];
    }
}

/**
 添加DataTable
 @param dataTable DataTable
 **/
-(void)addAllObjects:(DataTable *)dataTable{
    if(_array!=nil){
        if(dataTable!=nil && dataTable.count>0){
            NSEnumerator *enumerator = [dataTable objectEnumerator];
            id obj = nil;
            while(obj = [enumerator nextObject]){
                [_array addObject:obj];
            }
        }
//        [self convert2Array];
    }
}

/**
 移除Data元素
 @param anObject Data
 **/
-(void)removeObject:(nonnull id)anObject{
    if(_array!=nil){
        [_array removeObject:anObject];
    }
}

/**
 移除所有元素
 **/
-(void)removeAllObjects{
    if(_array!=nil){
        [_array removeAllObjects];
    }
}

/**
 获取元素长度
 @return 元素长度
 **/
-(NSUInteger)count{
    if(_array!=nil){
        return[_array count];
    }
    return 0;
}

/**
 获取指定索引位置的数据集
 @param index 索引位置
 @return DataCollection
 **/
-(nonnull DataCollection*)objectAtIndex:(NSUInteger)index{
    if(_array!=nil){
        return[_array objectAtIndex:index];
    }
    return [[DataCollection alloc] initWithCapacity:1];
}

/**
 获取当前对象的迭代器
 **/
-(nonnull NSEnumerator*)objectEnumerator{
    if(_array!=nil){
        return [_array objectEnumerator];
    }
    return nil;
}



@end
