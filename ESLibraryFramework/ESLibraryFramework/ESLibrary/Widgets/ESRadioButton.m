//
//  ESCheckBox.m
//  IndicatorPan
//
//  Created by 吕英良 on 2017/5/25.
//  Copyright © 2017年 吕英良. All rights reserved.
//

#import "ESRadioButton.h"

@implementation ESRadioButton

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
    if(_stateNormalColor==nil)
    {
        _stateNormalColor=self.titleLabel.textColor;
    }
    if(_stateCheckedColor==nil)
    {
        _stateCheckedColor=self.titleLabel.textColor;
    }
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
    if (data != nil && [[data.name lowercaseString] isEqualToString:[_name lowercaseString]])
    {
        _value = [data value];
        if([[_value trim] isEqualToString:@"1"] || [[[_value trim] lowercaseString] isEqualToString:@"true"])
        {
            [self setChecked:YES];
        }
        else
        {
            [self setChecked:NO];
        }
    }
}

/**
 数据收集，返回DataCollection
 */
-(DataCollection*) collect
{
    DataCollection *datas = [[DataCollection alloc] initWithCapacity:1];
    Data *data = [[Data alloc] initWithDataName:self.name dataValue:self.value];
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
    
    CGFloat imageWH = self.frame.size.height * 0.5;
    CGFloat LabelW = self.frame.size.width - imageWH - 15;
    
    self.titleLabel.frame = CGRectMake(imageWH + 10, 0, LabelW, self.frame.size.height);
    
    _stateNormalImageView.frame = CGRectMake(5, imageWH * 0.5, imageWH, imageWH);
    [self addSubview:_stateNormalImageView];
    
    _stateCheckedImageView.frame = _stateNormalImageView.frame;
    [self addSubview:_stateCheckedImageView];
}

/**
    更改选中状态
 @param sender 点击的对象
 */
- (void)changeState:(UIButton *)sender
{
    if(_checked==YES)
    {
        [self setChecked:NO];
    }
    else
    {
        [self setChecked:YES];
    }
}

- (void)setChecked:(BOOL)checked
{
    _checked=checked;
    if(checked==YES)
    {
        _stateCheckedImageView.hidden=NO;
        _stateNormalImageView.hidden=YES;
        self.titleLabel.textColor = _stateCheckedColor;
        _value=@"1";
    }
    else
    {
        _stateCheckedImageView.hidden=YES;
        _stateNormalImageView.hidden=NO;
        self.titleLabel.textColor = _stateNormalColor;
        _value=@"0";
    }
}

- (void)setStateNormalImage:(UIImage *)stateNormalImage
{
    _stateNormalImage=stateNormalImage;
    _stateNormalImageView = [[UIImageView alloc]initWithImage:_stateNormalImage];
    _stateNormalColor = [stateNormalImage mostColor:stateNormalImage];
}

- (void)setStateCheckedImage:(UIImage *)stateCheckedImage
{
    _stateCheckedImage=stateCheckedImage;
    _stateCheckedImageView = [[UIImageView alloc]initWithImage:_stateCheckedImage];
    _stateCheckedImageView.hidden=YES;
    _stateCheckedColor = [stateCheckedImage mostColor:stateCheckedImage];
}

-(void)setViewGroup:(id)viewGroup
{
    _viewGroup=viewGroup;
}

@end
