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
        [self setImage:[UIImage imageWithCGImage:(__bridge CGImageRef _Nonnull)(_stateNormalImage)] forState:UIControlStateNormal];
        [self setImage:[UIImage imageWithCGImage:(__bridge CGImageRef _Nonnull)(_stateCheckedImage)] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(changeState:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageWithCGImage:(__bridge CGImageRef _Nonnull)(_stateNormalImage)] forState:UIControlStateNormal];
        [self setImage:[UIImage imageWithCGImage:(__bridge CGImageRef _Nonnull)(_stateCheckedImage)] forState:UIControlStateSelected];
        
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

/**
 添加事件
 **/
-(void)addEvent
{
}

-(void)textBoxChanged:(id)sender
{
    [self dataValidator];
    NSLog(@"文本校验事件");
}

/**
 获取采集标记名
 **/
-(NSArray*) getRequest
{
    NSArray* array = [[NSArray alloc] initWithObjects:_name, nil];
    return array;
}

/**
 将数据发布到指定位置
 **/
-(void) release:(NSString *)dataName data:(Data *)data
{
    if (data != nil && [[data.name lowercaseString] isEqualToString:[_name lowercaseString]]) {
        if ([[data.value toString] isEqualToString:@"1"]) {
            self.selected=YES;
        }
        if ([[data.value toString] isEqualToString:@"0"]) {
            self.selected=NO;
        }
        
        if ([[data.value toString] isEqualToString:@"true"]) {
            self.selected=YES;
        }
        if ([[data.value toString] isEqualToString:@"false"]) {
            self.selected=NO;
        }
    }
}

/**
 数据收集，返回DataCollection
 **/
-(DataCollection*) collect
{
    DataCollection *datas = [[DataCollection alloc] initWithCapacity:1];
    Data *data;
    if (self.selected) {
        data = [[Data alloc] initWithDataName:self.name dataValue:@"1"];
    }else{
        data = [[Data alloc] initWithDataName:self.name dataValue:@"0"];
    }
    [datas addObject:data];
    return datas;
}

/**
 设置采集标记，多个标记以‘|!’分割
 例如：ForSave|!ForQuery
 @param sign 采集标记
 **/
-(void)setCollectSign:(NSMutableString *)sign{
    _collectSign=sign;
}

/**
 获取收集标记集合，返回NSString[]
 **/
-(NSString *) getCollectSign
{
    return _collectSign;
}


-(NSString*) getName
{
    return _name;
}

-(BOOL)dataValidator
{
    return YES;
}

-(void)hint
{
    
}

/**
    更改选中状态
 @param sender 点击的对象
 */
- (void)changeState:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

@end
