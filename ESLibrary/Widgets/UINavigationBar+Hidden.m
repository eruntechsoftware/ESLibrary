//
//  UINavigationBar+Hidden.m
//  Neighbour
//
//  Created by 杜明悦 on 2016/10/17.
//  Copyright © 2016年 杜明悦. All rights reserved.
//

#import "UINavigationBar+Hidden.h"

@implementation UINavigationBar (Hidden)

/**
 隐藏NavigationBar下边线
 */
- (void)bottomLineViewHidden {

    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];}



@end
