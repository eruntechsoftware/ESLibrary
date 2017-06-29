//
//  ESPageControl.m
//  MeasureBody
//
//  Created by 松洋 on 2017/6/28.
//
//

#import "ESPageControl.h"

@implementation ESPageControl

/**
 设置默认图片和当前图片
 @param defultPageControlImg 默认图片
 @pramr currentPageControlImg 当前图片
 **/
-(instancetype)initWithImg:(UIImage*)defaultPageControlImg _currentPageControlImg:(UIImage*) currentPageControlImg{
    
    self =[super init];
    _defaultPageControlImg = defaultPageControlImg;
    _currentPageControlImg = currentPageControlImg;
    return self;
}


-(void)setCurrentPage:(NSInteger)currentPage{
    
    [super setCurrentPage:currentPage];
    
    if(_defaultPageControlImg != nil && _currentPageControlImg != nil){
        
        for (int i=0; i<[self.subviews count]; i++) {
            //圆点
            UIView* dot = [self.subviews objectAtIndex:i];
            //添加imageView
            if ([dot.subviews count] == 0) {
                UIImageView * view = [[UIImageView alloc]initWithFrame:dot.bounds];
                [dot addSubview:view];
            };
            
            //配置imageView
            UIImageView * view = dot.subviews[0];
            
            if (i==self.currentPage) {
                view.image=self.currentPageControlImg;
                dot.backgroundColor = [UIColor clearColor];
            }else {
                view.image=self.defaultPageControlImg;
                dot.backgroundColor = [UIColor clearColor];
            }
        }
    }
}

@end
