//
//  CalculateImageWidth.h
//  Neighbour
//
//  Created by 松洋 on 2016/10/25.
//  Copyright © 2016年 杜明悦. All rights reserved.
//  动态计算view的高度的工具类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CalculateViewWidth : NSObject

/**
 通过九宫格图片的个数，计算每个图片的宽高
 @param  leftRange  离左边屏幕的距离
 @param  rightRange 离右边屏幕的距离
 @param  imgCount   图片个数
 @param  imgRange   图片间的间距
 @param  cellRangeTOSide cell到屏幕边的距离
 **/
+(CGFloat) getImgWidth:(CGFloat) leftRange _rightRange:(CGFloat) rightRange _imgCount:(int)imgCount _imgRange:(CGFloat)imgRange _cellRangeTOSide:(CGFloat)cellRangeTOSide;

/**
 计算tableviewCell的高度，主要由九宫格的图片影响高度
 @param rowHeight 自身行高
 #param imgArray 图片数组
 **/
+(CGFloat) getCellHeight:(CGFloat) rowHeight _imgArray:(NSArray*)imgArray;
@end
