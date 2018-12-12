//
//  UIImage+ESImage.h
//  ESLibraryFramework
//
//  Created by 杜明悦 on 2018/12/12.
//  Copyright © 2018年 杜明悦. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage ()
/**
 根据图片获取图片的主色调
 @param image
 */
-(UIColor*)mostColor:(UIImage*)image;
@end

NS_ASSUME_NONNULL_END
