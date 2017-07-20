//
//  UIActionLoadPage.m
//  Eruntech
//
//  Created by 杜明悦 on 13-7-26.
//  Copyright (c) 2013年 杜明悦. All rights reserved.
//

#import "ESActionLoadPage.h"

@implementation ESActionLoadPage
@synthesize SQLiteDatabase=_SQLiteDatabase;
@synthesize sql=_sql;
@synthesize sign=_sign;
@synthesize dataType = _dataType;
@synthesize isAuto = _isAuto;

-(id)init{
    self = [super init];
    if (self) {
        [self setClipsToBounds:YES];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.layer.borderColor = [UIColor lightTextColor].CGColor;
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self setTitle:@"ActionLoadPage" forState:UIControlStateNormal];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.hidden = YES;
        [self setClipsToBounds:YES];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.layer.borderColor = [UIColor lightTextColor].CGColor;
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self setTitle:@"ActionLoadPage" forState:UIControlStateNormal];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        [self setClipsToBounds:YES];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.layer.borderColor = [UIColor lightTextColor].CGColor;
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self setTitle:@"ActionLoadPage" forState:UIControlStateNormal];
    }
    return self;
}

/**
 初始化屏幕采集、发布集合
 */
-(void) initialize{
    controller = (BaseViewController*)[self searchViewController];
    if ([_sign isEqualToString:@""]) {
        _sign=@"ForQuery";
    }
    _SQLiteDatabase = [[SQLiteDatabase alloc] initDatabase];
    _SQLiteDatabase.sql = _sql;
    collecter=[[ESCollectViewController alloc] initWithViewController:controller sign:_sign];
    [_SQLiteDatabase.collectors addObject:collecter] ;
    releaser=[[ESReleaseViewController alloc] initWithViewController:controller];
    [_SQLiteDatabase.releasers addObject:releaser] ;
}


/**
 执行数据查询并发布数据到UIView
 */
-(void) execute{
    @try {
        if(_isAuto){
            [self initialize];
            [_SQLiteDatabase executeTable];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"ActionLoadPage数据发布：%@",@"发布失败！");
    }
    @finally {
        
    }
}

/**
 执行数据查询并发布数据到UIView
 */
-(void) execute:(DataTable*)dataTable{
    @try {
        // 主线程执行：
        dispatch_async(dispatch_get_main_queue(), ^{
            if(_isAuto){
                [self initialize];
                [_SQLiteDatabase executeTable:dataTable];
            }
        });
        
    }
    @catch (NSException *exception) {
        NSLog(@"ActionLoadPage数据发布：%@",@"发布失败！");
    }
    @finally {
        
    }

}



/**
 设置sql显示标题

 @param Sql Sql
 */
-(void)setSql:(NSString *)Sql{
    _sql = Sql;
}

@end
