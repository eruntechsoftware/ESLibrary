//
//  ESButton.h
//  Neighbour
//
//  Created by 杜明悦 on 2016/10/15.
//  Copyright © 2016年 杜明悦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICollectible.h"
#import "IReleasable.h"
#import "Initializble.h"
#import "IValidatible.h"
#import "IStateProtected.h"
#import "ESNSString.h"
#import "ESView.h"

IB_DESIGNABLE
@interface ESButton : UIButton<ICollectible,IReleasable,Initializble,IStateProtected>
{
    
}


/**
 设置或获取采集标记
 */
@property(nonatomic, copy)IBInspectable NSString* collectSign;

/**
 设置或获取UIView名称
 */
@property(nonatomic, copy)IBInspectable NSString *name;

/**
 设置或获取UIView显示时的目标ID
 */
@property(nonatomic)IBInspectable NSString* stateHiddenId;

/**
 设置或获取UIView显示时的目标值
 */
@property(nonatomic)IBInspectable NSString* wantedStateValue;

/**
 设置或获取UIView对比类型，YES：条件全部满足才可以显示，NO：满足一个即可显示
 */
@property(nonatomic)IBInspectable BOOL wantedModeType;
@end
