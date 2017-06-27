//
//  UIButtonDelete.m
//  Eruntech
//
//  Created by 杜明悦 on 13-10-17.
//  Copyright (c) 2013年 杜明悦. All rights reserved.
//

#import "ESButtonDelete.h"

@implementation ESButtonDelete

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) initializ{
    [super initializ];
    [self setTitle:@"提示"];
    [self setConfirmMessage:@"确定要执行删除操作吗？"];
    [self setMessage:@"删除成功！"];
    [self setSign:@"ForDel"];
}

/**
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
**/

@end
