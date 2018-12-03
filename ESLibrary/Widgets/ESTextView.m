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

/**
 占位符Label
 */
@property (strong,nonatomic) UILabel *placeHolderLabel;

@end
@implementation ESTextView
@synthesize collectSign=_collectSign;
@synthesize isRequired=_isRequired;
@synthesize name=_name;
@synthesize dataType=_dataType;
//@synthesize isRequiredTooltip=_isRequiredTooltip;
@synthesize context=_context;
@synthesize viewController=_viewController;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isRequiredimage = [UIImage imageNamed:@"ESTextField_Required_icon"];
        [self addPlaceHolderLabel];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addPlaceHolderLabel];
    }
    return self;
}


- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
        [self addPlaceHolderLabel];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidChange:) name:UITextViewTextDidChangeNotification object:self];
}

/**
 初始化事件
 */
-(void)initializ
{
    _viewController = [self searchViewController];
}

/**
 添加事nonatomic, 件
 */
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
 数据收集，返回ETDataCollection
 */
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
 */
-(void)setCollectSign:(NSString *)sign{
    _collectSign=sign;
}

/**
 获取收集标记集合，返回NSString[]
 */
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

/**
 数据校验
 */
-(BOOL)dataValidator
{
    //如果不能为空，则提示消息
    if(_isRequired && [[self.text trim] isEqualToString:@""]){
        return NO;
    }
    return YES;
}

-(void)hint
{
    [self.viewController.view makeToast:self.placeholder duration:3.0
                               position:CSToastPositionBottom];
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if(_isRequired)
    {
        [_isRequiredimage drawInRect:CGRectMake(self.bounds.origin.x-46-23, self.bounds.size.height/2-46/2, 46, 46)];
    }
}

/**
 添加占位符PlaceHolderLabel
 */
- (void)addPlaceHolderLabel
{
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor grayColor];
    [placeHolderLabel sizeToFit];
    placeHolderLabel.font = [UIFont systemFontOfSize:12.f];
    _placeHolderLabel = placeHolderLabel;
    [self addSubview:_placeHolderLabel];
    [self setValue:_placeHolderLabel forKey:@"_placeholderLabel"];
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeHolderLabel.text = placeholder;
}

-(void)DidChange:(NSNotification*)noti{
    //校验数据
    [self dataValidator];
}

- (NSString *)stateHiddenId {
    return _stateHiddenId;
}

- (NSString *)wantedStateValue {
    return _wantedStateValue;
}

-(BOOL*)wantedModeType{
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

- (void)wantedModeType:(BOOL*)wantedModeType
{
    _wantedModeType=wantedModeType;
}

- (void)deleteBackward {
    <#code#>
}

- (void)insertText:(nonnull NSString *)text {
    <#code#>
}

- (UITextWritingDirection)baseWritingDirectionForPosition:(nonnull UITextPosition *)position inDirection:(UITextStorageDirection)direction {
    <#code#>
}

- (CGRect)caretRectForPosition:(nonnull UITextPosition *)position {
    <#code#>
}

- (nullable UITextRange *)characterRangeAtPoint:(CGPoint)point {
    <#code#>
}

- (nullable UITextRange *)characterRangeByExtendingPosition:(nonnull UITextPosition *)position inDirection:(UITextLayoutDirection)direction {
    <#code#>
}

- (nullable UITextPosition *)closestPositionToPoint:(CGPoint)point {
    <#code#>
}

- (nullable UITextPosition *)closestPositionToPoint:(CGPoint)point withinRange:(nonnull UITextRange *)range {
    <#code#>
}

- (NSComparisonResult)comparePosition:(nonnull UITextPosition *)position toPosition:(nonnull UITextPosition *)other {
    <#code#>
}

- (CGRect)firstRectForRange:(nonnull UITextRange *)range {
    <#code#>
}

- (NSInteger)offsetFromPosition:(nonnull UITextPosition *)from toPosition:(nonnull UITextPosition *)toPosition {
    <#code#>
}

- (nullable UITextPosition *)positionFromPosition:(nonnull UITextPosition *)position inDirection:(UITextLayoutDirection)direction offset:(NSInteger)offset {
    <#code#>
}

- (nullable UITextPosition *)positionFromPosition:(nonnull UITextPosition *)position offset:(NSInteger)offset {
    <#code#>
}

- (nullable UITextPosition *)positionWithinRange:(nonnull UITextRange *)range farthestInDirection:(UITextLayoutDirection)direction {
    <#code#>
}

- (void)replaceRange:(nonnull UITextRange *)range withText:(nonnull NSString *)text {
    <#code#>
}

- (nonnull NSArray<UITextSelectionRect *> *)selectionRectsForRange:(nonnull UITextRange *)range {
    <#code#>
}

- (void)setBaseWritingDirection:(UITextWritingDirection)writingDirection forRange:(nonnull UITextRange *)range {
    <#code#>
}

- (void)setMarkedText:(nullable NSString *)markedText selectedRange:(NSRange)selectedRange {
    <#code#>
}

- (nullable NSString *)textInRange:(nonnull UITextRange *)range {
    <#code#>
}

- (nullable UITextRange *)textRangeFromPosition:(nonnull UITextPosition *)fromPosition toPosition:(nonnull UITextPosition *)toPosition {
    <#code#>
}

- (void)unmarkText {
    <#code#>
}

- (nonnull NSArray<id<UIFocusItem>> *)focusItemsInRect:(CGRect)rect {
    <#code#>
}

+ (nonnull instancetype)appearance {
    <#code#>
}

+ (nonnull instancetype)appearanceForTraitCollection:(nonnull UITraitCollection *)trait {
    <#code#>
}

+ (nonnull instancetype)appearanceForTraitCollection:(nonnull UITraitCollection *)trait whenContainedIn:(nullable Class<UIAppearanceContainer>)ContainerClass, ... {
    <#code#>
}

+ (nonnull instancetype)appearanceForTraitCollection:(nonnull UITraitCollection *)trait whenContainedInInstancesOfClasses:(nonnull NSArray<Class<UIAppearanceContainer>> *)containerTypes {
    <#code#>
}

+ (nonnull instancetype)appearanceWhenContainedIn:(nullable Class<UIAppearanceContainer>)ContainerClass, ... {
    <#code#>
}

+ (nonnull instancetype)appearanceWhenContainedInInstancesOfClasses:(nonnull NSArray<Class<UIAppearanceContainer>> *)containerTypes {
    <#code#>
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    <#code#>
}

- (CGPoint)convertPoint:(CGPoint)point fromCoordinateSpace:(nonnull id<UICoordinateSpace>)coordinateSpace {
    <#code#>
}

- (CGPoint)convertPoint:(CGPoint)point toCoordinateSpace:(nonnull id<UICoordinateSpace>)coordinateSpace {
    <#code#>
}

- (CGRect)convertRect:(CGRect)rect fromCoordinateSpace:(nonnull id<UICoordinateSpace>)coordinateSpace {
    <#code#>
}

- (CGRect)convertRect:(CGRect)rect toCoordinateSpace:(nonnull id<UICoordinateSpace>)coordinateSpace {
    <#code#>
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    <#code#>
}

- (void)setNeedsFocusUpdate {
    <#code#>
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
    <#code#>
}

- (void)updateFocusIfNeeded {
    <#code#>
}

@end

