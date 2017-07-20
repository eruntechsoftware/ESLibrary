//
//  ESPhotoAddView.m
//  Neighbour
//
//  Created by 松洋 on 2016/11/2.
//  Copyright © 2016年 杜明悦. All rights reserved.
//  添加照片的组件～

#import "ESPhotoAddView.h"
#import "Util.h"
#import "SKFCamera.h"
#import "ESView.h"
#import "ESImageView.h"

@implementation ESPhotoAddView


@synthesize collectSign=_collectSign;
@synthesize name=_name;
@synthesize dataType=_dataType;
@synthesize rootViewController = _rootViewController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self removeConstraints:self.constraints];
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:80];
        [self addConstraint:heightConstraint];
        // Initialization code
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
         _heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:80];
        [self addConstraint:_heightConstraint];
        // Initialization code
    }
    return self;

}


- (void) initializ
{
    
    _rootViewController = [self searchViewController];
    _photoPathArray = [[NSMutableArray alloc] initWithCapacity:1];
    _photoArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    // 设置时间格式
    _formatter = [[NSDateFormatter alloc] init];
    _formatter.dateFormat = @"yyyyMMddHHmmss";
    
    _placeholderImage = [UIImage imageNamed:@"icon_addpic_unfocused"];
    _maxPhotoCount = 9;
    
    [self setMyPhotoArray:_photoArray];

}

/**
 获取采集标记名
 */
-(NSArray*) getRequest
{
    NSArray* array = [[NSArray alloc] initWithObjects:_name, nil];
    return array;
}

/**
 将数据发布到指定位置
 @param dataName 数据名称
 @param data 数据对象
 */
-(void) release:(NSString *)dataName data:(Data *)data
{
    if (data != nil && [[data.name lowercaseString] isEqualToString:[_name lowercaseString]]) {
        
        NSArray *array = [(NSString*)data.value componentsSeparatedByString:_splitMark];
        for(int i=0;i<array.count;i++){
            [_photoArray addObject:array[i]];
            [_photoPathArray addObject:array[i]];
        }
        [self setMyPhotoArray:_photoArray];
        
    }
}

/**
 数据收集，返回ETDataCollection
 */
-(DataCollection*) collect
{
    DataCollection *datas = (DataCollection*)[NSMutableArray arrayWithCapacity:1];
    Data *data = [[Data alloc] initWithDataName:[self name] dataValue:@""];
    [datas addObject:data];
    return datas;
}

-(NSString *) getCollectSign
{
    return _collectSign;
}

-(NSString*) getName
{
    return _name;
}

/**
 设置照片数组
 @param photoArray 图片数组
 @return 返回此组件的动态计算高度
 */
-(CGFloat)setMyPhotoArray:(NSMutableArray*)photoArray{
    
    //为photoView的子项的最后一项添加点击事件调用相册或事相机
    UITapGestureRecognizer *gesAlert = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoAlert)];
    [gesAlert setNumberOfTapsRequired:1];
    
    //先移除所有子视图
    int subViewNum = (int)self.subviews.count;
    NSArray *subViews = self.subviews;
    for(int i=0;i<subViewNum;i++){
        [subViews[i] removeFromSuperview];
    }

    //添加图片的加号按钮
    if(![photoArray containsObject:_placeholderImage]){
        
        //如果没有icon_addpic_unfocused这个图片，则添加
        [photoArray addObject:_placeholderImage];
        [_photoPathArray addObject:@"imgPath"];
        
    }else{
        
        //如果有icon_addpic_unfocused这个图片，则移除，然后添加，使他处于数组的最后一位
        [photoArray removeObject:_placeholderImage];
        [photoArray addObject:_placeholderImage];
        [_photoPathArray removeObject:@"imgPath"];
        [_photoPathArray addObject:@"imgPath"];
    }
    
    //一行四个图片。间隔为6，计算出每个照片的宽高
    _photoWidth = ([UIScreen mainScreen].bounds.size.width - 30) / 4 -6;
    
    //初始化整个view的高度
   _photoAddViewHigh = 0;
    
    //根据照片的个数，动态计算出photoAddView的高度
    switch (photoArray.count) {
        case 1:
        case 2:
        case 3:
        case 4:
            _photoAddViewHigh = _photoWidth;
            break;
        case 5:
        case 6:
        case 7:
        case 8:
            _photoAddViewHigh = _photoWidth*2+6;
            break;
        default:
            _photoAddViewHigh = _photoWidth*3+12;
            break;
    }
    //编辑照片数组，把照片按照一行4个的顺序依次添加到photoAddView
    for(int index=0;index<photoArray.count;index++){
        
        //给index作取模运算，计算得出此照片相应的x坐标
            int xPlace = 0;
            if((index+1)%4 == 0){
               
                //如果索引位置+1模4等于0，则xPlace等于4，则是此行的第四张图片；
                xPlace = 4;
                
            }else{

                if(index>=4 && index<8){
                    
                    //如果索引位置是第二行的图片（4，5，6，7）的情况处理
                    xPlace = index-4+1;
                    
                }else if(index>=8){
                    
                    //如果索引位置是第三行的图片的情况处理
                    xPlace = index-8+1;
                    
                }else{
                    
                    //如果索引位置是第一行的图片的情况处理
                    xPlace = index+1;
                }
            }
        
            //初始化图片view的位置和大小，动态计算出 x坐标 和 y坐标
            ESImageView *uiPhoto = [[ESImageView alloc] initWithFrame:CGRectMake((xPlace-1)*(_photoWidth+6), ((int)(index/4))*(_photoWidth+6), _photoWidth, _photoWidth)];
           [uiPhoto setContentMode:UIViewContentModeScaleAspectFill];
           uiPhoto.clipsToBounds = YES;
        
            //显示图片
            if([photoArray[index] isKindOfClass:[NSString class]]){
                
                //若数组中为连接地址，则说明是修改照片
                [uiPhoto setImgWithUrlBody:photoArray[index]];
                
            }else{
                
                //拍照的照片或是相册获取的照片
                [uiPhoto setImage:photoArray[index]];
            }
        uiPhoto.tag = index;
        [self addSubview:uiPhoto];
        
        if(index == photoArray.count-1){
            
            [uiPhoto setUserInteractionEnabled:YES];
            [uiPhoto addGestureRecognizer:gesAlert];
            
        }else{
            
            //为photoView的子项添加点击事件看大图
            UITapGestureRecognizer *gesPhotoLook = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openPhotoView:)];
            [gesPhotoLook setNumberOfTapsRequired:1];
            [uiPhoto setTag:index];
            [uiPhoto setUserInteractionEnabled:YES];
            [uiPhoto addGestureRecognizer:gesPhotoLook];
        }
    }
    //返回photoAddView的动态高度
    _heightConstraint.constant = _photoAddViewHigh;
    return _photoAddViewHigh;
}

/**
 初始化拍照相册选择弹出框
 */
-(void)photoAlert{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"将访问您的相机或者相册" preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 添加按钮
    [alert addAction:[UIAlertAction actionWithTitle:@"相册选择" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [self openPhotos];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"相机拍摄" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [self openCamera];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        NSLog(@"点击了取消按钮");
        
    }]];
    
    [_rootViewController presentViewController:alert animated:YES completion:nil];
}

/**
 打开照相机
 */
-(void) openCamera{
    
    //相机拍摄点击事件
    SKFCamera *homec = [[SKFCamera alloc]init];
    homec.fininshcapture = ^(UIImage *photo){
        
        //相机拍照传回的照片，添加到当前的_photoArray，然后刷新下界面
        if (photo) {
            if(_photoArray.count+1 >_maxPhotoCount+1){
               [_rootViewController.view makeToast:[[NSString alloc] initWithFormat:@"最多添加%d张照片",_maxPhotoCount]];
                
            }else{
                [_photoArray addObject:photo];
                
                NSString *str = [_formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                [_photoPathArray addObject:fileName];
                
                [self setMyPhotoArray:_photoArray];
            }
        }
    } ;
    
    [_rootViewController presentViewController:homec animated:NO completion:^{}];
}

/**
 打开相册
 */
-(void) openPhotos{
    
    // 创建图片多选控制器
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    pickerVc.status = PickerViewShowStatusSavePhotos;
    pickerVc.maxCount = 9;
    
    //选完照片的回调，拿回照片，刷新ui
    pickerVc.callBack = ^(NSArray *assets){
        if(assets.count+_photoArray.count > _maxPhotoCount+1){
            [_rootViewController.view makeToast:[[NSString alloc] initWithFormat:@"最多添加%d张照片",_maxPhotoCount]];
            
        }else{
            for(int i=0;i<assets.count;i++){
                ZLPhotoAssets *zl = assets[i];
                [_photoArray addObject:zl.originImage];
                
                NSString *str = [_formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@%d.png", str,i];
                [_photoPathArray addObject:fileName];
                
                [self setMyPhotoArray:_photoArray];
            }
        }
    };
    
    //跳转到相册
    [pickerVc showPickerVc:_rootViewController];
}

/**
 点开照片看大图
 @param sender 点击的图片
 */
-(void)openPhotoView:(id)sender{
    
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    _browerVc = [[ZLPhotoPickerBrowserViewController alloc] init];
    _browerVc.delegate = self;
    _browerVc.editing = YES;
    _browerVc.currentIndex = [singleTap view].tag;
    
    //数组转化
    NSMutableArray<ZLPhotoPickerBrowserPhoto *> *photos = [[NSMutableArray alloc] init];
    for(int i=0;i<_photoArray.count-1;i++){
        ZLPhotoPickerBrowserPhoto *photo = [[ZLPhotoPickerBrowserPhoto alloc] init];
        
        //判断是链接还是UIImage
        if([_photoArray[i] isKindOfClass:[NSString class]]){
            photo.photoURL = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"%@%@",[ESImageView getImageUrlHead],_photoArray[i]]];
            
        }else{
            photo.photoImage = _photoArray[i];
        }
        
        [photos addObject:photo];
    }
    _browerVc.photos = photos;
    
    // 展示控制器
    [_browerVc showPushPickerVc:_rootViewController];
    
}

/**
 删除照片的回调用
 */
- (void)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser removePhotoAtIndex:(NSInteger)index{
    [_photoArray removeObjectAtIndex:index];
    [_photoPathArray removeObjectAtIndex:index];
    [self setMyPhotoArray:_photoArray];
}

/**
 返回照片数组
 */
-(NSMutableArray*)getPhotoArray{
    
    return _photoArray;
}

/**
 返回照片路径数组
 */
-(NSMutableArray*)getPhotoPathArray{
    
    return _photoPathArray;
}

/**
 返回图片添加器的高度
 */
-(CGFloat) getPhotoViewHigh{
    
    if(_photoAddViewHigh == 0 ){
        return 80;
    }else{
        return _photoAddViewHigh;
    }
}

@end
