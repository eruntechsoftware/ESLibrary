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

/**
 初始化事件
 */
-(void)initializ
{
    self.hidden=YES;
    _viewController = [self searchViewController];
    _validator=[[Validator alloc] initWithExpression:_regularExpression];
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
        _value=data.value;
    }
}

/**
 数据收集，返回DataCollection
 */
-(DataCollection*) collect
{
    DataCollection *datas = [[DataCollection alloc] initWithCapacity:1];
    Data *data = [[Data alloc] initWithDataName:self.name dataValue:[self value]];
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

-(BOOL)dataValidator
{
    //如果不能为空，则提示消息
    if(_isRequired){
        if(_value==nil || [[_value trim] isEqualToString:@""])
        return NO;
    }
    return YES;
}

/**
 * 提示校验错误
 * **/
-(void) hint
{
    [self.viewController.view makeToast:self.placeholder duration:3.0
                               position:CSToastPositionBottom];
}

- (void)setIsRequired:(BOOL)isRequired
{
    _isRequired=isRequired;
}

- (void)setValue:(NSString *)value
{
    _value = value;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    _value = title;
}

@end
