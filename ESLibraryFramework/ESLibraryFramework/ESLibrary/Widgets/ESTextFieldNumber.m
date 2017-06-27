//
//  ESTextFieldNumber.m
//  Pods
//
//  Created by 杜明悦 on 2017/5/25.
//
//

#import "ESTextFieldNumber.h"

@implementation ESTextFieldNumber

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.regularExpression = @"^[0-9]*$";
        self.regularTooltip = @"请输入正确的数字";
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.regularExpression = @"^[0-9]*$";
        self.regularTooltip = @"请输入正确的数字";
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

@end
