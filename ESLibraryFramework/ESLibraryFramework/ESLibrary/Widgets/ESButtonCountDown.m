//
//  ESButtonCountDown.m
//  HybridTest
//
//  Created by 松洋 on 2017/5/23.
//  Copyright © 2017年 com.du. All rights reserved.
//  倒计时控件

#import "ESButtonCountDown.h"

@implementation ESButtonCountDown

/**
 控件初始化自动调用
 @param countDownTime xib设计器里面设置的时间参数
 **/
-(void)setCountDownTime:(int)countDownTime{
    
    _countDownTime = countDownTime;
//    [self addTarget:self action:@selector(startCountDown:) forControlEvents:UIControlEventTouchDown];
    
}

/**
 开始计时
 **/
-(void)startCountDown{
    
    _title = self.titleLabel.text;
    self.userInteractionEnabled = NO;
    
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    [timer fire];
}

/**
 倒计时
 @param myTimer 计时器
 **/
-(void) countDown:(NSTimer*) myTimer{
    
    _countDownTime = _countDownTime-1;
    NSString *stringInt = [NSString stringWithFormat:@"%ld",(long)_countDownTime];
    
    //这行和下一行必须同时存在，不然后有button闪烁出现
    self.titleLabel.text = [NSString stringWithFormat:@"%@%@",stringInt,@"s"];
    [self setTitle:[NSString stringWithFormat:@"%@%@",stringInt,@"s"] forState:UIControlStateNormal];
    
    if(_countDownTime == 0){
        self.titleLabel.text = _title;
        [self setTitle:_title forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
        [myTimer invalidate];
    }
}

@end
