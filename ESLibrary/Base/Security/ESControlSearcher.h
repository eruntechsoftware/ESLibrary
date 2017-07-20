//
//  ControlSearcher.h
//  Eruntech
//
//  Created by 杜明悦 on 12-10-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IControlSearcherHandler.h"

@interface ControlSearcher : NSObject {
    
    NSMutableArray *_handlers;
    
}


/**
 设置或获取视图控制器循环对象
 */
@property (nullable, nonatomic, retain) NSMutableArray* handlers;

/**
 初始化循环类
 @param mutableHandlers 实现IControlSearcherHandler协议类
 @return ControlSearcher
 */
-(nonnull ControlSearcher*) initControlSearcherWithHandler:(nonnull NSMutableArray*)mutableHandlers;

/**
 遍历对象方法
 @param viewController 视图控制器
 */
-(void) search:(nonnull id) viewController;
@end
