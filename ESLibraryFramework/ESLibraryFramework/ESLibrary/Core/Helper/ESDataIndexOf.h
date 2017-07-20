//
//  DataIndexOf.h
//  Eruntech
//
//  Created by 杜明悦 on 12-11-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Data.h"
#import "DataCollection.h"

@interface ESDataIndexOf : NSObject {
    
}


/**
 根据名称查找Data元素
 @param name 查找的元素名称
 @param dataCollection 数据集
 @return Data元素
 */
+(id) dataAtName:(NSString *)name params:(DataCollection*)dataCollection;
@end
