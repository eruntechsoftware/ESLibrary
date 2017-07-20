//
//  IValidator.h
//  Eruntech
//数据类型校验辅助协议
//  Created by 杜明悦 on 12-11-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol IValidator <NSObject>

/**
 数据校验方法
@return 数据校验是否通过
 */
-(BOOL)validator;
@end
