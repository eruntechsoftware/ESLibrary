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
#import "ESNSString.h"
#import "ESView.h"

IB_DESIGNABLE
@interface ESButton : UIButton<ICollectible,IReleasable,Initializble>
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
@end
