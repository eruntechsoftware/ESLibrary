//
//  ESCheckBox.m
//  IndicatorPan
//
//  Created by 吕英良 on 2017/5/25.
//  Copyright © 2017年 吕英良. All rights reserved.
//

#import "ESCheckBox.h"

@implementation ESCheckBox

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addTarget:self action:@selector(changeState:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

/**
 初始化事件
 **/
-(void)initializ
{
    _viewController = [self searchViewController];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.bounds;
    _stateNormalImageView.frame = CGRectMake(5, frame.size.height/2-25/2, 25, 25);
    [self addSubview:_stateNormalImageView];
    
    _stateCheckedImageView.frame = CGRectMake(5, frame.size.height/2-25/2, 25, 25);
    [self addSubview:_stateCheckedImageView];
}

/**
    更改选中状态
 @param sender 点击的对象
 */
- (void)changeState:(UIButton *)sender
{
    if([self superview]!=nil && [[self superview] isKindOfClass:[ESViewGroup class]])
    {
        ESViewGroup *viewGroup = (ESViewGroup*)[self superview];
        [viewGroup selectTag:_value];
    }
}

- (void)setChecked:(BOOL)checked
{
    _checked=checked;
    if(_checked==YES)
    {
        _stateCheckedImageView.hidden=NO;
        _stateNormalImageView.hidden=YES;
    }
    else
    {
        _stateCheckedImageView.hidden=YES;
        _stateNormalImageView.hidden=NO;
    }
}

- (void)setStateNormalImage:(UIImage *)stateNormalImage
{
    _stateNormalImage=stateNormalImage;
    _stateNormalImageView = [[UIImageView alloc]initWithImage:_stateNormalImage];
}

- (void)setStateCheckedImage:(UIImage *)stateCheckedImage
{
    _stateCheckedImage=stateCheckedImage;
    _stateCheckedImageView = [[UIImageView alloc]initWithImage:_stateCheckedImage];
    _stateCheckedImageView.hidden=YES;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
//    [_stateNormalImage drawInRect:CGRectMake(5, self.bounds.size.height/2-25/2, 25, 25)];
}

@end
