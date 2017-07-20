//
//  EXUIViewController.m
//  Eruntech
//
//  Created by 杜明悦 on 13-2-25.
//
//

#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "PopAnimation.h"

@implementation BaseViewController

@synthesize baseNavigationController = _baseNavigationController;
@synthesize passValueDelegate = _passValueDelegate;
@synthesize ges = _ges;

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIView setAnimationsEnabled:YES];
    [self initWithViewController];
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    
    self.baseNavigationController.delegate = self; // 设置navigationController的代理为self,并实现其代理方法
    
    self.view.userInteractionEnabled = YES;
    _ges = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(backHandle:)];
    // 指定左边缘滑动
    _ges.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:_ges];
    }

- (void)backHandle:(UIPanGestureRecognizer *)recognizer
{
    [self customControllerPopHandle:recognizer];
}

- (void)customControllerPopHandle:(UIPanGestureRecognizer *)recognizer
{
    if(self.navigationController.childViewControllers.count == 1)
    {
        return;
    }
    // _interactiveTransition就是代理方法2返回的交互对象，我们需要更新它的进度来控制POP动画的流程。（以手指在视图中的位置与屏幕宽度的比例作为进度）
    CGFloat process = [recognizer translationInView:self.view].x/self.view.bounds.size.width;
    process = MIN(1.0, MAX(0.0, process));
    
    if(recognizer.state == UIGestureRecognizerStateBegan)
    {
        // 此时，创建一个UIPercentDrivenInteractiveTransition交互对象，来控制整个过程中动画的状态
        _interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(recognizer.state == UIGestureRecognizerStateChanged)
    {
        [_interactiveTransition updateInteractiveTransition:process]; // 更新手势完成度
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded ||recognizer.state == UIGestureRecognizerStateCancelled)
    {
        // 手势结束时，若进度大于0.5就完成pop动画，否则取消
        if(process > 0.5)
        {
            [_interactiveTransition finishInteractiveTransition];
        }
        else
        {
            [_interactiveTransition cancelInteractiveTransition];
        }
        
        _interactiveTransition = nil;
    }
}

// 代理方法1：
// 返回一个实现了UIViewControllerAnimatedTransitioning协议的对象    ，即完成转场动画的对象
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if(operation == UINavigationControllerOperationPop) // 若operation是pop，就返回我们自定义的转场动画对象
    {
        return [[PopAnimation alloc] init];
    }
    
    return nil;
}


// 代理方法2
// 返回一个实现了UIViewControllerInteractiveTransitioning协议的对象，即完成动画交互（动画进度）的对象
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if([animationController isKindOfClass:[PopAnimation class]])
    {
        return _interactiveTransition;
    }
    return nil;
}

/**
 初始化视图
 */
-(void) initWithViewController{
    
    //是否自动关闭键盘输入
    if(_isDismissKeyboard == YES){
        [self addDismissKeyboardAction];
    }
    
    ESInitializeViewController *initViewController = [[ESInitializeViewController alloc] initWithViewController:self];
    [initViewController dataInitialize];
    
//    ESReleaseViewController *releaser = [[ESReleaseViewController alloc] initWithViewController:self];
//    DataTable *dataTable = [[DataTable alloc] initWithCapacity:1];
//    [dataTable addObject:self.receiveDataParams];
//    [releaser release:dataTable];


    
//    ESValidatorViewController *validator = [[ESValidatorViewController alloc] initWithViewController:self];
//    [validator validator];
}

/**
 UIViewController间数据传值
 @param params 参数集
 */
- (void)passValue:(DataCollection *)params{
    if (params!=nil) {
        //接收子页面传递的数据集
        _subTransferDataParams = params;
        DataTable *table = [[DataTable alloc] initWithCapacity:1];
        [table addObject:params];
        ESReleaseViewController *release = [[ESReleaseViewController alloc] initWithViewController:self dataTable:table];
        [release release:table];
        
        ESDataQueryViewController *queryViewController = [[ESDataQueryViewController alloc] initWithViewController:self];
        [queryViewController execute];
        
        [self onRefresh:params];
    }else{
        [self onRefresh:nil];
    }
}

/**
 UIViewController间数据传值
 @param params 参数集
 @param closed 子页面通知是否关闭当前页面
 */
- (void)passValue:(nullable DataCollection*)params isClosed:(BOOL)closed{
    if (params!=nil) {
        //接收子页面传递的数据集
        _subTransferDataParams = params;
        DataTable *table = [[DataTable alloc] initWithCapacity:1];
        [table addObject:params];
        ESReleaseViewController *release = [[ESReleaseViewController alloc] initWithViewController:self dataTable:table];
        [release release:table];
        
        ESDataQueryViewController *queryViewController = [[ESDataQueryViewController alloc] initWithViewController:self];
        [queryViewController execute];
        
        [self onRefresh:params isClosed:closed];
    }else{
        [self onRefresh:nil isClosed:closed];
    }
}

/**
 UIViewController接收子页面传值
 @param params 参数集
 */
-(void)onRefresh:(nullable DataCollection*)params{
    //解决导航栏控制器弹出视图错误问题
    self.baseNavigationController.baseViewController = self;
}

/**
 UIViewController接收子页面传值
 @param params 参数集
 @param closed 子页面通知是否关闭当前页面
 */
- (void)onRefresh:(nullable DataCollection*)params isClosed:(BOOL)closed{
    //解决导航栏控制器弹出视图错误问题
    self.baseNavigationController.baseViewController = self;
}


/**
 跳转到目标ViewController，并且传送参数到目标ViewController
 @param viewControllerToPresent 目标ViewController
 @param dataParams 参数集合
 @param delegate 传值委托
 @param flag 是否动画方式展示
 @param completion 打开目标后回调方法
 */
-(void)presentViewController:(nonnull BaseViewController *)viewControllerToPresent params:(DataCollection*)dataParams passValueDelegate:(id<UIViewPassValueDelegate>) delegate animated:(BOOL)flag completion:(void (^ __nullable)(void))completion{
    //接收传递参数
    viewControllerToPresent.receiveDataParams = dataParams;
    //目标视图控制器回传委托
    viewControllerToPresent.passValueDelegate = delegate;
    [viewControllerToPresent passValue:dataParams];
    [self presentViewController:viewControllerToPresent animated:flag completion:completion];
}

/**
 弹出当前ViewController
 @param flag 是否动画
 @param dataParams 屏幕参数
 @param completion 回调
 */
-(void)dismissViewControllerAnimated:(BOOL)flag params:(DataCollection *)dataParams completion:(void (^)(void))completion{
    if (_passValueDelegate != nil){
        [_passValueDelegate passValue:dataParams];
    }
    [self dismissViewControllerAnimated:flag completion:completion];
}

/**
 检查屏幕输入必填项
 */
-(Boolean)validator{
    ESValidatorViewController* validator = [[ESValidatorViewController alloc] initWithViewController:self];
    return [validator validator];
}

/**
 收集屏幕数据，默认采集标签为ForSave
 */
-(DataCollection*) collect{
    ESCollectViewController* collectViewController = [[ESCollectViewController alloc] initWithViewController:self sign:@"ForSave"];
    return [collectViewController collect];
}


/**
 收集屏幕数据
 sign:采集标记
 */
-(DataCollection*) collect:(NSString*)sign{
    ESCollectViewController* collectViewController = [[ESCollectViewController alloc] initWithViewController:self sign:sign];
    return [collectViewController collect];
}

/**
 发布数据到当前ViewController
 @params table 数据集
 */
-(void)release:(DataTable*)table{
    ESReleaseViewController *ReleaseViewController = [[ESReleaseViewController alloc] initWithViewController:self dataTable:table];
    [ReleaseViewController release:nil];
}

/**
 添加关闭键盘输入事件监听
 */
-(void)addDismissKeyboardAction{
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:_tap];
}

/**
 移除关闭键盘输入事件监听
 */
-(void)removeDismissKeyboardAction{
    [self.view removeGestureRecognizer:_tap];
}

/**
 关闭键盘输入事件
 */
-(void) dismissKeyboard{
    [self resignResponder:self.view];
}

/**
 关闭键盘输入事件
 */
-(void) resignResponder:(UIView*)parentView{
    if(parentView != nil){
        for(UIView* view in parentView.subviews){
            if([view isKindOfClass:[UITextField class]] || [view isKindOfClass:[UITextView class]]){
                [view resignFirstResponder];
            }
            if(view.subviews>0){
                [self resignResponder:view];
            }
        }
    }
}

/**
 设置标题栏文本
 @param titleText 标题文本
 */
-(void)setTitleText:(NSString *)titleText{
    self.title=titleText;
}

/**
 设置触摸空白处后自动关闭键盘输入
 @param isDismissKeyboard 标题文本
 */
-(void)setIsDismissKeyboard:(BOOL)isDismissKeyboard{
    _isDismissKeyboard=isDismissKeyboard;
}


/**
 返回当前视图控制器的navigationController
 */
-(BaseNavigationController*)baseNavigationController{
    if(self.navigationController!=nil){
        return (BaseNavigationController*)self.navigationController;
    }else{
        return _baseNavigationController;
    }
}

/**
 获取导航栏高度
 @return 导航栏高度
 */
-(CGFloat)getNavigationBarHeight{
    if(self.navigationController!=nil){
        return self.navigationController.navigationBar.frame.size.height;
    }
    return 0;
}

/**
 导航视图控制器右侧按钮单击事件处理方法
 */
-(void)btnRightOnClick{

}

/**
 导航视图控制器左侧按钮单击事件处理方法
 */
-(void)btnLeftOnClick{
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if(self.baseNavigationController!=nil){
        self.baseNavigationController.baseViewController=self;
    }
    
    //如果设置右侧图形，则创建并显示为图形按钮
    if(_rightImage!=nil){
        [[self baseNavigationController] rightImageBarButtonItem:self rightImageButton:_rightImage];
    }
    
    if(_rightText!=nil){
        [[self baseNavigationController] rightBarButtonItem:self text:_rightText];
    }
    
    if (_leftText!=nil) {
        [[self baseNavigationController] leftBarButtonItem:self text:_leftText];
    }
}

/**
 获取设备类型
 */
-(DeviceName)deviceName{
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    DeviceName deviceName;
    if ([platform isEqualToString:@"iPhone3,1"]){
        deviceName = iPhone4;
//        return @"iPhone 4";
    }
    
    if ([platform isEqualToString:@"iPhone3,2"]){
        deviceName = iPhone4;
//        return @"iPhone 4";
    }
    
    if ([platform isEqualToString:@"iPhone3,3"]){
        deviceName = iPhone4;
//        return @"iPhone 4";
    }
    
    if ([platform isEqualToString:@"iPhone4,1"]){
        deviceName = iPhone4S;
//        return @"iPhone 4S";
    }
    
    if ([platform isEqualToString:@"iPhone5,1"]){
        deviceName = iPhone5;
//        return @"iPhone 5";
    }
    
    if ([platform isEqualToString:@"iPhone5,2"]){
        deviceName = iPhone5;
//        return @"iPhone 5";
    }

    
    if ([platform isEqualToString:@"iPhone5,3"]){
        deviceName = iPhone5C;
//        return @"iPhone 5c";
    }

    
    if ([platform isEqualToString:@"iPhone5,4"]){
        deviceName = iPhone5C;
//        return @"iPhone 5c";
    }

    
    if ([platform isEqualToString:@"iPhone6,1"]){
        deviceName = iPhone5S;
//        return @"iPhone 5s";
    }

    
    if ([platform isEqualToString:@"iPhone6,2"]){
        deviceName = iPhone5S;
//        return @"iPhone 5s";
    }

    
    if ([platform isEqualToString:@"iPhone7,1"]){
        deviceName = iPhone6Plus;
//        return @"iPhone 6 Plus";
    }
    
    if ([platform isEqualToString:@"iPhone7,2"]){
        deviceName = iPhone6;
//        return @"iPhone 6";
    }
    
    if ([platform isEqualToString:@"iPhone8,1"]){
        deviceName = iPhone6S;
//        return @"iPhone 6s";
    }
    
    if ([platform isEqualToString:@"iPhone8,2"]){
        deviceName = iPhone6SPlus;
//        return @"iPhone 6s Plus";
    }
    
    if ([platform isEqualToString:@"iPhone8,4"]){
        deviceName = iPhoneSE;
//        return @"iPhone SE";
    }
    
    if ([platform isEqualToString:@"iPhone9,1"]){
        deviceName = iPhone7;
//        return @"iPhone 7";
    }
    
    if ([platform isEqualToString:@"iPhone9,2"]){
        deviceName = iPhone7Plus;
//        return @"iPhone 7 Plus";
    }
    
    if ([platform isEqualToString:@"i386"]){
        deviceName = iPhoneSimulatorX86;
//        return @"iPhone Simulator";
    }
    
    if ([platform isEqualToString:@"x86_64"]){
        deviceName = iPhoneSimulatorX86;
//        return @"iPhone Simulator";
    }
    
    return deviceName;
}

/**
 添加无网络或无数据视图
 @param noDataType 无网络或无数据类型选择
 @param onClick 重新尝试按钮的点击block
 */
-(void) addNoDataView :(NoDataType) noDataType{
    
    _noDataGroupView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _noDataGroupView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2 - SCREEN_WIDTH/3/13*8,SCREEN_WIDTH/3 ,SCREEN_WIDTH/3/13*16 )];
    if(noDataType == NoNetwork){
    
        [logo setImage:[UIImage imageNamed:@"back_no_network"]];
    }else{
        [logo setImage:[UIImage imageNamed:@"back_no_data"]];
    }
    UIButton *reloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2 + SCREEN_WIDTH/3/13*8 + 20,SCREEN_WIDTH/3 ,SCREEN_WIDTH/3/4)];
   
    reloadBtn.layer.cornerRadius = 3;
    reloadBtn.layer.borderColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1].CGColor;
    reloadBtn.layer.borderWidth = 1;
    
    [reloadBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [reloadBtn setFont:[UIFont systemFontOfSize:13]];
    [reloadBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1] forState:UIControlStateNormal];
    //button标题的偏移量，这个偏移量是相对于图片的
    reloadBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [reloadBtn addTarget:self action:@selector(btnReloadDataOnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *smallReload = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6 - 10-SCREEN_WIDTH/3/4/2, SCREEN_WIDTH/3/8 - SCREEN_WIDTH/3/16, SCREEN_WIDTH/3/4/2+2, SCREEN_WIDTH/3/4/2)];
    [smallReload setImage:[UIImage imageNamed:@"btn_refresh"]];
    
    [reloadBtn addSubview:smallReload];
    [_noDataGroupView addSubview:logo];
    [_noDataGroupView addSubview:reloadBtn];
    [self.view addSubview:_noDataGroupView];
}

/**
 无数据无网络时，重新加载的按钮点击事件，需要子类中重写此方法
 */
-(void) btnReloadDataOnClick:(UIButton*) btn{
    
    //移除视图
    [_noDataGroupView removeFromSuperview];
    
}

@end
