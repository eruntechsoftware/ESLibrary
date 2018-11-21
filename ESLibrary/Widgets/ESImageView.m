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
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnOnClick:)];
    [self addGestureRecognizer:singleTap];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setClipsToBounds:YES];
    self.userInteractionEnabled=YES;
    self.layer.masksToBounds = YES;
    [self setContentMode:UIViewContentModeScaleAspectFill];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnOnClick:)];
    [self addGestureRecognizer:singleTap];
    return self;
}

/**
 获取图片
 */
-(UIImage*)imageWithCache
{
    if(_URL!=nil)
    {
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        NSString* key = [manager cacheKeyForURL:[NSURL URLWithString:_URL]];
        SDImageCache* cache = [SDImageCache sharedImageCache];
        //此方法会先从memory中取。
        return [cache imageFromDiskCacheForKey:key];
    }
//    else
//    {
//        return self.image;
//    }
    return nil;
}


/**
 显示网络图片
 @param url  图片网络尾地址
 */
-(void) setImageURL:(NSString*) url{
    
    @try
    {
        _URL = url;
        NSURL *nsUrl = [NSURL URLWithString:url];
        [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"forHTTPHeaderField:@"Accept"];
        if(_placeholderImage != nil)
        {
            [self sd_setImageWithURL:nsUrl placeholderImage:_placeholderImage];
        }
        else
        {
            [self sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
            {
                
            }];

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
    if(_validator==nil)
    {
        _validator = [[Validator alloc] initWithExpression:[DataTypeExpression url]];
    }
    if (data != nil && [[data.name lowercaseString] isEqualToString:[_name lowercaseString]])
    {
        if([_validator validataWithValue:(NSString*)data.value])
        {
            [self setImageURL:(NSString*)data.value];
        }
        else
        {
            [self setImage:[UIImage imageNamed:(NSString*)data.value]];
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

- (void)collectSign:(NSString *)sign
{
    _collectSign=sign;
}

-(NSString*) getName
{
    return _name;
}

+(NSString *)getImageUrlHead{
    return IMAGE_URL_HEAD;
}

-(void)btnOnClick:(UIGestureRecognizer *)gestureRecognizer
{
    if(_onClickListener!=nil)
    {
        [_onClickListener onClickListener:self];
    }
}
@end
