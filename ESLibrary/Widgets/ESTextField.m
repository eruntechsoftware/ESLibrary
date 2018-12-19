//
//  UITextBox.m
//  Eruntech
//
//  Created by 杜明悦 on 12-10-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ESTextField.h"

#define LPFColor(r,g,b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]
#define LPFColorA(r,g,b,a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]
@implementation ESTextField
@synthesize context=_context;

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
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
    
//    _rootViewLayoutConstraintHeight=[NSLayoutConstraint constraintWithItem:_viewController.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0];
    
//    _rootViewLayoutConstraintHeight=[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_viewController.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    

//    [self addConstraint:_rootViewLayoutConstraintHeight];
//    for (NSLayoutConstraint *constraint in constraints) {
//        if(constraint.firstAttribute ==NSLayoutAttributeHeight )
//        {
//            NSLog(@"找到高度约束");
//        }
//    }
    
    [[self rac_signalForControlEvents:UIControlEventEditingDidBegin] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self dataValidator];
    }];
    [[self rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self dataValidator];
    }];
    [[self rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(__kindof UIControl * _Nullable x) {
        BOOL result = [self dataValidator];
        if (!result) {
            [self shakeAnimationMethod];
                        [self setNeedsDisplay];
        }
    }];
//    //增加监听，当键盘出现或改变时收出消息
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillShow:)
//                                                 name:UIKeyboardWillShowNotification
//                                               object:nil];
//    
//    //增加监听，当键退出时收出消息
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillHide:)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:nil];
    
    
}

/**
 当键盘出现或改变时把整个视图推上去
 **/
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    CGRect viewFrame = _viewController.view.frame;
    if(self.frame.origin.y>keyboardRect.origin.y){
        [UIView animateWithDuration:0.45 animations:^{
            self->_viewController.view.frame = CGRectMake(0, 0-keyboardRect.size.height+self.frame.size.height*2.2, viewFrame.size.width, viewFrame.size.height);
        }];
        
    }
}

/**
 当键退出时恢复视图的位置
 **/
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    
    CGRect viewFrame = _viewController.view.frame;
    [UIView animateWithDuration:0.35 animations:^{
        self->_viewController.view.frame = CGRectMake(0, 0, viewFrame.size.width, viewFrame.size.height);
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
-(void)collectSign:(NSString *)sign{
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
    [self shakeAnimationMethod];
    [self.viewController.view makeToast:self.placeholder duration:3.0 position:CSToastPositionBottom];
}

/**
 抖动动画
 */
- (void)shakeAnimationMethod
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    CGFloat positionX = _requiredImageView.layer.position.x;
    animation.values = @[@(positionX-2.5),@(positionX)];
    animation.repeatCount = 10;
    animation.duration = 0.02;
    animation.autoreverses = YES;
    [_requiredImageView.layer addAnimation:animation forKey:nil];
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if(_borderBottom==YES)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        if(_fouces==NO)
        {
            CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
        }
        else
        {
            CGContextSetFillColorWithColor(context, LPFColor(100, 193,234).CGColor);
        }
        CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 1, CGRectGetWidth(self.frame), 1));
    }
}

- (void)setIsRequired:(BOOL)isRequired
{
    _isRequired=isRequired;
    _requiredImageView = [[UIImageView alloc] init];
    _requiredImageView.image=[UIImage imageNamed:@"ESTextField_Required_icon"];
    [self addSubview:_requiredImageView];
    _requiredImageView.hidden=!isRequired;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _requiredImageView.frame = CGRectMake(self.bounds.size.width-36, self.bounds.size.height/2-23/2, 23, 23);
}

- (NSString *)stateHiddenId {
    return _stateHiddenId;
}

- (NSString *)wantedStateValue {
    return _wantedStateValue;
}

-(BOOL)wantedModeType{
    return _wantedModeType;
}

- (void)protectState:(BOOL)isMatched {
    if(isMatched)
    {
        [self setHidden:NO];
    }
    else
    {
        [self setHidden:YES];
    }
}

- (void)stateHiddenId:(NSString *)stateHiddenId {
    _stateHiddenId=stateHiddenId;
}

- (void)wantedStateValue:(NSString *)wantedStateValue {
    _wantedStateValue=wantedStateValue;
}

- (void)wantedModeType:(BOOL)wantedModeType
{
    _wantedModeType=wantedModeType;
}

// 获得焦点
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    _fouces=YES;
    [self setNeedsDisplay];
    return YES;
}

// 失去焦点
- (void)textFieldDidEndEditing:(UITextField *)textField{
    _fouces=NO;
    [self setNeedsDisplay];
}
@end
