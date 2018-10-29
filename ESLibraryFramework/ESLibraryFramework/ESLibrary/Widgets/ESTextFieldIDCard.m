//
//  ESTextFieldIDCard.m
//  Pods
//
//  Created by 杜明悦 on 2017/5/25.
//
//

#import "ESTextFieldIDCard.h"

@implementation ESTextFieldIDCard

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.regularExpression = [DataTypeExpression idCard];
        self.placeholder = @"请输入身份证号码";
//        self.placeholder = @"身份证";
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.regularExpression = [DataTypeExpression idCard];
        self.placeholder = @"请输入身份证号码";
//        self.placeholder = @"身份证";
    }
    return self;
}


@end
