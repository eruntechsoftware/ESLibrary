//
//  Initializble.h
//  Eruntech
//
//  Created by 杜明悦 on 12-11-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"

/**
 初始化协议
 */
@protocol Initializble <NSObject>

/**
 初始化方法，为控件提供基本服务
 */
-(void) initializ;
@end
