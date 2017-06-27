//
//  ICollector.h
//  Eruntech
//
//  Created by 杜明悦 on 12-10-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"DataCollection.h"

@protocol ICollector <NSObject>

/**
 收集数据接口
 @return DataCollection集合
 **/
@required
-(DataCollection*) collect;

@end
