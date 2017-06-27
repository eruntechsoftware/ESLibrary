//
//  DataIndexOf.m
//  Eruntech
//
//  Created by 杜明悦 on 12-11-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ESDataIndexOf.h"


@implementation ESDataIndexOf

/**
 根据名称查找Data元素
 @param name 查找的元素名称
 @param dataCollection 数据集
 @return Data元素
 **/
+(id) dataAtName:(NSString *)name params:(DataCollection*)dataCollection
{
    
    if (dataCollection) {
//        NSEnumerator *enumerator = [dataCollection objectEnumerator];
        for (Data * obj in dataCollection) {
            if ([[obj.name uppercaseString] isEqualToString:[name uppercaseString]]) {
                  return obj;
            }
        }
        return nil;  
    }
    return nil;
}

@end

