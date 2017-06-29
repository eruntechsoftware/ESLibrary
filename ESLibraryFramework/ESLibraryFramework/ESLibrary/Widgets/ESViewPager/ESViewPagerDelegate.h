//
//  ESViewPagerDelegate.h
//  Neighbour
//
//  Created by 杜明悦 on 2016/10/18.
//  Copyright © 2016年 杜明悦. All rights reserved.
//  ESViewPager 协议

@protocol ESViewPagerDelegate <NSObject>

/**
 滑动结束后执行的处理
 @param index 索引下标
 **/
-(void)viewPagerScrollDid:(int)index;

@end
