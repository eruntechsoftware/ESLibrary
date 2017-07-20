//
//  ESPageControl.h
//  MeasureBody
//
//  Created by 松洋 on 2017/6/28.
//
//

#import <UIKit/UIKit.h>

@interface ESPageControl : UIPageControl


/**
 设置或获取UIPageControl的未选中图片
 */
@property  (strong,nonatomic)  UIImage *defaultPageControlImg;

/**
 设置或获取UIPageControl的选中图片
 */
@property  (strong,nonatomic)  UIImage *currentPageControlImg;

/**
 设置默认图片和当前图片
 @param defultPageControlImg 默认图片
 @pramr currentPageControlImg 当前图片
 */
-(instancetype)initWithImg:(UIImage*)defaultPageControlImg _currentPageControlImg:(UIImage*) currentPageControlImg;
@end
