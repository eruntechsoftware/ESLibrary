//
//  IReleaser.h
//  Eruntech
//
//  Created by 杜明悦 on 12-11-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol IReleaser <NSObject>

/**
 数据发布
 @param result DataTable数据集
 **/
@required
-(void) release:(id) result;
@end
