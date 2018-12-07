//
//  ESRatingBar.m
//  ESLibraryFramework
//
//  Created by 杜明悦 on 2018/12/7.
//  Copyright © 2018年 杜明悦. All rights reserved.
//

#import "ESRatingBar.h"
@interface ESRatingBar()
{
    float _rating;
    float starRating;
    float lastRating;

    float height;
    float width;
}
@property (nonatomic,strong) UIImageView *s1;
@property (nonatomic,strong) UIImageView *s2;
@property (nonatomic,strong) UIImageView *s3;
@property (nonatomic,strong) UIImageView *s4;
@property (nonatomic,strong) UIImageView *s5;
@property (nonatomic,strong) id<RatingBarDelegate> delegate;
@end

@implementation ESRatingBar

@synthesize rating=_rating;

- (void)awakeFromNib
{
    [super awakeFromNib];
    _s1 = [[UIImageView alloc] initWithImage:_ratingUnSelectedImage];
    _s2 = [[UIImageView alloc] initWithImage:_ratingUnSelectedImage];
    _s3 = [[UIImageView alloc] initWithImage:_ratingUnSelectedImage];
    _s4 = [[UIImageView alloc] initWithImage:_ratingUnSelectedImage];
    _s5 = [[UIImageView alloc] initWithImage:_ratingUnSelectedImage];
    
    [_s1 setUserInteractionEnabled:NO];
    [_s2 setUserInteractionEnabled:NO];
    [_s3 setUserInteractionEnabled:NO];
    [_s4 setUserInteractionEnabled:NO];
    [_s5 setUserInteractionEnabled:NO];
    
    [self addSubview:_s1];
    [self addSubview:_s2];
    [self addSubview:_s3];
    [self addSubview:_s4];
    [self addSubview:_s5];
}

/**
 *  初始化设置未选中图片、半选中图片、全选中图片，以及评分值改变的代理（可以用
 *  Block）实现
 *
 *  @param deselectedName   未选中图片名称
 *  @param halfSelectedName 半选中图片名称
 *  @param fullSelectedName 全选中图片名称
 *  @param delegate          代理
 */
-(void)setImageDeselected:(NSString *)deselectedName halfSelected:(NSString *)halfSelectedName fullSelected:(NSString *)fullSelectedName andDelegate:(id<RatingBarDelegate>)delegate{
    
    self.delegate = delegate;
    
    _ratingUnSelectedImage = [UIImage imageNamed:deselectedName];
    _ratingHalfSelectedImage = halfSelectedName == nil ? _ratingUnSelectedImage : [UIImage imageNamed:halfSelectedName];
    _ratingFullSelectedImage = [UIImage imageNamed:fullSelectedName];
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    height = 0.0,width = 0.0;
    
    starRating = 0.0;
    lastRating = 0.0;
    
    CGRect frame = [self frame];
    width = frame.size.width/5;
    [_s1 setFrame:CGRectMake(0,         0, width, width)];
    [_s2 setFrame:CGRectMake(width,     0, width, width)];
    [_s3 setFrame:CGRectMake(2 * width, 0, width, width)];
    [_s4 setFrame:CGRectMake(3 * width, 0, width, width)];
    [_s5 setFrame:CGRectMake(4 * width, 0, width, width)];
}

/**
 *  设置评分值
 *
 *  @param rating 评分值
 */
-(void)displayRating:(float)rating{
    [_s1 setImage:_ratingUnSelectedImage];
    [_s2 setImage:_ratingUnSelectedImage];
    [_s3 setImage:_ratingUnSelectedImage];
    [_s4 setImage:_ratingUnSelectedImage];
    [_s5 setImage:_ratingUnSelectedImage];
    
    if (rating >= 0.5) {
        [_s1 setImage:_ratingHalfSelectedImage];
    }
    if (rating >= 1) {
        [_s1 setImage:_ratingFullSelectedImage];
    }
    if (rating >= 1.5) {
        [_s2 setImage:_ratingHalfSelectedImage];
    }
    if (rating >= 2) {
        [_s2 setImage:_ratingFullSelectedImage];
    }
    if (rating >= 2.5) {
        [_s3 setImage:_ratingHalfSelectedImage];
    }
    if (rating >= 3) {
        [_s3 setImage:_ratingFullSelectedImage];
    }
    if (rating >= 3.5) {
        [_s4 setImage:_ratingHalfSelectedImage];
    }
    if (rating >= 4) {
        [_s4 setImage:_ratingFullSelectedImage];
    }
    if (rating >= 4.5) {
        [_s5 setImage:_ratingHalfSelectedImage];
    }
    if (rating >= 5) {
        [_s5 setImage:_ratingFullSelectedImage];
    }
    
    starRating = rating;
    lastRating = rating;
    _rating = rating;
    [_delegate ratingChanged:rating];
}

/**
 *  获取当前的评分值
 *
 *  @return 评分值
 */
-(float)rating{
    return starRating;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (self.isIndicator) {
        return;
    }
    
    CGPoint point = [[touches anyObject] locationInView:self];
    int newRating = (int) (point.x / width) + 1;
    if (newRating > 5)
        return;
    
    if (point.x < 0) {
        newRating = 0;
    }
    
    if (newRating != lastRating){
        [self displayRating:newRating];
    }
}

- (void) initializ
{
    _viewController = [self searchViewController];
    if(_ratingFullSelectedImage==nil)
    {
        [self.viewController.view makeToast:@"请设置RatingFullSelectedImage图片"];
        return;
    }
    if(_ratingUnSelectedImage==nil)
    {
        [self.viewController.view makeToast:@"请设置RatingUnSelectedImage图片"];
        return;
    }
    if(_ratingHalfSelectedImage==nil)
    {
        [self.viewController.view makeToast:@"请设置RatingHalfSelectedImage图片"];
        return;
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
            [self displayRating:[[data toFloat] floatValue]];
    }
}

/**
 数据收集，返回ETDataCollection
 */
-(DataCollection*) collect
{
    DataCollection *datas = (DataCollection*)[NSMutableArray arrayWithCapacity:1];
//    Data *data = [[Data alloc] initWithDataName:[self name] dataValue:[NSString stringWithFormat:@"%f",_rating]];
//    [datas addObject:data];
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

- (void)setRating:(float)rating
{
    _rating = rating;
    [self displayRating:rating];
}
@end
