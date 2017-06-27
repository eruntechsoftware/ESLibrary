//
//  ExUIView.h
//  Eruntech
//
//  Created by 杜明悦 on 13-2-25.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ESNSString.h"

@interface UIView(ESView)

/**
 查找当前View的UIViewController
 **/
- (UIViewController*) searchViewController;

-(void)defaultStyle;


@end
