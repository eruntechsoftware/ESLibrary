//
//  ImageCollectionView.h
//  ESLibraryFramework
//
//  Created by 杜明悦 on 2017/7/4.
//  Copyright © 2017年 杜明悦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESImageView.h"
#import "ImageGardCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "CalculateViewWidth.h"

@interface ImageCollectionView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/**
 设置或获取cell中的图片网格组件设置图片数据
 **/
@property (strong, nonatomic) NSArray *imageArray;

/**
 设置或获取图片collection
 **/
@property (weak, nonatomic) UICollectionView *imageCollectionView;

/**
 给此cell中的图片网格组件设置图片数据
 @param imgsArray 图片数组
 **/
-(void)setImageData:(NSArray*) imgsArray;

@end
