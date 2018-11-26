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
    [self addTarget:self action:@selector(changeState:) forControlEvents:UIControlEventTouchUpInside];
}

/**
 获取采集标记名
 */
-(NSArray*) getRequest
{
    NSArray* array = [[NSArray alloc] initWithObjects:_name, nil];
    return array;
}

/**
 将数据发布到指定位置
 */
-(void) release:(NSString *)dataName data:(Data *)data
{
    if (data != nil && [[data.name lowercaseString] isEqualToString:[_name lowercaseString]]) {
        [self setTitle:(NSString*)data.value forState:UIControlStateNormal];
        [self setTitle:(NSString*)data.value forState:UIControlStateHighlighted];
        [self setTitle:(NSString*)data.value forState:UIControlStateSelected];
        [self setTitle:(NSString*)data.value forState:UIControlStateFocused];
    }
}

/**
 数据收集，返回DataCollection
 */
-(DataCollection*) collect
{
    DataCollection *datas = [[DataCollection alloc] initWithCapacity:1];
    Data *data = [[Data alloc] initWithDataName:self.name dataValue:self.titleLabel.text];
    [datas addObject:data];
    return datas;
}

/**
 设置采集标记，多个标记以‘|!’分割
 例如：ForSave|!ForQuery
 @param sign 采集标记
 */
-(void)setCollectSign:(NSMutableString *)sign{
    _collectSign=sign;
}

/**
 获取收集标记集合，返回NSString[]
 */
-(NSString *) getCollectSign
{
    return _collectSign;
}

- (void)collectSign:(NSMutableString *)sign {
    _collectSign=sign;
}



-(NSString*) getName
{
    return _name;
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
    if(_viewGroup!=nil && [_viewGroup isKindOfClass:[ESViewGroup class]])
    {
        ESViewGroup *viewGroup = (ESViewGroup*)_viewGroup;
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

-(void)setViewGroup:(id)viewGroup
{
    _viewGroup=viewGroup;
}

@end
