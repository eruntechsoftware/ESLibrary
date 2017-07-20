//
//  ESIQPopUp.h
//  Neighbour
//
//  Created by 明悦 on 16/1/27.
//  Copyright © 2016年 ray. All rights reserved.
//

#define IconImageName @"error.png"
#define ColorPopUpBg [UIColor colorWithRed:0.702 green:0.000 blue:0.000 alpha:1.000]
#define ColorFont [UIColor whiteColor]
#define FontSize 15
#define FontName @"Helvetica-Bold"
#define PaddingInErrorPopUp 5


/**
 Default message for validating length, you can also assign message separately using method 'updateLengthValidationMsg:' for textfields.
 */
#define MsgValidateLength @"This field cannot be blank"
#import <UIKit/UIKit.h>

@interface ESIQPopUp : UIView

@property (nonatomic,assign) CGRect showOnRect;
@property (nonatomic,assign) int popWidth;
@property (nonatomic,assign) CGRect fieldFrame;
@property (nonatomic,copy) NSString *strMsg;
@property (nonatomic,retain) UIColor *popUpColor;

@end
