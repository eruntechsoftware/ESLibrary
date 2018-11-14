//
//  ICollectible.h
//  Eruntech
//
//  Created by 杜明悦 on 12-10-17.
//  Copyright 2012年 __Eruntech__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"DataCollection.h"

@protocol ICollectible <NSObject>

/**
 数据收集，返回ETDataCollection
 @return DataCollection集合
 */
@required
-(DataCollection*) collect;

/**
 获取收集标记集合，返回NSString[]
 @return 标记集合
 */
@required
-(NSString *) getCollectSign;

/**
 设置采集标记，多个标记以‘|!’分割
 例如：ForSave|!ForQuery
 @param sign 采集标记
 */
@required
-(void) collectSign:(NSMutableString*) sign;
@end
