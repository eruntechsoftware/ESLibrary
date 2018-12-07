//
//  ESProgressView.m
//  ESLibraryFramework
//
//  Created by 杜明悦 on 2018/12/7.
//  Copyright © 2018年 杜明悦. All rights reserved.
//

#import "ESProgressView.h"

@implementation ESProgressView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void) initializ
{
    _viewController = [self searchViewController];
    if(_maxValue==0)
    {
        [self makeToast:@"maxValue不能为0"];
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
 @param dataName 数据名称
 @param data 数据对象
 */
-(void) release:(NSString *)dataName data:(Data *)data
{
    if (data != nil && [[data.name lowercaseString] isEqualToString:[_name lowercaseString]]) {
        if(_maxValue>0)
        {
            float progress= (CGFloat)([[data toFloat] floatValue] / _maxValue);
            [self setProgress:progress];
        }
    }
}

/**
 数据收集，返回ETDataCollection
 */
-(DataCollection*) collect
{
    DataCollection *datas = (DataCollection*)[NSMutableArray arrayWithCapacity:1];
    Data *data = [[Data alloc] initWithDataName:[self name] dataValue:[NSString stringWithFormat:@"%f",_progressValue]];
    [datas addObject:data];
    return datas;
}

-(NSString *) getCollectSign
{
    return _collectSign;
}

- (void)collectSign:(NSString *)sign {
    _collectSign=sign;
}

-(BOOL)dataValidator
{
    //如果不能为空，则提示消息
    if(_isRequired && self.progressValue > _maxValue){
        return NO;
    }
    return YES;
}

/**
 * 提示校验错误
 * **/
-(void) hint
{
    [self.viewController.view makeToast:self.placeholder duration:3.0 position:CSToastPositionBottom];
}


-(NSString*) getName
{
    return _name;
}

/**
 自定义高度
 */
- (void) sizeToFit{
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, _progressHeight);
    self.transform = transform;
}


- (NSString *)stateHiddenId {
    return _stateHiddenId;
}

- (NSString *)wantedStateValue {
    return _wantedStateValue;
}

-(BOOL)wantedModeType{
    return _wantedModeType;
}

- (void)protectState:(BOOL)isMatched {
    if(isMatched)
    {
        [self setHidden:NO];
    }
    else
    {
        [self setHidden:YES];
    }
}

- (void)stateHiddenId:(NSString *)stateHiddenId {
    _stateHiddenId=stateHiddenId;
}

- (void)wantedStateValue:(NSString *)wantedStateValue {
    _wantedStateValue=wantedStateValue;
}

- (void)wantedModeType:(BOOL)wantedModeType
{
    _wantedModeType=wantedModeType;
}

- (void)setProgressHeight:(float)progressHeight
{
    _progressHeight = progressHeight;
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, _progressHeight);
    self.transform = transform;
}

@end
