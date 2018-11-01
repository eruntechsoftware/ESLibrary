//
//  EXUIViewController.h
//  Eruntech
//
//  Created by 杜明悦 on 13-2-25.
//
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ESInitializeViewController.h"
#import "ESValidatorViewController.h"
#import "DataTable.h"
#import "DataCollection.h"
#import "Data.h"
#import "ESReleaseViewController.h"
#import "ESDataQueryViewController.h"
#import "UIViewPassValueDelegate.h"
#import "ESCollectViewController.h"
#import "UIView+Toast.h"
#import <sys/utsname.h>

// 获得屏幕尺寸
#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height
#define DEVICE_NAME [self deviceName]

typedef enum
{
    iPhone4
    ,iPhone4S
    ,iPhone5
    ,iPhone5C
    ,iPhone5S
    ,iPhoneSE
    ,iPhone6
    ,iPhone6Plus
    ,iPhone6S
    ,iPhone6SPlus
    ,iPhone7
    ,iPhone7Plus
    ,iPhoneSimulatorARM
    ,iPhoneSimulatorX86
}DeviceName;

typedef enum
{
    NoNetwork = 0,  //无网络
    NoDataSouth = 1  //无数据源
    }NoDataType;

IB_DESIGNABLE
@class BaseNavigationController; 

@interface BaseViewController:UIViewController<UIViewPassValueDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate>
{
    id<UIViewPassValueDelegate> _passValueDelegate;
}

@property(strong,nonatomic)UIScreenEdgePanGestureRecognizer *ges;
@property(strong,nonatomic) UIPercentDrivenInteractiveTransition *interactiveTransition;
/**
 设置或获取视图控制器接收的参数集
 */
@property (nullable,strong,nonatomic) DataCollection* receiveDataParams;

/**
 设置或获取视图控制器传递的参数集
 */
@property (nullable,strong,nonatomic) DataCollection* transferDataParams;

/**
 设置或获取子视图控制器传递的参数集
 */
@property (nullable,strong,nonatomic) DataCollection* subTransferDataParams;

/**
 设置或获取系统默认导航栏
 */
@property (nullable,strong,nonatomic) BaseNavigationController* baseNavigationController;

/**
 设置或获取视图控制器传值委托对象
 */
@property (nullable,strong,nonatomic) id<UIViewPassValueDelegate> passValueDelegate;

/**
 设置或获取视图控制器触摸事件处理对象
 */
@property (nullable,strong,nonatomic) UITapGestureRecognizer* tap;

/**
 设置或获取视图控制器标题
 */
@property (nullable,strong,nonatomic) IBInspectable NSString* titleText;

/**
 设置或获取导航栏视图控制器右侧按钮图形
 */
@property (nullable,strong,nonatomic) IBInspectable UIImage* rightImage;

/**
 设置或获取导航栏视图控制器右侧按钮文本，多个按钮用|!分割
 */
@property (nullable,strong,nonatomic) IBInspectable NSString* rightText;

/**
 设置或获取导航栏视图控制器左侧按钮文本，多个按钮用|!分割
 */
@property (nullable,strong,nonatomic) IBInspectable NSString* leftText;

/**
 设置或获取右侧单击事件处理方法
 */
@property (nullable,assign,nonatomic) SEL rightBarButtonOnClick;

/**
 设置或获取左侧单击事件处理方法
 */
@property (nullable,assign,nonatomic) SEL leftBarButtonOnClick;

/**
 设置或获取视图控制器是否自动关闭键盘输入
 */
@property (assign,nonatomic)IBInspectable BOOL isDismissKeyboard;

/**
 设置或获取是否隐藏左侧返回按钮，默认不隐藏
 */
@property (assign,nonatomic)IBInspectable BOOL isLeftBtnBackHidden;

/**
 设置或获取视图控制器指向的根视图控制器
 */
@property (strong, nonatomic) BaseViewController *rootViewController;

@property (strong,nonatomic) UIView *noDataGroupView;

/**
 初始化视图
 */
-(void) initWithViewController;

/**
 跳转到目标ViewController，并且传送参数到目标ViewController
 @param viewControllerToPresent 目标ViewController
 @param dataParams 参数集合
 @param delegate 传值委托
 @param flag 是否动画方式展示
 @param completion 打开目标后回调方法
 */
-(void)presentViewController:(nonnull BaseViewController *)viewControllerToPresent params:(DataCollection*_Nullable)dataParams passValueDelegate:(nonnull id<UIViewPassValueDelegate>) delegate animated:(BOOL)flag completion:(void (^ __nullable)(void))completion;

/**
 弹出当前ViewController
 @param flag 是否动画
 @param dataParams 屏幕参数
 @param completion 回调
*/
-(void)dismissViewControllerAnimated:(BOOL)flag params:(nullable DataCollection*)dataParams completion:(void (^ __nullable)(void))completion;


/**
 检查屏幕输入必填项
 */
-(Boolean) validator;

/**
 收集屏幕数据，默认采集标签为ForSave
 */
-(nonnull DataCollection*) collect;

/**
 收集屏幕数据，指定采集标签
 */
-(DataCollection* _Nullable) collect:(nullable NSString*)sign;

/**
 发布数据到当前ViewController
 @params table 数据集
 */
-(void)release:(DataTable*)table;

/**
 * 数据发布前处理方法
 */
-(void)releaseing;

/**
 * 数据发布后处理方法
 */
-(void)released;

/**
 发布数据到当前ViewController
 @params flag 标记
 @params params 数据集
 */
-(void)release:(int)flag params:(DataCollection*)params;

/**
 添加关闭键盘输入事件监听
 */
-(void)addDismissKeyboardAction;

/**
 移除关闭键盘输入事件监听
 */
-(void)removeDismissKeyboardAction;

/**
 关闭键盘输入事件
 */
-(void) dismissKeyboard;

/**
 关闭键盘输入事件
 */
-(void) resignResponder:(nonnull UIView*)view;

/**
 获取导航栏高度
 @return 导航栏高度
 */
-(CGFloat)getNavigationBarHeight;

/**
 获取设备类型
 */
-(DeviceName)deviceName;

/**
 导航视图控制器右侧按钮单击事件处理方法
 */
-(void)btnRightOnClick;

/**
 导航视图控制器左侧按钮单击事件处理方法
 */
-(void)btnLeftOnClick;

/**
 UIViewController接收子页面传值
 @param params 参数集
 */
-(void)onRefresh:(nullable DataCollection*)params;

/**
 UIViewController接收子页面传值
 @param params 参数集
 @param closed 子页面通知是否关闭当前页面
 */
- (void)onRefresh:(nullable DataCollection*)params isClosed:(BOOL)closed;

@end
