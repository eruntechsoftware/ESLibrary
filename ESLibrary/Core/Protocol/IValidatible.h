//
//  IValidatible.h
//  Eruntech
//数据校验协议
//  Created by 杜明悦 on 12-11-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IValidatible <NSObject>
/**
 校验数据类型
 @return 数据校验是否通过
 */
-(BOOL)dataValidator;

/**
 * 提示校验错误
 * **/
-(void) hint;
@end
