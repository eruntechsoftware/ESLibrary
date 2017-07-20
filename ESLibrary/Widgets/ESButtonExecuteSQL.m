//
//  UIButtonSQL.m
//  Eruntech
//
//  Created by 杜明悦 on 13-2-25.
//
//

#import "ESButtonExecuteSQL.h"

@implementation ESButtonExecuteSQL

@synthesize funcSign=_funcSign;
@synthesize  message=_message;
@synthesize sign=_sign;
@synthesize sql=_sql;
@synthesize title=_title;
@synthesize confirmMessage=_confirmMessage;
@synthesize stateHiddenId=_stateHiddenId;
@synthesize wantedStateValue=_wantedStateValue;
@synthesize SQLiteDatabase=_SQLiteDatabase;
@synthesize viewController=_viewController;


/**
 初始化方法
 */
-(void)initializ
{
    _title=@"消息";
    [self addEvent];
}

/**
 添加事件
 */
-(void) addEvent
{
    [self addTarget:self action:@selector(btnSaveClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btnSaveClick:(id)sender
{
    [self execute];
}

/**
  执行Sql文件
 */
-(void) execute
{
    @try {
        //返回当前根视图控制器
        _viewController = [self searchViewController];
        //判断是否有确认消息
        if (_confirmMessage!=nil) {
//            RIButtonItem *cancelItem = [RIButtonItem item];
//            cancelItem.label = @"取消";
//            cancelItem.action = ^
//            {
//                //为NO时的处理
//            };
//            
//            RIButtonItem *otherItem = [RIButtonItem item];
//            otherItem.label = @"确定";
//            otherItem.action = ^
//            {
//                //为YES时的处理
//                [self executeSql];
//            };
//            
//            //调用
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:_title
//                                                                message:_confirmMessage
//                                                       cancelButtonItem:cancelItem
//                                                       otherButtonItems:otherItem, nil];
//            [alertView show];
//            alertView = nil;
        }
        else
        {
            [self executeSql];
        }
    }
    @catch (NSException *exception) {
        @throw exception;
    }
    @finally {
        
    }
}

/**
 收集数据，格式化SQL命令并执行
 */
-(void) executeSql
{
    @try {
        ESCollectViewController *collecter = [[ESCollectViewController alloc] initWithViewController:_viewController sign:_sign];
        ESReleaseViewController *releaser = [[ESReleaseViewController alloc] initWithViewController:_viewController];
        _SQLiteDatabase = [[SQLiteDatabase alloc] init];
        [_SQLiteDatabase setSql:_sql];
        [_SQLiteDatabase.collectors addObject:collecter];
        [_SQLiteDatabase.releasers addObject:releaser];
        //执行完成之后，弹出提示消息
        if ([_SQLiteDatabase execute]) {
            if (_message!=nil) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"消息" message:_message delegate:_viewController cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alertView show];
                alertView = nil;
            }
        };
    }
    @catch (NSException *exception) {
        @throw exception;
    }
    @finally {
        
    }
}
@end
