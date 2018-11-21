//
//  ESImageViewOnClickListener.h
//  ESLibraryFramework
//
//  Created by 杜明悦 on 2018/11/21.
//  Copyright © 2018年 杜明悦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESImageView.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ESImageViewOnClickListener<NSObject>

@required
-(void)onClickListener:(id)view;

@end

NS_ASSUME_NONNULL_END
