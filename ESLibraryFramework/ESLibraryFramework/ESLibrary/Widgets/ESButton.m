//
//  ESButton.m
//  Neighbour
//
//  Created by 杜明悦 on 2016/10/15.
//  Copyright © 2016年 杜明悦. All rights reserved.
//

#import "ESButton.h"

@implementation ESButton

- (void) initializ
{
}

/**
 获取采集标记名
 */
-(NSArray*) getRequest
{
    NSArray* array = [[NSArray alloc] initWithObjects:_name, nil];
    return array;
}

/**
 将数据发布到指定位置
 @param dataName 数据名称
 @param data 数据对象
 */
-(void) release:(NSString *)dataName data:(Data *)data
{
    if (data != nil && [[data.name lowercaseString] isEqualToString:[_name lowercaseString]]) {
        [self.titleLabel setText:(NSString*)data.value];
    }
}

/**
 数据收集，返回ETDataCollection
 */
-(DataCollection*) collect
{
    DataCollection *datas = (DataCollection*)[NSMutableArray arrayWithCapacity:1];
    Data *data = [[Data alloc] initWithDataName:[self name] dataValue:[self.titleLabel text]];
    [datas addObject:data];
    return datas;
}

-(NSString *) getCollectSign
{
    return _collectSign;
}

- (void)collectSign:(NSString *)sign {
    _collectSign=sign;
}


-(NSString*) getName
{
    return _name;
}

@end
