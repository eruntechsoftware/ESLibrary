//
//  ESTextFieldMobile.m
//  Pods
//
//  Created by 杜明悦 on 2017/5/25.
//
//

#import "ESTextFieldMobile.h"

@implementation ESTextFieldMobile

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.regularExpression = [DataTypeExpression mobile];
        self.regularTooltip = @"请输入正确的手机号";
        self.placeholder = @"大陆地区手机号";
        self.keyboardType = UIKeyboardTypePhonePad;
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.regularExpression = [DataTypeExpression mobile];
        self.regularTooltip = @"请输入正确的手机号";
        self.placeholder = @"大陆地区手机号";
        self.keyboardType = UIKeyboardTypePhonePad;
    }
    return self;
}
@end
