//
//  PlaceholderTextView.m
//  SaleHelper
//
//  Created by gitBurning on 14/12/8.
//  Copyright (c) 2014年 Burning_git. All rights reserved.
//

#import "ESTextView.h"
#import "ESLabel.h"

@interface ESTextView()<UITextViewDelegate>
{
    ESLabel *PlaceholderLabel;
}

@end
@implementation ESTextView
@synthesize collectSign=_collectSign;
@synthesize isRequired=_isRequired;
@synthesize name=_name;
@synthesize dataType=_dataType;
@synthesize isRequiredTooltip=_isRequiredTooltip;
@synthesize context=_context;
@synthesize viewController=_viewController;

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
        [self awakeFromNib];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentInset = UIEdgeInsetsMake(60, self.frame.size.height/3, 0, 0);
//    self.textContainerInset = UIEdgeInsetsMake(0, 100, 0, 0);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidChange:) name:UITextViewTextDidChangeNotification object:self];

    float left=16,top=0,hegiht=30;
    
    self.placeholderColor = [UIColor lightGrayColor];
    PlaceholderLabel=[[ESLabel alloc] initWithFrame:CGRectMake(left, top
                                                               , self.frame.size.width, hegiht)];
    PlaceholderLabel.font=[UIFont fontWithName:@"Helvetica" size:13];
    PlaceholderLabel.textColor=self.placeholderColor;
    PlaceholderLabel.lineBreakMode = UILineBreakModeWordWrap;
//    PlaceholderLabel.textAlignment=NSTextAlignmentJustified;
    PlaceholderLabel.numberOfLines = 0;
    [self addSubview:PlaceholderLabel];
    PlaceholderLabel.text=self.placeholder;

}

/**
 初始化事件
 **/
-(void)initializ
{
    _viewController = [self searchViewController];
}

/**
 添加事nonatomic, 件
 **/
-(void)addEvent
{
    
}

-(void)textBoxChanged:(id)sender
{
    [self dataValidator];
    NSLog(@"文本校验事件");
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
        [self setText:(NSString*)data.value];
    }
}

/**
 数据收集，返回ETDataCollection
 **/
-(DataCollection*) collect
{
    DataCollection *datas = (DataCollection*)[NSMutableArray arrayWithCapacity:1];
    Data *data = [[Data alloc] initWithDataName:self.name dataValue:self.text];
    [datas addObject:data];
    return datas;
}

/**
 设置采集标记，多个标记以‘|!’分割
 例如：ForSave|!ForQuery
 @param sign 采集标记
 **/
-(void)setCollectSign:(NSMutableString *)sign{
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
 数据校验
 ***/
-(BOOL)dataValidator
{
    //如果不能为空，则提示消息
    if(_isRequired && [[self.text trim] isEqualToString:@""]){
        [self.viewController.view makeToast:_isRequiredTooltip duration:3.0
                                   position:CSToastPositionCenter];
        return NO;
    }
    return YES;
}

-(void)setPlaceholder:(NSString *)placeholder{
    if (placeholder.length == 0 || [placeholder isEqualToString:@""]) {
        PlaceholderLabel.hidden=YES;
    }
    else
        PlaceholderLabel.text=placeholder;
    _placeholder=placeholder;

    
}

-(void)DidChange:(NSNotification*)noti{
    
    if (self.placeholder.length == 0 || [self.placeholder isEqualToString:@""]) {
        PlaceholderLabel.hidden=YES;
    }
    
    if (self.text.length > 0) {
        PlaceholderLabel.hidden=YES;
    }
    else{
        PlaceholderLabel.hidden=NO;
    }
    
    //校验数据
    [self dataValidator];
    
}

-(void) placeholderHidden{
    PlaceholderLabel.hidden=YES;
}

@end

