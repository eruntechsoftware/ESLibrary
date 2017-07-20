//
//  UILabelEx.m
//  Eruntech
//
//  Created by 杜明悦 on 13-7-26.
//  Copyright (c) 2013年 杜明悦. All rights reserved.
//

#import "ESLabel.h"

@implementation ESLabel
@synthesize collectSign=_collectSign;
@synthesize name=_name;
@synthesize dataType=_dataType;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

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
        [self setText:(NSString*)data.value];
    }
}

/**
 数据收集，返回ETDataCollection
 */
-(DataCollection*) collect
{
    DataCollection *datas = (DataCollection*)[NSMutableArray arrayWithCapacity:1];
    Data *data = [[Data alloc] initWithDataName:[self name] dataValue:[self text]];
    [datas addObject:data];
    return datas;
}

-(NSString *) getCollectSign
{
    return _collectSign;
}

-(NSString*) getName
{
    return _name;
}

/**
 label自适应高度和自动换行，自行调用
 */
- (void) sizeToFit{
    self.lineBreakMode = NSLineBreakByCharWrapping;
    self.numberOfLines = 0;
    NSDictionary *dict = @{NSFontAttributeName: self.font};
    CGSize maxSize = CGSizeMake(self.frame.size.width, 10000);
    CGSize textSize = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading attributes:dict context:nil].size;
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, textSize.height);
    
}

@end
