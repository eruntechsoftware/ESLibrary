//
//  ESViewPager.m
//  Neighbour
//
//  Created by 杜明悦 on 2016/10/18.
//  Copyright © 2016年 杜明悦. All rights reserved.
//

#import "ESViewPager.h"

@interface ESViewPager()
@property(nonatomic,strong) NSMutableArray *titleArray;//标题数组
@property(nonatomic,strong) NSMutableArray *titleLabelArray;//标题视图数组
@property(nonatomic,strong)UIView *tabIndexerView;//标识线
@property(nonatomic)CGFloat tabTitleWidth;//定义标题文本宽、高、标识线宽、高
@property(nonatomic)CGFloat tabIndexerWidth;
@property(nonatomic)CGFloat tabIndexerStartX;//FlagView起始位置
@property(nonatomic)CGFloat titleViewHeight;//标题区域高度，含标识线
@property(nonatomic)NSInteger oldIndex;//记录原索引
@property(nonatomic)NSInteger scrollIndex;//记录SCrollView正在滚动时的索引
@property(nonatomic)CGFloat screenWidth;//屏幕宽度
@property(nonatomic)CGFloat screenHeight;//屏幕高度
@property(nonatomic)BOOL isLayoutSubViews;
@end

@implementation ESViewPager
@synthesize viewPagerDelegate=_viewPagerDelegate;
@synthesize viewControllerArray=_viewControllerArray;
@synthesize count=_count;
@synthesize scrollView = _scrollView;

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        CGRect bounds = self.bounds;
        
        if(_tabTitleFontSize==0)
        {
            _tabTitleFontSize=14;
        }
        
        if (self.backgroundColor==nil) {
            self.backgroundColor = [UIColor whiteColor];
        }
        
        //设置标题颜色
        if (_tabTitleTextDefaultColor==nil) {
            _tabTitleTextDefaultColor=[UIColor blackColor];
        }
        
        //设置标题高亮颜色
        if (_tabTitleHighlightedColor==nil) {
            _tabTitleHighlightedColor=[UIColor redColor];
        }
        
        
        //设置标识线颜色
        if(_tabIndexerColor==nil){
            _tabIndexerColor=[UIColor redColor];
        }
        _oldIndex = 0;
        
        _scrollIndex = -1;
        _scrollView = [UIScrollView new];
        _scrollView.delegate = self;
        
    }
    return self;
}

/**
 初始化ESViewPager布局
 @param viewControllerArray 视图容器
 @param rootViewController 根视图控制器
 @param titleArray 标题数组
 */
-(void)initWithViewController:(NSMutableArray*) viewControllerArray rootViewController:(BaseViewController*) rootViewController titles:(NSMutableArray*)titleArray{
    [self removeAllSubViews];
    self.viewControllerArray = viewControllerArray;
    self.rootViewController=rootViewController;
    self.titleArray = titleArray;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    self.frame=CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
    //实例化滚动视图
    _scrollView.frame =CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
    [self addSubViewController];
}

-(void)removeAllSubViews
{
    @try
    {
        if(self.subviews!=nil && self.subviews.count>0)
        {
            for(UIView *subView in self.subviews)
            {
                [subView removeFromSuperview];
            }
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 根据视图容器布置当前滚动视图布局,并显示
 */
-(void)addSubViewController{
    if(_viewControllerArray!=nil && _viewControllerArray.count>0){
        
        if(self.subviews!=nil && self.subviews.count>0)
        {
            for(UIView *subView in self.subviews)
            {
                [subView removeFromSuperview];
            }
        }
        
        CGRect screen_bounds_size = self.bounds;
        self.count = _viewControllerArray.count;
        //设置_scrollView的内容尺寸
        _scrollView.contentSize = CGSizeMake(_count * screen_bounds_size.size.width, 0);
        _scrollView.showsHorizontalScrollIndicator = false;
        _scrollView.pagingEnabled = YES;
        _scrollView.alwaysBounceHorizontal=YES;
        _scrollView.alwaysBounceVertical=NO;
        
        //设置默认显示的ViewController
        CGFloat index=0;
        
        for (BaseViewController *viewController in _viewControllerArray) {
            
            viewController.view.frame = CGRectMake(screen_bounds_size.size.width*index, _titleViewHeight, screen_bounds_size.size.width, screen_bounds_size.size.height-_titleViewHeight);
            
            if([viewController isKindOfClass:[BaseViewController class]]){
                viewController.rootViewController = self.rootViewController;
            }

            [_scrollView addSubview:viewController.view];
            index+=1;
        }
        [self addSubview:_scrollView];
        _isLayoutSubViews=YES;
    }
    
    //如果标题不为空则布局标题行
    if(_titleArray!=nil && _titleArray.count>0){
        
        _tabTitleWidth = SCREEN_WIDTH/_titleArray.count;
        
        //初始化标题视图数组
        _titleLabelArray = [NSMutableArray arrayWithCapacity:_titleArray.count];
        
        for(int i=0; i<_titleArray.count; i++){
            
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(_tabTitleWidth*i, 0, _tabTitleWidth, _tabTitleHeight)];
            
            title.textAlignment = NSTextAlignmentCenter;
            title.text = [_titleArray objectAtIndex:i];
            title.textColor = _tabTitleTextDefaultColor;
            [title setHighlightedTextColor:_tabTitleHighlightedColor];
            title.font = [UIFont fontWithName:@"Helvetica" size:_tabTitleFontSize];
            
            //设置手势
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
        _tabIndexerWidth = SCREEN_WIDTH/_titleArray.count/2;
        _tabIndexerStartX = SCREEN_WIDTH/_titleArray.count/4;
        
        //初始化标识线对象
        _tabIndexerView = [[UIView alloc] initWithFrame:CGRectMake(_tabIndexerStartX, _tabTitleHeight, _tabIndexerWidth, _tabIndexerHeight)];
        _tabIndexerView.backgroundColor = _tabIndexerColor;
        
        [self addSubview:_tabIndexerView];
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
    
    if(_index<self.count)
    {
        //减少重复性滚动操作
        if(_index!=_scrollIndex){
            [self scrollFlagView:_index];
            _scrollIndex = _index;
        }
        
        if(_viewPagerDelegate != nil){
            [_viewPagerDelegate viewPagerScrollDid:_index];
        }
    }
}

/**
 滑动到指定索引页
 @param index 索引下标
 */
-(void)scrollViewToPageIndex:(NSInteger)index{

    [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, _tabIndexerView.frame.size.height+_tabIndexerView.frame.size.height) animated:YES];
    
    [self scrollFlagView:index];

    _index = index;
}


/**
 滑动到指定索引页
 @param ges 索引手势
 */
-(void)scrollViewToPageIndexByTag:(UITapGestureRecognizer*)ges{
    
    int index = (int)ges.view.tag;
    [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, _tabIndexerView.frame.size.height+_tabIndexerView.frame.size.height) animated:YES];
    
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
    CGFloat _StartX = _tabIndexerStartX+_tabTitleWidth*index;
    CGRect flagViewFrame = _tabIndexerView.frame;
    
    flagViewFrame = CGRectMake(_StartX, flagViewFrame.origin.y, flagViewFrame.size.width, flagViewFrame.size.height);
    
    [UIView animateWithDuration:0.3 animations:^{
        if(self->_tabIndexerView!=nil)
        {
            self->_tabIndexerView.frame = flagViewFrame;
        }
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

- (void)setTabTitleHeight:(CGFloat)tabTitleHeight
{
    _tabTitleHeight = tabTitleHeight;
    _titleViewHeight=tabTitleHeight+2;
}

-(void)setTitleTextWithIndex:(NSUInteger)index title:(NSString*)title
{
    if(_titleLabelArray!=nil && _titleLabelArray.count>0)
    {
        UILabel *titleLabel = [_titleLabelArray objectAtIndex:index];
        [titleLabel setText:title];
    }
}

@end
