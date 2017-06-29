//
//  Banner.m
//  OcTest
//
//  Created by 松洋 on 16/10/12.
//  Copyright © 2016年 com.du. All rights reserved.
//  func 轮播图（再带10个分类网格）

#import "ESBanner.h"
#import "ESImageView.h"
#import "UIImageView+WebCache.h"

@implementation ESBanner

//@synthesize collectSign=_collectSign;
@synthesize name=_name;
@synthesize dataType=_dataType;

- (void) initializ
{
    
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
 @param dataName 数据名称
 @param data 数据对象
 **/
-(void) release:(NSString *)dataName data:(Data *)data
{
    
    //初始化图片数组
    _imgsArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    if (data != nil && [[data.name lowercaseString] isEqualToString:[_name lowercaseString]]) {
        NSArray *array = [(NSString*)data.value componentsSeparatedByString:_splitMark];
        for(int i=0;i<array.count;i++){
            [_imgsArray addObject:array[i]];
        }
        
         _imgsCount = (int)_imgsArray.count;
        
        //初始化ScollView
        [self setMyScollViewWithWidth:self.frame.size.width viewHigh:self.frame.size.height];
        [self addImgInBanner:_imgsArray];
        [self addSubview:_uiScollView];
        [self addSubview:[self myPageControl]];
        [self addTimer];
    }
}

/**
 数据收集，返回ETDataCollection
 **/
-(DataCollection*) collect
{
    DataCollection *datas = (DataCollection*)[NSMutableArray arrayWithCapacity:1];
    Data *data = [[Data alloc] initWithDataName:[self name] dataValue:@""];
    [datas addObject:data];
    return datas;
}

-(NSString *) getCollectSign
{
    return @"";
}

-(NSString*) getName
{
    return _name;
}

/**
 初始化小圆点组件
 @param rect  构造出的banner的rect
**/
-(UIPageControl*)myPageControl{
    
    _esPageControl = [[ESPageControl alloc] initWithImg:_defaultPageControlImg _currentPageControlImg:_currentPageControlImg];
    CGSize uiPageControlSize  = [_esPageControl sizeForNumberOfPages:_imgsCount];
    
    _esPageControl.numberOfPages = _imgsCount;
    _esPageControl.bounds = CGRectMake(0, 0, uiPageControlSize.width ,uiPageControlSize.height);
    _esPageControl.center = CGPointMake(self.center.x, self.frame.size.height-10);
    
    if(_currentPageControlColor != nil && _defaultPageControlColor != nil){
        _esPageControl.currentPageIndicatorTintColor = _currentPageControlColor;
        _esPageControl.pageIndicatorTintColor = _defaultPageControlColor;
    }else{
        _esPageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _esPageControl.pageIndicatorTintColor = [UIColor grayColor];
    }
   
    _esPageControl.currentPage = 0;
    
    return _esPageControl;

}

/**
 初始化以及启动定时器
**/
-(void)addTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(next) userInfo:nil repeats:true];
    
    [_timer fire];
}

/**
 切换图片（控制器）
**/
-(void)next{
    
    CGPoint point = CGPointMake([self bounds].size.width *_current, 0);
    [_uiScollView setContentOffset:point animated:true];
    
    _current+=1;
    
    if(_current == _imgsCount){
        
        _current = 0;
    }
}

/**
 初始化小圆点组件
 @param imgArray  banner的图片数组
**/
-(void)addImgInBanner: (NSMutableArray*) imgArray{
    
    CGFloat width = self.frame.size.width;
    
    for (int index=0;index<_imgsCount;index++) {
        
        UIImage *img = [UIImage imageNamed:_imgsArray[index]];  //暂时写的假数据，设置了本地图片
        ESImageView *uiImg = [[ESImageView alloc] init];
        uiImg.image = img;
        uiImg.frame = CGRectMake(width*index,0,width,self.frame.size.height);
        [uiImg setContentMode:UIViewContentModeScaleAspectFill];
        uiImg.clipsToBounds = YES;
        
        NSString *imgUrl = imgArray[index];
        NSURL *nsUrl = [NSURL URLWithString:imgUrl];
        [uiImg sd_setImageWithURL:nsUrl placeholderImage:[UIImage imageNamed:@"t_head"]];
        
        [_uiScollView addSubview:uiImg];
        }
}

/**
 scollview的滚动监听
**/
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat scrollviewW =  scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    CGFloat page = (x + scrollviewW / 2) /  scrollviewW;
    
    self.esPageControl.currentPage = (int)page;
    _current = (int)page;
}

/**
 初始化scollView
 @param width  scollwview的宽度
 @param high  scollwview的高度
**/
-(void)setMyScollViewWithWidth:(CGFloat)width viewHigh:(CGFloat)high{
    
    _uiScollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, high)];
    _uiScollView.contentSize = CGSizeMake(_imgsCount * width, high);//设置uiScollView的内容尺寸
    _uiScollView.scrollEnabled = YES;
    _uiScollView.delegate= self;
    _uiScollView.pagingEnabled = YES;
    _uiScollView.showsHorizontalScrollIndicator = NO;
    _uiScollView.backgroundColor = [UIColor whiteColor];
    
}


@end
