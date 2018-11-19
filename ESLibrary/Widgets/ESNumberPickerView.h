//
//  ESNumberPickerView.h
//  ahome
//
//  Created by 杜明悦 on 2018/11/19.
//  Copyright © 2018年 杜明悦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IReleasable.h"
#import "ICollectible.h"
#import "Initializble.h"
#import "DataCollection.h"
#import "Data.h"
#import "ESTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface ESNumberPickerView : UIView<IReleasable,ICollectible,Initializble>
{
    
    CGRect _bound;
    CGRect myframe;
    
    NSInteger _value;
    
    UIImageView *_btnAdd;
    UIImageView *_btnMinus;
    ESTextField *_textField;
    
    UIImage *addImageNormal;
    UIImage *addHighlighted;
    
    UIImage *minusNormal;
    UIImage *minusHighlighted;
}

/**
 增加数值按钮
 **/
@property(nonatomic,strong)IBInspectable NSString *name;

/**
 增加数值按钮高亮
 **/
@property(nonatomic,strong)IBInspectable NSString *collectSign;

/**
 最小值
 **/
@property(nonatomic)IBInspectable NSInteger minValue;
/**
 最大值
 **/
@property(nonatomic)IBInspectable NSInteger maxValue;

/**
 设置或获取当前所属的视图控制器
 **/
@property(retain,nonatomic)UIViewController* viewController;

@end

NS_ASSUME_NONNULL_END
