//
//  UIViewPassValueDelegate.h
//  Eruntech
//
//  Created by 杜明悦 on 13-2-25.
//  UIViewController间数据传值协议
//

#import <Foundation/Foundation.h>
#import "DataCollection.h"
@protocol UIViewPassValueDelegate <NSObject>


/**
 UIViewController间数据传值
 @param params 参数集
 */
- (void)passValue:(id)params;

/**
 UIViewController间数据传值
 @param state 状态
 @param params 参数集
 */
- (void)passValue:(int)state params:(id)params;

/**
 UIViewController间数据传值
 @param params 参数集
 @param closed 是否关闭上级页面
 */
- (void)passValue:(id)params isClosed:(BOOL)closed;
@end
