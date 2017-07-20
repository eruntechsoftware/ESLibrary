//
//  ESImageCollectionView.m
//  ESLibraryFramework
//
//  Created by 杜明悦 on 2017/7/13.
//  Copyright © 2017年 杜明悦. All rights reserved.
//

#import "ESImageCollectionView.h"

static CGFloat IMAGE_SPACE = 4;
static CGFloat IMAGE_WIDTH;
static CGFloat IMAGE_COLLECTION_VIEW_WIDTH;

@implementation ESImageCollectionView



- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.delegate = self;
    self.dataSource = self;
    [self setUserInteractionEnabled:NO];
    
    
    /*漂浮效果*/
    self.layer.shadowColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:236/255.0 alpha:1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.3, 0.3);//偏移距离
    self.layer.shadowOpacity = 0.5;//不透明度
    self.layer.shadowRadius = 2;//半径
    
    UINib *nib =[UINib nibWithNibName:@"ImageGardCollectionViewCell" bundle:nil];
    [self registerNib:nib forCellWithReuseIdentifier:@"ImageGardCollectionViewCell"];
    IMAGE_COLLECTION_VIEW_WIDTH = UIVIEW_WIDTH;
}



/**
 给此cell中的图片网格组件设置图片数据

 @param imgsArray 图片数组，数组内存储图片路径
 **/
-(void)setImageList:(NSArray *)imgsArray{
    _imgsArray = imgsArray;
    [self reloadData];
}

/**
 collectionView中图片的个数
 @overwrite
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imgsArray.count;
}

/**
 collectionView的cell
 @overwrite
 */
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageGardCollectionViewCell* cell = [self dequeueReusableCellWithReuseIdentifier:@"ImageGardCollectionViewCell" forIndexPath:indexPath];
    
    //设置九宫格的图片
    NSString *picUrl = [[NSString alloc] initWithFormat:@"%@%@",[ESImageView getImageUrlHead],_imgsArray[indexPath.row]];
    
    //如果图片数组[0]的数据为“”的时候，默认设置一个白色图片，
    if(![_imgsArray[indexPath.row] isEqualToString:@""]){
        
        NSURL *url = [NSURL URLWithString:picUrl];
        [cell.imgView setContentMode:UIViewContentModeScaleAspectFill];
        cell.imgView.layer.shouldRasterize = YES;
        cell.imgView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        [cell.imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"load_lmage2"]];
        
    }else{
        [cell.imgView setImage:[UIImage imageNamed:@"whiltbar"]];
    }
    return cell;
}

/**
 collectionView中Sections的个数（好像没啥用）
 @overwrite
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

/**
 collectionView中每个子项的大小
 @overwrite
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //计算每行显示的图片数量
    float _columns = (_imgsArray.count<=3)?_imgsArray.count:(_imgsArray.count==4)?2:3;
    IMAGE_SPACE = _columns *8;

    //动态计算出九宫格图片的宽度
    IMAGE_WIDTH = (UIVIEW_WIDTH - IMAGE_SPACE) / _columns;
    return CGSizeMake(IMAGE_WIDTH, IMAGE_WIDTH);
}

/**
 获取图片在布局中所占的高度
 
 @param count 图片数量
 @return  图片所占的高度
 */
+(CGFloat)getImageCollectionViewLayoutHeight:(NSInteger)count{
    
    //计算在指定的显示每行最多显示
    float _columns = (count<=3)?count:(count==4)?2:3;
    IMAGE_SPACE = _columns *8;
    //动态计算出九宫格图片的宽度
    IMAGE_WIDTH = (IMAGE_COLLECTION_VIEW_WIDTH - IMAGE_SPACE) / _columns;
    
    //计算图片在每行3列图片，获取行数
    float rows = ceilf(count/3.00);
    CGFloat HEIGHT = rows *IMAGE_WIDTH + (rows-1)*IMAGE_SPACE;
    return HEIGHT;
}

@end
