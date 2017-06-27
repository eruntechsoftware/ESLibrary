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
        [self convert2Array];
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
        [self convert2Array];
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
 转换成数组
 **/
-(void)convert2Array{
    int index=0;
    for(DataCollection* __unsafe_unretained params in _array){
        numbers[index]=params;
        index+=1;
    }
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

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(null_unspecified id)stackbuf count:(NSUInteger)len
{
    // 我们用state来表示状态。状态为1返回零，说明迭代结束；若状态为0，则继续迭代
    // state初始值为零
    if(state->state > 0)
        return 0;
    
    // mutationsPtr不能为空，如果假定在枚举过程中不发生修改，一般指向self
    state->mutationsPtr = (long)self;
    
    // 我们将当前剩余长度放在state的extra[0]之中
    NSUInteger retCount = state->extra[0];
    
    // 所要枚举的数组指针首地址；extra[1]起始值为零
    state->itemsPtr = &numbers[state->extra[1]];
    
    // 若为零，说明这是第一次迭代
    if(retCount == 0)
        retCount = [_array count];
    
    // 这里需要判断当前数组长度是否超过了本次枚举所设置的最大长度
    if(retCount > len)
    {
        // 设置extra[0]，存放剩余所要枚举的元素个数
        state->extra[0] = retCount - len;
        
        // 设置extra[1]，存放后一次枚举起始元素索引
        state->extra[1] += len;
        
        retCount = len;
    }
    else
    {
        // 若剩余所要枚举的元素个数小于最大限制个数，则状态变1，使得后一次迭代能直接结束
        state->state++;
    }
    
    // 返回这次所要枚举的数组一共含有多少元素
    return retCount;
}


@end
