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


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.frame = CGRectMake(0, 0, 100, 50);
        self.layer.borderColor = [[UIColor colorWithRed:248/255.0 green:0/255.0 blue:4/255.0 alpha:1] CGColor];
        [self defaultStyle];
    }
    return self;
}

/**
 初始化屏幕采集、发布集合
 **/
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
 **/
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
 **/
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

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawTitle:context];
}

/**
 *显示要执行的sql
 ***/
-(void) drawTitle:(CGContextRef) context{
    /**写文字**/
    CGContextSetRGBFillColor (context,  95, 95, 95, 1.0);//设置填充颜色
    UIFont  *font = [UIFont boldSystemFontOfSize:15.0];//设置
    CGSize size = self.frame.size;
    if(_sql != nil){
        [_sql drawInRect:CGRectMake(size.width/3, size.height/3, size.width, size.height) withFont:font];
    }else{
        [@"ActionLoadPage" drawInRect:CGRectMake(size.width/3, size.height/3, size.width, size.height) withFont:font];
    }
}


-(void)setSql:(NSString *)Sql{
    _sql = Sql;
    [self invalidateIntrinsicContentSize];
}
@end
