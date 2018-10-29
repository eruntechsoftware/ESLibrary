//
//  ESTextFieldEmail.m
//  Pods
//
//  Created by 杜明悦 on 2017/5/25.
//
//

#import "ESTextFieldEmail.h"

@implementation ESTextFieldEmail

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
//        self.regular = @"^[0-9A-Za-z]{1,50}";
//        self.regularTooltip = @"请输入正确的URL";
//        self.placeholder = @"网址";
        self.regularExpression = [DataTypeExpression eMail];
        self.placeholder = @"请输入邮箱地址";
//        self.placeholder = @"eMail地址";
        self.keyboardType = UIKeyboardTypeEmailAddress;
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.regularExpression = [DataTypeExpression eMail];
        self.placeholder = @"请输入邮箱地址";
//        self.placeholder = @"eMail地址";
        self.keyboardType = UIKeyboardTypeEmailAddress;
    }
    return self;
}

@end
