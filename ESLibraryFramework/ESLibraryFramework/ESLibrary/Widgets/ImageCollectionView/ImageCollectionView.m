//
//  ImageCollectionView.m
//  ESLibraryFramework
//
//  Created by 杜明悦 on 2017/7/4.
//  Copyright © 2017年 杜明悦. All rights reserved.
//

#import "ImageCollectionView.h"

@implementation ImageCollectionView

-(void)setFrame:(CGRect)frame{
    //设置cell的左右边距
    frame.origin.x += 3;
    frame.size.width -= 2 * 3;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _imageCollectionView.delegate = self;
    _imageCollectionView.dataSource = self;
    [self.imageCollectionView setUserInteractionEnabled:NO];
    
    /*漂浮效果*/
    self.layer.shadowColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:236/255.0 alpha:1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.3, 0.3);//偏移距离
    self.layer.shadowOpacity = 0.5;//不透明度
    self.layer.shadowRadius = 2;//半径
    
    UINib *nib =[UINib nibWithNibName:@"ImageGardCollectionViewCell" bundle:nil];
    [_imageCollectionView registerNib:nib forCellWithReuseIdentifier:@"ImageGardCollectionViewCell"];
}

/**设置图片网格的图片数据**/
-(void)setImageData:(NSArray *)imgsArray{
    _imageArray = imgsArray;
    [_imageCollectionView reloadData];
}

/**
 collectionView中图片的个数
 @overwrite
 **/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageArray.count;
}

/**
 collectionView的cell
 @overwrite
 **/
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageGardCollectionViewCell* cell = [_imageCollectionView dequeueReusableCellWithReuseIdentifier:@"ImageGardCollectionViewCell" forIndexPath:indexPath];
    
    //设置九宫格的图片
    NSString *picUrl = [[NSString alloc] initWithFormat:@"%@%@",[ESImageView getImageUrlHead],_imageArray[indexPath.row]];
    
    //如果图片数组[0]的数据为“”的时候，默认设置一个白色图片，
    if(![_imageArray[indexPath.row] isEqualToString:@""]){
        
        NSURL *url = [NSURL URLWithString:picUrl];
        [cell.imageView setContentMode:UIViewContentModeScaleAspectFill];
        cell.imageView.layer.shouldRasterize = YES;
        cell.imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        [cell.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"load_lmage2"]];
        
    }else{
        [cell.imageView setImage:[UIImage imageNamed:@"whiltbar"]];
    }
    return cell;
}

/**
 collectionView中Sections的个数（好像没啥用）
 @overwrite
 **/
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

/**
 collectionView中每个子项的大小
 @overwrite
 **/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //调用方法CalculateImageWidth，动态计算出九宫格图片的宽度
    CGFloat imgWidth = [CalculateViewWidth getImgWidth:56 _rightRange:28 _imgCount:(int)_imageArray.count _imgRange:3 _cellRangeTOSide:3];
    return CGSizeMake(imgWidth, imgWidth);
    
}


@end
