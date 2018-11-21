//
//  UIButtonSQL.h
//  Eruntech
//
//  Created by 杜明悦 on 13-2-25.
//
//

#import <UIKit/UIKit.h>
#import "ESView.h"
#import "ESCollectViewController.h"
#import "ESReleaseViewController.h"
#import "SQLExpression.h"
#import "ESFile.h"
#import "ESView.h"
#import "SQLiteDatabase.h"
#import "UIButton+Bootstrap.h"
#import "ESButton.h"
IB_DESIGNABLE
@interface ESButtonExecuteSQL : ESButton<Initializble>
{
    @private
        SQLiteDatabase *_SQLiteDatabase;
        UIViewController *_viewController;
}

//权限标记
@property(copy,nonatomic)IBInspectable NSString *funcSign;
//完成后弹出的消息
@property(copy,nonatomic)IBInspectable NSString *message;
//采集数据标记
@property(copy,nonatomic)IBInspectable NSString *sign;
//执行的Sql文件
@property(copy,nonatomic)IBInspectable NSString *sql;
//消息标题
@property(copy,nonatomic)IBInspectable NSString *title;
//确认消息
@property(copy,nonatomic)IBInspectable NSString *confirmMessage;
//数据库访问对象
@property(retain,nonatomic) SQLiteDatabase *SQLiteDatabase;
//获取当前UIView所属视图控制器
@property (retain,nonatomic) UIViewController *viewController;


/**
 初始化方法
 */
-(void)initializ;

/**
 添加事件
 */
-(void) addEvent;

//执行数据库访问
-(void) execute;
@end
