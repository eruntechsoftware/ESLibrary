//
//  ESHiddenFeild.m
//  ESLibraryFramework
//
//  Created by 杜明悦 on 2018/10/29.
//  Copyright © 2018 杜明悦. All rights reserved.
//

#import "ESHiddenFeild.h"

@implementation ESHiddenFeild

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        self.hidden=YES;
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden=YES;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
