//
//  ESImageView.m
//
//  Created by 松洋 on 2017/6/26.
//  Copyright © 2017年 com.du. All rights reserved.
//

#import "ESImageView.h"

@implementation ESImageView


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    [self setClipsToBounds:YES];
    self.userInteractionEnabled=YES;
    self.layer.masksToBounds = YES;
    [self setContentMode:UIViewContentModeScaleAspectFill];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setClipsToBounds:YES];
    self.userInteractionEnabled=YES;
    self.layer.masksToBounds = YES;
    [self setContentMode:UIViewContentModeScaleAspectFill];
    return self;
}

/**
 显示网络图片
 @param urlBody  图片网络尾地址
 */
-(void) setImageURL:(NSString*) url{
    
    @try
    {
        NSURL *nsUrl = [NSURL URLWithString:url];
        
        if(_placeholderImage != nil)
        {
            [self sd_setImageWithURL:nsUrl placeholderImage:_placeholderImage];
        }
        else
        {
            [self sd_setImageWithURL:nsUrl];
        }
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
        
    }
    
}

/**
 设置边框颜色
 */
-(void)setBorderColor:(UIColor *)borderColor{
    
    self.layer.borderColor = borderColor.CGColor;
}

/**
 设置边框宽度
 */
-(void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;

}

/**
 设置圆角度数
 */
-(void)setCornerRadius:(CGFloat)cornerRadius{
    
    self.layer.cornerRadius = cornerRadius;
}

- (void) initializ
{
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
        if([[data.value toString] containsString:@"http://"] || [[data.value toString] containsString:@"https://"])
        {
            [self setImageURL:[data.value toString]];
        }
        else
        {
            [self setImage:[UIImage imageNamed:[data.value toString]]];
        }
    }
}

/**
 数据收集，返回ETDataCollection
 */
-(DataCollection*) collect
{
    DataCollection *datas = (DataCollection*)[NSMutableArray arrayWithCapacity:1];
    Data *data = [[Data alloc] initWithDataName:[self name] dataValue:@""];
    [datas addObject:data];
    return datas;
}

-(NSString *) getCollectSign
{
    return _collectSign;
}

-(NSString*) getName
{
    return _name;
}

+(NSString *)getImageUrlHead{
    return IMAGE_URL_HEAD;
}

@end
