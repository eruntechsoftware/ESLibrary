//
//  ESImageCollectionView.h
//  ESLibraryFramework
//
//  Created by 杜明悦 on 2017/7/13.
//  Copyright © 2017年 杜明悦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESImageView.h"
#import "ImageGardCollectionViewCell.h"

// 获得屏幕尺寸
#define UIVIEW_WIDTH   self.frame.size.width
IB_DESIGNABLE
@interface ESImageCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *_imgsArray;
}

/**
 给此cell中的图片网格组件设置图片数据
 @param imgsArray 图片数组，数组内存储图片路径
 */
-(void)setImageList:(NSArray*) imgsArray;



/**
 获取图片在布局中所占的高度

 @param count 图片数量
 @return  图片所占的高度
 */
+(CGFloat)getImageCollectionViewLayoutHeight:(NSInteger)count;

@end
