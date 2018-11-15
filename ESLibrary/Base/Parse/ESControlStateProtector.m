//
//  ESControlStateProtector.m
//  ESLibraryFramework
//
//  Created by 杜明悦 on 2018/11/15.
//  Copyright © 2018年 杜明悦. All rights reserved.
//

#import "ESControlStateProtector.h"

@implementation ESControlStateProtector
@synthesize viewController=_viewController;

/**
 初始化查询控制器
 @param viewController 当前视图控制器
 @return 查询控制器
 */
-(id) initWithViewController:(UIViewController*)viewController
{
    self = [super init];
    if (self) {
        self.viewController = viewController;
        _hiddenFeilds = [[NSMutableArray alloc] initWithCapacity:1];
        return self;
    }
    return nil;
}


/**
 获取数据
 */
-(void) stateProtector
{
    if (self.viewController) {
        NSMutableArray *controllist = [NSMutableArray new];
        [controllist addObject:self];
        ControlSearcher* searcher=[[ControlSearcher alloc] initControlSearcherWithHandler:controllist];
        [searcher search:self.viewController];
    }
}

/**
 循环基类实现接口，循环接口调用此接口实现方法
 @param obj uiview对象
 */
-(void) handle:(id) obj
{
    @try
    {
        if(obj!=nil)
        {
            id<IStateProtected> aprotected = (id<IStateProtected>)obj;
            if (aprotected != nil)
            {
                NSArray<NSString *> *stateValuelist = [[aprotected wantedStateValue] componentsSeparatedByString:NSLocalizedString(@"|!", nil)];
                NSArray<NSString *> *stateNamelist = [[aprotected stateHiddenId] componentsSeparatedByString:NSLocalizedString(@"|!", nil)];
                if (stateValuelist != nil && stateValuelist.count>0 && stateNamelist!=nil && stateNamelist.count>0)
                {
                    //获取对应stateid的值
                    [self hiddenFeildList:_viewController.view names:stateNamelist];
   
                    if (_hiddenFeilds != nil && _hiddenFeilds.count > 0)
                    {
                        BOOL result = [self stateIsMatched:[aprotected wantedModeType] wanted:stateValuelist currentValues:_hiddenFeilds];
                        [aprotected protectState:result];
                    }
                }
            }
        }
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
        
    }
}

/**
 循环基类实现接口，调用此方法实现，以决定是否继续执行
 @param obj 采集对象
 */
-(BOOL) isPicked:(id) obj
{
    return [obj conformsToProtocol:@protocol(IStateProtected)];
}

-(BOOL)stateIsMatched:(BOOL) modeType wanted:(NSArray<NSString *>*)wantedstate currentValues:(NSArray<NSString *>*) current
{
    BOOL result = NO;
    if (wantedstate==nil)
    {
        return YES;
    }
    NSUInteger size = wantedstate.count;
    if(modeType==YES)
    {
        for (int i = 0; i < size; i++)
        {
            if ([current containsObject:[wantedstate objectAtIndex:i]])
            {
                result = YES;
            }
            else
            {
                result = NO;
                break;
            }
        }
    }
    if(modeType==NO)
    {
        for (int i = 0; i < size; i++)
        {
            if ([current containsObject:[wantedstate objectAtIndex:i]])
            {
                result = YES;
                break;
            }
        }
    }
    return result;
}

-(void)hiddenFeildList:(UIView*)parentView names:(NSArray<NSString *>*)nameArray
{
    @try
    {
        if(parentView!=nil && parentView.subviews.count>0)
        {
            for(UIView *subView in parentView.subviews)
            {
                [self hiddenFeildList:subView names:nameArray];
            }
        }
        else
        {
            if([parentView isKindOfClass:[ESHiddenFeild class]])
            {
                ESHiddenFeild *feild = (ESHiddenFeild*)parentView;
                if([nameArray containsObject: feild.name])
                {
                    [_hiddenFeilds addObject:feild.text];
                }
            }
        }
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
        
    }
}
@end
