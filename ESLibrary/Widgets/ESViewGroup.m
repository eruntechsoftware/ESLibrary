//
//  ESViewGroup.m
//  ahome
//
//  Created by 杜明悦 on 2018/11/22.
//  Copyright © 2018年 杜明悦. All rights reserved.
//

#import "ESViewGroup.h"

@implementation ESViewGroup

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _checkViews=[[NSMutableArray alloc] initWithCapacity:1];
    }
    return self;
}
/**
 初始化事件
 **/
-(void)initializ
{
    _viewController = [self searchViewController];
    [self search:self];
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
 **/
-(void) release:(NSString *)dataName data:(Data *)data
{
    if (data != nil && [[data.name lowercaseString] isEqualToString:[_name lowercaseString]]) {
        [self release:self tag:[data value]];
    }
}

/**
 数据收集，返回DataCollection
 **/
-(DataCollection*) collect
{
    DataCollection *datas = [[DataCollection alloc] initWithCapacity:1];
    Data *data;
    NSString* value = [self collection:self];
    data = [[Data alloc] initWithDataName:self.name dataValue:value];
    [datas addObject:data];
    return datas;
}

/**
 设置采集标记，多个标记以‘|!’分割
 例如：ForSave|!ForQuery
 @param sign 采集标记
 **/
-(void)collectSign:(NSString *)sign{
    _collectSign=sign;
}

/**
 获取收集标记集合，返回NSString[]
 **/
-(NSString *) getCollectSign
{
    return _collectSign;
}


-(NSString*) getName
{
    return _name;
}


/**
 遍历对象方法
 @param subview 视图控制器
 */
-(void) release:(id)subview tag:(NSString*)tag
{
    if([_checkViews count]>0){
        NSUInteger size = _checkViews.count;
        for (int i=0; i<size; i++) {
            ESCheckBox *checkbox = (ESCheckBox*)_checkViews[i];
            if(_multiple==NO)
            {
                if([[[checkbox.value trim] lowercaseString] isEqualToString:[[tag trim] lowercaseString]])
                {
                    [checkbox setChecked:YES];
                }
                else
                {
                    [checkbox setChecked:NO];
                }
            }
            else
            {
                [checkbox setChecked:!checkbox.checked];
            }
        }
    }
}

/**
 遍历对象方法
 @param subview 视图控制器
 */
-(NSString*) collection:(id)subview
{
    NSString* selectValue=@"";
    if([_checkViews count]>0){
        for (ESCheckBox *view in _checkViews) {
            if([view checked]==YES)
            {
                selectValue = [view value];
                break;
            }
        }
    }
    return selectValue;
}

/**
 遍历对象方法
 @param subview 视图控制器
 */
-(void) search:(id)subview
{
    if([subview isKindOfClass:[ESCheckBox class]]){
        ESCheckBox *cbox = (ESCheckBox*)subview;
        [_checkViews addObject:cbox];
        [cbox initializ];
        [cbox setViewGroup:self];
    }
    else
    {
        UIView *views = (UIView*)subview;
        if([views.subviews count]>0){
            for (UIView *view in views.subviews) {
                [self search:view];
            }
        }
    }
}

-(void)selectTag:(NSString*)tag
{
    [self release:self tag:tag];
}
@end
