//
//  ESNumberPickerView.m
//  ahome
//
//  Created by 杜明悦 on 2018/11/19.
//  Copyright © 2018年 杜明悦. All rights reserved.
//

#import "ESNumberPickerView.h"

@implementation ESNumberPickerView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.contentMode = UIViewContentModeRedraw;
        _bound = self.bounds;
        
        _btnAdd = [UIImageView new];
        [_btnAdd setImage:[UIImage imageNamed:@"btn_add_icon"]];
        [_btnAdd setHighlightedImage:[UIImage imageNamed:@"btn_add_icon_pre"]];
        
        _btnAdd.userInteractionEnabled = YES;
        UITapGestureRecognizer *btnAddTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnAddOnClick:)];
        [_btnAdd addGestureRecognizer:btnAddTapGesture];
        
        [self addSubview:_btnAdd];
        
        _btnMinus = [UIImageView new];
        [_btnMinus setImage:[UIImage imageNamed:@"btn_minus_icon"]];
        [_btnMinus setHighlightedImage:[UIImage imageNamed:@"btn_minus_icon_pre"]];
        [self addSubview:_btnMinus];
        
        _btnMinus.userInteractionEnabled = YES;
        UITapGestureRecognizer *btnMinusTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnMinusOnClick:)];
        [_btnMinus addGestureRecognizer:btnMinusTapGesture];
        
        if(_textField==nil)
        {
            _textField=[ESTextField new];
        }
        _textField.borderStyle=UITextBorderStyleNone;
        _textField.textAlignment=NSTextAlignmentCenter;
        _textField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter|UIControlContentHorizontalAlignmentCenter;//居中
        _textField.keyboardType=UIKeyboardTypeNumberPad;
        [self addSubview:_textField];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 3.0;
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        self.layer.shadowOffset =  CGSizeMake(3, 5);
        self.layer.shadowOpacity = 0.0;
        self.layer.shadowColor =  [UIColor blackColor].CGColor;
    }
    return self;
}

// 2.重写layoutSubviews，给自己内部子控件设置frame
- (void)layoutSubviews {
    [super layoutSubviews];
    _bound = self.bounds;
    _btnMinus.frame = CGRectMake(5, (_bound.size.height-30)/2, 30, 30);
    _textField.frame = CGRectMake(_btnMinus.frame.size.width+2, (_bound.size.height-30)/2, _bound.size.width-70, 30);
    _btnAdd.frame = CGRectMake(_bound.size.width-40, (_bound.size.height-30)/2, 30, 30);
    
    
}

- (void)collectSign:(NSString *)collectSign
{
    if(_textField==nil)
    {
        _textField=[ESTextField new];
    }
    _textField.collectSign=collectSign;
}

-(void)btnAddOnClick:(UIGestureRecognizer *)gestureRecognizer
{
    if(_value==_maxValue)
    {
        return;
    }
    else
    {
        _value+=1;
        [_textField setText:[NSString stringWithFormat:@"%ld",(long)_value]];
    }
}

-(void)btnMinusOnClick:(UIGestureRecognizer *)gestureRecognizer
{
    if(_value==_minValue)
    {
        return;
    }
    else
    {
        _value-=1;
        [_textField setText:[NSString stringWithFormat:@"%ld",(long)_value]];
    }
}

- (void)setMaxValue:(int)maxValue
{
    
    _maxValue=maxValue;
}

- (void)setMinValue:(int)minValue
{
    _value=minValue;
    _minValue=minValue;
    if(_textField!=nil)
    {
        [_textField setText:[NSString stringWithFormat:@"%ld",(long)_value]];
    }
}

/**
 初始化事件
 */
-(void)initializ
{
    _viewController = [self searchViewController];
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
        [_textField setText:(NSString*)[data value]];
        _value =[_textField.text integerValue];
    }
}

/**
 数据收集，返回DataCollection
 */
-(DataCollection*) collect
{
    DataCollection *datas = [[DataCollection alloc] initWithCapacity:1];
    Data *data = [[Data alloc] initWithDataName:self.name dataValue:[NSString stringWithFormat:@"%ld",(long)_value]];
    [datas addObject:data];
    return datas;
}

/**
 获取收集标记集合，返回NSString[]
 */
-(NSString *) getCollectSign
{
    return _collectSign;
}

-(NSString*) getName
{
    return _name;
}

- (void)setName:(NSString *)name
{
    _name=name;
}

@end
