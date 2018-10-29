//
//  UITextBox.m
//  Eruntech
//
//  Created by 杜明悦 on 12-10-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ESTextField.h"


@implementation ESTextField
@synthesize context=_context;

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        _isRequiredimage = [UIImage imageNamed:@"ESTextField_Required_icon"];
//        _btnErrorMessage = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-20, self.frame.size.height/4+3, 18, 18)];
//        _btnErrorMessage.backgroundColor = [UIColor orangeColor];
//        [_btnErrorMessage setTitle:@"!" forState:UIControlStateNormal];
//        CGFloat radius = _btnErrorMessage.bounds.size.width/2;
//        _btnErrorMessage.layer.cornerRadius=radius;
//        _btnErrorMessage.layer.borderWidth=0.5;
//        _btnErrorMessage.layer.borderColor = [UIColor yellowColor].CGColor;
//        _btnErrorMessage.hidden=YES;
        
//        [self addSubview:_btnErrorMessage];
    }
    return self;
}

/**
 初始化事件
 */
-(void)initializ
{
    _viewController = [self searchViewController];
    
    _validator=[[Validator alloc] initWithExpression:_regularExpression];
    
    [[self rac_signalForControlEvents:UIControlEventEditingDidBegin] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self dataValidator];
    }];
    [[self rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self dataValidator];
    }];
    [[self rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(__kindof UIControl * _Nullable x) {
        BOOL result = [self dataValidator];
        if (!result) {
//            [self shakeAnimationMethod];
            [self setNeedsDisplay];
        }
    }];
}

/**
 添加事件
 */
-(void)addEvent
{
//    [self addTarget:self action:@selector(textBoxChanged:) forControlEvents:UIControlEventEditingDidBegin];
}

-(void)textBoxChanged:(id)sender
{
    [self dataValidator];
    NSLog(@"文本校验事件");
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
 */
-(void) release:(NSString *)dataName data:(Data *)data
{
    if (data != nil && [[data.name lowercaseString] isEqualToString:[_name lowercaseString]]) {
        [self setText:(NSString*)data.value];
    }
}

/**
 数据收集，返回DataCollection
 */
-(DataCollection*) collect
{
    DataCollection *datas = [[DataCollection alloc] initWithCapacity:1];
    Data *data = [[Data alloc] initWithDataName:self.name dataValue:self.text];
    [datas addObject:data];
    return datas;
}

/**
 设置采集标记，多个标记以‘|!’分割
 例如：ForSave|!ForQuery
 @param sign 采集标记
 */
-(void)setCollectSign:(NSMutableString *)sign{
    _collectSign=sign;
}

/**
 获取收集标记集合，返回NSString[]
 */
-(NSString *) getCollectSign
{
    return _collectSign;
}


-(NSString*) getName
{
    return _name;
}

-(BOOL)dataValidator
{
    //如果不能为空，则提示消息
    if(_isRequired && [[self.text trim] isEqualToString:@""]){
        return NO;
    }
    if(_regularExpression!=nil && ![_regularExpression isEmpty]){
        //正则表达式验证
        BOOL result = [_validator validataWithValue:self.text];
//        _btnErrorMessage.hidden = result;
        return result;
    }
    return YES;
}

/**
 * 提示校验错误
 * **/
-(void) hint
{
    [self.viewController.view makeToast:self.placeholder duration:3.0
                               position:CSToastPositionCenter];
}

///**
// 抖动动画
// */
//- (void)shakeAnimationMethod
//{
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
//    CGFloat positionX = _btnErrorMessage.layer.position.x;
//    animation.values = @[@(positionX-3),@(positionX)];
//    animation.repeatCount = 10;
//    animation.duration = 0.05;
//    animation.autoreverses = YES;
//    [_btnErrorMessage.layer addAnimation:animation forKey:nil];
//}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if(_isRequired)
    {
        [_isRequiredimage drawInRect:CGRectMake(self.bounds.origin.x-46-23, self.bounds.size.height/2-46/2, 46, 46)];
    }
}


//-(void)drawPlaceholderInRect:(CGRect)rect{
//    [_placeholderColor setFill];
//    CGRect plrect = CGRectMake(rect.origin.x, rect.origin.y+rect.size.height/4, rect.size.width, rect.size.height);
//    [[self placeholder] drawInRect:plrect withFont:[UIFont systemFontOfSize:13]];
//}
@end
