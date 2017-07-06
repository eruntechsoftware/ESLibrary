//
//  CalculateImageWidth.m
//  Neighbour
//
//  Created by 松洋 on 2016/10/25.
//  Copyright © 2016年 杜明悦. All rights reserved.
//  动态计算view的高度的工具类

#import "CalculateViewWidth.h"

@implementation CalculateViewWidth
/**
 通过九宫格图片的个数，计算每个图片的宽高
 @param  leftRange  离左边屏幕的距离
 @param  rightRange 离右边屏幕的距离
 @param  imgCount   图片个数
 @param  imgRange   图片间的间距
 @param  cellRangeTOSide cell到屏幕边的距离
 **/
+(CGFloat) getImgWidth:(CGFloat) leftRange _rightRange:(CGFloat) rightRange _imgCount:(int)imgCount _imgRange:(CGFloat)imgRange _cellRangeTOSide:(CGFloat)cellRangeTOSide{
    
    CGFloat collectionViewWidth = [UIScreen mainScreen].bounds.size.width-leftRange-rightRange-5-cellRangeTOSide*2;
    CGFloat imgWidth = 0;
    
    if(imgCount == 0){
        return 0;
        
    }else if(imgCount == 1){
        imgWidth = collectionViewWidth-2*imgRange;
        return imgWidth;
        
    }else if(imgCount == 4){
        imgWidth = (collectionViewWidth-5*imgRange)/2;
        return imgWidth;
        
    }else{
        imgWidth = (collectionViewWidth-6*imgRange)/3;
        return imgWidth;
    }
}

/**
 计算tableviewCell的高度，主要由九宫格的图片影响高度
 @param rowHeight 自身行高
 #param imgArray 图片尺寸
 **/
+(CGFloat) getCellHeight:(CGFloat) rowHeight _imgArray:(NSArray*)imgArray{
    
    //计算图片的宽高尺寸
    CGFloat imgHeight = [self getImgWidth:56 _rightRange:28 _imgCount:(int)imgArray.count _imgRange:3 _cellRangeTOSide:3];
    
    //cell自身的高度
    int imgCount = (int)imgArray.count;
    
    switch (imgCount) {
        case 1:
            // 1张图片时候cell的高度
            if([imgArray[0] isEqualToString:@""]){
                return rowHeight-10;
                
            }else{
                return rowHeight+imgHeight;
            }
            
            break;
        case 2:
        case 3:
            // 2,3张图片的时候的cell的高度
            return rowHeight+imgHeight-6;
        case 4:
        case 5:
        case 6:
            // 4,5,6图片的时候的cell的高度
            return rowHeight+imgHeight*2;
            break;
        case 7:
        case 8:
        case 9:
            // 7张，8张，9张图片的时候的cell的高度
            return rowHeight+imgHeight*3;
            break;
        default:
            return rowHeight-10;
            break;
    }

}
@end
