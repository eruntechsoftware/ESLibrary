//
//  IValidatible.h
//  Eruntech
//数据校验协议
//  Created by 杜明悦 on 12-11-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModeType.h"


@protocol IStateProtected <NSObject>

@required
-(NSString*)getStateHiddenId;

@required
-(void)stateHiddenId:(NSString*)stateHiddenId;

@required
-(NSString*)getWantedStateValue;

@required
-(void)wantedStateValue:(NSString*) wantedStateValue;

@required
-(void)protectState:(BOOL)isMatched;

@required
-(void)modeType:(ModeType)modeType;

@required
-(ModeType) getModeType;
@end
