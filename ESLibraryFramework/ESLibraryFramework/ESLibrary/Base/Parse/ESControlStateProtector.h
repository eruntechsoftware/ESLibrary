//
//  ESControlStateProtector.h
//  ESLibraryFramework
//
//  Created by 杜明悦 on 2018/11/15.
//  Copyright © 2018年 杜明悦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IStateProtected.h"
#import "IControlSearcherHandler.h"
#import "DataCollection.h"
#import "ESControlSearcher.h"
#import "ESNSString.h"
#import "ESHiddenFeild.h"

NS_ASSUME_NONNULL_BEGIN

@interface ESControlStateProtector : NSObject
{
    UIViewController * _viewController;
    NSMutableArray *_hiddenFeilds;
}

/**
 设置或获取视图控制器
 */
@property(nullable,nonatomic, retain) UIViewController * viewController;
@end

NS_ASSUME_NONNULL_END
