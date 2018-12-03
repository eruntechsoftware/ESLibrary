//
//  ESViewGroup.h
//  ahome
//
//  Created by 杜明悦 on 2018/11/22.
//  Copyright © 2018年 杜明悦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<CoreText/CoreText.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "ICollectible.h"
#import "IReleasable.h"
#import "IValidatible.h"
#import "Validator.h"
#import "Initializble.h"
#import "Toast.h"
#import "ESView.h"
#import "DataType.h"
#import "DataTypeExpression.h"
#import "ESNSString.h"
#import "ESCheckBox.h"
@class ESCheckBox;
NS_ASSUME_NONNULL_BEGIN

@interface ESViewGroup : UIView<ICollectible,IReleasable,Initializble>
{
    NSMutableArray *_checkViews;
}

/**
 设置或获取采集标记
 **/
@property(nonatomic, copy)IBInspectable NSString *collectSign;


/**
 设置或获取控件名
 **/
@property(nonatomic, copy)IBInspectable NSString *name;

/**
 设置或获取是否多选模式
 */
@property(nonatomic)IBInspectable BOOL multiple;



/**
 设置或获取当前所属的视图控制器
 **/
@property(retain,nonatomic)UIViewController* viewController;

-(void)selectTag:(NSString*)tag;

-(void)addCheckBoxView:(ESCheckBox*)checkBox;

@end

NS_ASSUME_NONNULL_END
