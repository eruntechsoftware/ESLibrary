//
//  IReleasable.h
//  Eruntech
//
//  Created by 杜明悦 on 12-11-1.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"Data.h"

@protocol IReleasable <NSObject>


/**
 获取采集标记
 @return 采集标记集合
 */
@required
-(NSArray*) getRequest;

/**
 向制定控件发布数据
 @param dataName 数据名称
 @param element data元素
 */
@required
-(void) release:(NSString*) dataName data:(Data*) element;

/**
 获取控件名
 @return 控件名称
 */
@required
-(NSString*) getName;

 @end
