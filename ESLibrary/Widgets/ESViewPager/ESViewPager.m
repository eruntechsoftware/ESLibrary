//
//  ESViewPager.m
//  Neighbour
//
//  Created by 杜明悦 on 2016/10/18.
//  Copyright © 2016年 杜明悦. All rights reserved.
//

#import "ESViewPager.h"

@implementation ESViewPager
@synthesize viewPagerDelegate=_viewPagerDelegate;
@synthesize viewControllerArray=_viewControllerArray;
@synthesize count=_count;
@synthesize index=_index;
@synthesize titleColor=_titleColor;
@synthesize titleHighlightedColor=_titleHighlightedColor;
@synthesize flagColor=_flagColor;
@synthesize scrollView = _scrollView;

/**
 初始化ESViewPager布局
 @param array 视图容器
 @return ESViewPager
 */
-(id)initWithArray:(NSMutableArray*) array{
    CGRect bounds = [UIScreen mainScreen].bounds;
    if (self.backgroundColor==nil) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    //设置标题颜色
    if (_titleColor==nil) {
        _titleColor=[UIColor blackColor];
    }
    
    //设置标题高亮颜色
    if (_titleHighlightedColor==nil) {
        _titleHighlightedColor=[UIColor orangeColor];
    }
    
    
    //设置标识线颜色
    if(_flagColor==nil){
        _flagColor=[UIColor redColor];
    }
    _oldIndex = 0;
    
    _scrollIndex = -1;
    
    //设置题栏默认标高度
    _titleHeight = 0;
    //设置标识线高度
    _flagHeight = 0;
    
    _titleViewHeight = 0;
    
    //实例化滚动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:bounds];
    _scrollView.delegate = self;
    
    self=[super initWithFrame:bounds];
    if(self){
        _viewControllerArray = array;
    }
    return self;
}

/**
 初始化ESViewPager布局
 @param array 视图容器
 @param rootViewController 根视图控制器
 @return ESViewPager
 */
-(id)initWithArray:(NSMutableArray*) array rootViewController:(BaseViewController*) rootViewController{
    self=[self initWithArray:array];
    if(self){
        self.rootViewController=rootViewController;
    }
    return self;
}

/**
 初始化ESViewPager布局
 @param array 视图容器
 @param rootViewController 根视图控制器
 @param titleArray 标题数组
 @return ESViewPager
 */
-(id)initWithArray:(NSMutableArray*) array rootViewController:(BaseViewController*) rootViewController titles:(NSMutableArray*)titleArray{
    self = [self initWithArray:array rootViewController:rootViewController];
    if(self){
        _titleArray = titleArray;
    }
    return self;
}

/**
 初始化ESViewPager布局
 @param frame 布局范围
 @return ESViewPager
 */
-(id)initWithFrame:(CGRect)frame viewControllerArray:(NSMutableArray*) array{
    
    //实例化滚动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:frame];
    _scrollView.delegate = self;
    
    self=[super initWithFrame:frame];
    if(self){
        _viewControllerArray = array;
    }
    return self;
}

/**
 根据视图容器布置当前滚动视图布局,并显示
 */
-(void)show{
    
    
    //初始化一下高度，先加载_scrollView，解决点击被标题遮盖的问题
    if(_titleArray!=nil && _titleArray.count>0){
    
        //设置题栏默认标高度
        _titleHeight = 40;
        //设置标识线高度
        _flagHeight = 1;
        
        _titleViewHeight = 42;
        
    }
    
    if(_viewControllerArray.count>0){
        
        self.count = _viewControllerArray.count;
        
        //设置_scrollView的宽高和位置
        _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-_titleViewHeight);
        
        //设置_scrollView的内容尺寸
        _scrollView.contentSize = CGSizeMake(_count * SCREEN_WIDTH, 0);
        _scrollView.showsHorizontalScrollIndicator = false;
        _scrollView.pagingEnabled = YES;
        _scrollView.alwaysBounceHorizontal=YES;
        _scrollView.alwaysBounceVertical=NO;
        
        //设置默认显示的ViewController
        CGFloat index=0;
        for (BaseViewController *viewController in _viewControllerArray) {
            
            viewController.view.frame = CGRectMake(SCREEN_WIDTH*index, _titleViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-_titleViewHeight);
            
            if([viewController isKindOfClass:[BaseViewController class]]){
                viewController.rootViewController = self.rootViewController;
            }
            
            [_scrollView addSubview:viewController.view];
            index+=1;
        }
        [self addSubview:_scrollView];
    }
    
    //如果标题不为空则布局标题行
    if(_titleArray!=nil && _titleArray.count>0){
        
        //设置题栏默认标高度
        _titleHeight = 40;
        //设置标识线高度
        _flagHeight = 1;
        
        _titleViewHeight = 42;
        
        _titleWidth = SCREEN_WIDTH/_titleArray.count;
        
        //初始化标题视图数组
        _titleLabelArray = [NSMutableArray arrayWithCapacity:_titleArray.count];
        
        for(int i=0; i<_titleArray.count; i++){
            
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(_titleWidth*i, 0, _titleWidth, _titleHeight)];
            
            title.textAlignment = NSTextAlignmentCenter;
            title.text = [_titleArray objectAtIndex:i];
            title.textColor = _titleColor;
            [title setHighlightedTextColor:_titleHighlightedColor];
            title.font = [UIFont fontWithName:@"Helvetica" size:14];
            
            //设置天际手势
            [title setUserInteractionEnabled:YES];
            UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewToPageIndexByTag:)];
            ges.numberOfTapsRequired = 1;
            title.tag = i;
            [title addGestureRecognizer:ges];
            
            [self addSubview:title];
            
            [_titleLabelArray addObject:title];
        }
        
        UILabel *title = [_titleLabelArray objectAtIndex:0];
        [title setHighlighted:YES];

        //计算标识线起始位置、宽度
        _flagWidth = SCREEN_WIDTH/_titleArray.count/2;
        _flagStartX = SCREEN_WIDTH/_titleArray.count/4;
        
        //初始化标识线对象
        _flagView = [[UIView alloc] initWithFrame:CGRectMake(_flagStartX, _titleHeight, _flagWidth, _flagHeight)];
        _flagView.backgroundColor = [UIColor redColor];
        
        [self addSubview:_flagView];
    }
    
}

/*
 *  scollview滚动监听
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //获取滚动视图宽度和起始位
    CGFloat scrollviewW =  scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    
    int page = (x + scrollviewW / 2) /  scrollviewW;
    _index = page;
    
    //减少重复性滚动操作
    if(_index!=_scrollIndex){
        [self scrollFlagView:_index];
        _scrollIndex = _index;
    }
    
    if(_viewPagerDelegate != nil){
        [_viewPagerDelegate viewPagerScrollDid:_index];
    }
}

/**
 滑动到指定索引页
 @param index 索引下标
 */
-(void)scrollViewToPageIndex:(NSInteger)index{

    [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, _flagView.frame.size.height+_flagView.frame.size.height) animated:YES];
    
    [self scrollFlagView:index];

    _index = index;
}


/**
 滑动到指定索引页
 @param ges 索引手势
 */
-(void)scrollViewToPageIndexByTag:(UITapGestureRecognizer*)ges{
    
    int index = (int)ges.view.tag;
    [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, _flagView.frame.size.height+_flagView.frame.size.height) animated:NO];
    
   // [self scrollFlagView:index];
    
    _index = index;
}

/**
 滑动结束后执行的处理
 @param index 索引下标
 */
-(void)viewPagerScrollDid:(NSInteger)index{
    [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, 50)  animated: true];
}

/**
 滑动结束后标识线的滚动
 @param index 索引下标
 */
-(void)scrollFlagView:(NSInteger)index{
    
    //计算移动的目标位置
    CGFloat _StartX = _flagStartX+_titleWidth*index;
    CGRect flagViewFrame = _flagView.frame;
    
    flagViewFrame = CGRectMake(_StartX, flagViewFrame.origin.y, flagViewFrame.size.width, flagViewFrame.size.height);
    
    [UIView animateWithDuration:0.3 animations:^{
        _flagView.frame = flagViewFrame;
        
    }];

    UILabel *title = [_titleLabelArray objectAtIndex:index];
    [title setHighlighted:YES];
    
    //更新标题栏状态
    title = [_titleLabelArray objectAtIndex:_oldIndex];
    [title setHighlighted:NO];
    
    _oldIndex = index;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if ([scrollView isKindOfClass:[UIScrollView class]]) {
        NSLog(@"ScrollView在滚动");
        
        
    }else if ([scrollView isKindOfClass:[UITableView class]]) {
        NSLog(@"TableView在滚动");
    }
}

/**
 设置标识线颜色
 @param flagColor 标识线颜色
 */
-(void)setFlagColor:(UIColor *)flagColor{
    _flagColor = flagColor;
}

/**
 设置标题文本颜色
 @param titleColor 标题颜色
 */
-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor=titleColor;
}

/**
 设置标题高亮时文本颜色
 @param titleHighlightedColor 标题高亮颜色
 */
-(void)setTitleHighlightedColor:(UIColor *)titleHighlightedColor{
    _titleHighlightedColor=titleHighlightedColor;
}
@end
