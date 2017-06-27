//
//  IControlSearcherHandler.h
//  Eruntech
//
//  Created by 杜明悦 on 12-10-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol IControlSearcherHandler <NSObject>

/**
 循环基类实现接口，循环接口调用此接口实现方法
 @param obj 收集接口对象
 **/
@required
-(void) handle:(id) obj;
/**
 循环基类实现接口，调用此方法实现，以决定是否继续执行
 @param obj 匹配对象
 @return 是否继续执行
 **/
@required
-(BOOL) isPicked:(id) obj;
@end
