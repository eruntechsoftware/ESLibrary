//
//  BaseNavigationController.m
//  Neighbour
//
//  Created by 杜明悦 on 16/10/12.
//  Copyright © 2016年 杜明悦. All rights reserved.
//

#import "BaseNavigationController.h"
#import "BaseViewController.h"

@implementation BaseNavigationController

/**
 设置或获取navigationBar默认颜色
 */
static UIColor *NavigationBar_barTintColor;

/**
 设置或获取navigationBar标题颜色
 */
static UIColor *NavigationBar_titleColor;

@synthesize baseViewController=_baseViewController;


- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 设置NavigationBar颜色
 @param barTintColor 标题颜色
 */
+(void)setNavigationBar_barTintColor:(nonnull UIColor*)barTintColor{
    NavigationBar_barTintColor = barTintColor;
}

/**
 获取NavigationBar颜色
 */
+(UIColor*)getNavigationBar_barTintColor{
    return NavigationBar_barTintColor;
}

/**
 设置NavigationBar颜色
 @param titleColor 标题颜色
 */
+(void)setNavigationBar_titleColor:(nonnull UIColor*)titleColor{
    NavigationBar_titleColor = titleColor;
}

/**
 获取titleColor颜色
 */
+(UIColor*)getNavigationBar_titleColor{
    return NavigationBar_titleColor;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    NSDictionary<NSString *,id>* navigationTitleAttribute=@{NSForegroundColorAttributeName:NavigationBar_titleColor==nil?[UIColor whiteColor]:NavigationBar_titleColor};
    
    self.navigationBar.titleTextAttributes = navigationTitleAttribute;
    self.navigationBar.translucent=NO;
    
    
    self.navigationBar.barStyle=UIStatusBarStyleLightContent;
    self.navigationBar.barTintColor = NavigationBar_barTintColor;
    
    //隐藏下边线
    [self.navigationBar bottomLineViewHidden];
    
    //[Util imageWithColor:[Color color_divider_line] size:CGSizeMake(self.view.frame.size.width, 0.5)]
    //[self.navigationBar setShadowImage:[UIImage imageNamed:@"line"]];
    
    return self;
}

/**
 初始化视图控制器
 @param baseViewController 视图控制器
 @return BaseNavigationController
 */
- (id)initWithViewController:(BaseViewController *)baseViewController{
    
    self.baseViewController = baseViewController;
    self.baseViewController.isLeftBtnBackHidden = YES;
    
    self = [super initWithRootViewController:baseViewController];
    return self;
}

/**
 初始化视图控制器
 @param baseViewController 视图控制器
 @param hidden 是否隐藏返回按钮
 @return BaseNavigationController
 */
- (nonnull id)initWithViewController:(nonnull BaseViewController*)baseViewController isLeftBtnBackHidden:(BOOL)hidden{
    
    self.baseViewController = baseViewController;
    
    if([self.baseViewController isKindOfClass:[BaseViewController class]]){
        self.baseViewController.isLeftBtnBackHidden = hidden;
    }
    self = [super initWithRootViewController:baseViewController];
    return self;
}

/**
 推入视图控制器
 @param viewController 目标视图控制器
 @param dataParams DataCollection类型数据集
 @param delegate 传值委托实现对象
 @param animated 是否动画方式展示
 */
- (void) pushViewController:(BaseViewController *)viewController params:(DataCollection *)dataParams passValueDelegate:(id<UIViewPassValueDelegate>) delegate animated:(BOOL)animated{
    
    self.baseViewController = viewController;
    
    if([viewController isKindOfClass:[BaseViewController class]]){
        self.baseViewController.isLeftBtnBackHidden = NO;

        self.baseViewController.hidesBottomBarWhenPushed=self.baseViewController.hiddenBottomBar;
        
        //目标视图控制器接收的参数
        viewController.receiveDataParams = dataParams;
       
        //目标视图控制器回传委托
        viewController.passValueDelegate = delegate;
        [viewController passValue:dataParams];
        
        //不隐藏导航栏按钮
        //self.leftButtonHidden = false;
    }
    //跳转新屏幕
    [self pushViewController:viewController animated:animated];
}

/**
 推入视图控制器
 @param viewController 目标视图控制器
 @param animated 是否动画方式展示
 */
- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0)
    {
        // 隐藏底部
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    viewController.navigationItem.leftBarButtonItem = [self backButton:self.baseViewController.isLeftBtnBackHidden];
}

/**
 推入视图控制器
 @param viewController 目标视图控制器
 @param backHidden 是否隐藏返回按钮
 @param animated 是否动画方式展示
 */
- (void) pushViewController:(UIViewController *)viewController leftBackHidden:(BOOL)backHidden animated:(BOOL)animated;{
    
    if (self.childViewControllers.count > 0)
    {
        // 隐藏底部
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [self pushViewController:viewController animated:animated];
    viewController.navigationItem.leftBarButtonItem = [self backButton:backHidden];
}


/**
 创建返回按钮
 */
- (UIBarButtonItem*) backButton :(BOOL) hidden{
    
    UIBarButtonItem* barButton;
    UIButton* backButton;
    
    //不隐藏导航栏按钮
    if (hidden == NO)
    {
        UIImageView* backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8, 18, 18)];
        UIImage *image = [UIImage imageNamed:@"arrow_left_icon"];
        backImage.image = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
        backImage.tintColor=NavigationBar_titleColor;
        backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        [backButton addSubview:backImage];
        
        //添加默认处理事件
        SEL popViewController = @selector(onLeftClick);
        
        [backButton addTarget:self action:popViewController  forControlEvents:UIControlEventTouchUpInside];
        barButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    else
    {
        backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        barButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    return barButton;
}


/**
 创建左侧按钮,并添加到导航视图控制器
 @param text 按钮文本
 */
- (UIBarButtonItem*)  leftBarButtonItem:(UIViewController*)viewController text:(NSString*)text{
    
    UIBarButtonItem* barButton;
    if(viewController.navigationItem!=nil){
        barButton = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStyleDone target:self action:@selector(onLeftClick)];
        viewController.navigationItem.leftBarButtonItem = barButton;
        [viewController.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName, nil] forState:UIControlStateNormal];
        [viewController.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    }
    return barButton;
}

/**
 创建左侧图形按钮,并添加到导航视图控制器
 @param img 图片
 */
- (UIBarButtonItem*) leftImageBarButtonItem:(UIViewController*)viewController leftImageButton:(UIImage*)img{
    
    UIBarButtonItem* barButton;
    if(viewController.navigationItem!=nil){
            //实例化按钮
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, self.navigationBar.frame.size.height)];
            //实例化图片视图
        UIImageView* backImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.navigationBar.frame.size.height/2 - 10, 20, 20)];
        backImage.image = img;
        
        [backButton addSubview:backImage];
            //添加事件
        [backButton addTarget:self action:@selector(onLeftClick)  forControlEvents:UIControlEventTouchUpInside];
        barButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        viewController.navigationItem.leftBarButtonItem = barButton;
    }
    return barButton;
}

/**
 创建右侧按钮,并添加到导航视图控制器
 @param text 按钮文本
 */
- (UIBarButtonItem*) rightBarButtonItem:(UIViewController*)viewController text:(NSString*)text{
    UIBarButtonItem* barButton;
    if(viewController.navigationItem!=nil){
        barButton = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStyleDone target:self action:@selector(onRightClick)];
        viewController.navigationItem.rightBarButtonItem = barButton;
        [viewController.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
        [viewController.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    }
    return barButton;
}

/**
 创建右侧图形按钮,并添加到导航视图控制器
 @param img 图片
 */
- (UIBarButtonItem*) rightImageBarButtonItem:(UIViewController*)viewController rightImageButton:(UIImage*)img{
    
    UIBarButtonItem* barButton;
    if(viewController.navigationItem!=nil){
        //实例化按钮
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, self.navigationBar.frame.size.height)];
        //实例化图片视图
        UIImageView* backImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.navigationBar.frame.size.height/2 - 10, 20, 20)];
        backImage.image = img;
        
        [backButton addSubview:backImage];
        //添加事件
        [backButton addTarget:self action:@selector(onRightClick)  forControlEvents:UIControlEventTouchUpInside];
        barButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        viewController.navigationItem.rightBarButtonItem = barButton;
    }
    return barButton;
}


/**
 导航视图控制器右侧按钮单击事件处理方法
 */
-(void)onRightClick{
    if(_baseViewController!=nil){
        [_baseViewController onRightClick];
    }
}

/**
 导航视图控制器左侧按钮单击事件处理方法
 */
-(void)onLeftClick{
    if(_baseViewController!=nil){
        [_baseViewController onLeftClick];
    }
}


/**
 弹出viewController
 @param params 类型数据集
 @param animated 是否动画方式展示
 */
- (void) popViewControllerAnimated:(DataCollection*)params animated:(BOOL)animated{
    [_baseViewController.passValueDelegate passValue: params];
    [super popViewControllerAnimated:YES];
}

/**
 向父页面发布数据
 @param state 状态值，用于区分发布来源
 @param params 类型数据集
 */
- (void) release:(int)state params:(nullable DataCollection*)params
{
    [_baseViewController.passValueDelegate passValue:state params:params];
}

/**
 弹出viewController，并将当前页面接收到的子页面数据集继续向父页面传递
 */
-(void)popViewControllerAnimated{
    [self popViewControllerAnimated:_baseViewController.subTransferDataParams animated:YES];
}

/**
 为当前的topbar添加搜索框
 @param placeholderStr 提示文字
 */
-(void)addSeacherView:(NSString*) placeholderStr;{

    _seacherFild = [[UITextField alloc] initWithFrame:CGRectMake(55, 25, SCREEN_WIDTH - 105, 32)];
    _seacherFild.placeholder = placeholderStr;
    [_seacherFild setFont:[UIFont systemFontOfSize:14]];
    [_seacherFild setBackgroundColor:[UIColor whiteColor]];
    _seacherFild.layer.cornerRadius = 3;
    [_seacherFild setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_seacherFild];
}


/**
 设置透明的topbar
 @param viewController 当前视图控制器
 @param textColor 标题文本颜色
 */
-(void)setTransparentStyleBarWithViewController:(BaseViewController*)viewController titleTextColor:(UIColor*)textColor{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
     self.navigationBar.barStyle=UIStatusBarStyleDefault;
    
    [self.navigationBar setBackgroundColor:[UIColor clearColor]];
    [self.navigationBar setTranslucent:YES];
    
    NSDictionary<NSString *,id>* navigationTitleAttribute=@{NSForegroundColorAttributeName:textColor};
    self.navigationBar.titleTextAttributes = navigationTitleAttribute;

    //实例化按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, self.navigationBar.frame.size.height)];
    
    //实例化图片视图
    UIImageView* backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8, 25, 25)];
    backImage.image = [UIImage imageNamed:@"back_blank"];
    
    [backButton addSubview:backImage];
    //添加事件
    [backButton addTarget:self action:@selector(popViewControllerAnimated)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *barButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    viewController.navigationItem.leftBarButtonItem = barButton;
}

/**
 设置透明的topbar并设置左侧返回按钮
 @param viewController 当前视图控制器
 @param textColor 标题文本颜色
 @param backImg 左侧返回按钮
 */
-(void)setTransparentStyleBarWithViewController:(BaseViewController*)viewController titleTextColor:(UIColor*)textColor backImage:(UIImage*)backImg{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationBar.barStyle=UIStatusBarStyleDefault;
    
    [self.navigationBar setBackgroundColor:[UIColor clearColor]];
    [self.navigationBar setTranslucent:YES];
    
    NSDictionary<NSString *,id>* navigationTitleAttribute=@{NSForegroundColorAttributeName:textColor};
    self.navigationBar.titleTextAttributes = navigationTitleAttribute;
    
    //实例化按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, self.navigationBar.frame.size.height)];
    
    //实例化图片视图
    UIImageView* backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8, 25, 25)];
    backImage.image = backImg;
    
    [backButton addSubview:backImage];
    //添加事件
    [backButton addTarget:self action:@selector(popViewControllerAnimated)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *barButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    viewController.navigationItem.leftBarButtonItem = barButton;
}

/**
 恢复topbar的普通状态
 */
-(void)resumeNormalStyleBarWithViewController:(BaseViewController *)viewController{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationBar.barStyle=UIStatusBarStyleLightContent;

    
    [self.navigationBar setBackgroundColor:NavigationBar_barTintColor];
    [self.navigationBar setTranslucent:NO];
    
    NSDictionary<NSString *,id>* navigationTitleAttribute=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationBar.titleTextAttributes = navigationTitleAttribute;
    
    //实例化按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, self.navigationBar.frame.size.height)];
    
    //实例化图片视图
    UIImageView* backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8, 25, 25)];
    backImage.image = [UIImage imageNamed:@"back"];
    
    [backButton addSubview:backImage];
    //添加事件
     [backButton addTarget:self action:@selector(popViewControllerAnimated)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *barButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    viewController.navigationItem.leftBarButtonItem = barButton;
}
@end
