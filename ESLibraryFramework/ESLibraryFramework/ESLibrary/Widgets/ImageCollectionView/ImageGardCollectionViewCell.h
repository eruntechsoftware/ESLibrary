//
//  ImageGardCollectionViewCell.h
//  Neighbour
//
//  Created by 松洋 on 2016/10/22.
//  Copyright © 2016年 杜明悦. All rights reserved.
//  九宫格图片网格组件cell

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "ESImageView.h"

@interface ImageGardCollectionViewCell : UICollectionViewCell

/**
 设置或获取网格图片
 **/
@property (weak, nonatomic) IBOutlet ESImageView *imageView;

@end
