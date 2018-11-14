//
//  ESButtonCountDown.h
//  HybridTest
//
//  Created by 松洋 on 2017/5/23.
//  Copyright © 2017年 com.du. All rights reserved.
//  倒计时控件

#import <UIKit/UIKit.h>

@interface ESButtonCountDown : UIButton

//倒计时设置的时间
@property (nonatomic,assign) IBInspectable int countDownTime;

//计时器
@property (strong,nonatomic)NSTimer *myTimer;

//按钮标题
@property (strong,nonatomic)NSString *title;

/**
 开始计时
 **/
-(void)startCountDown;

@end
