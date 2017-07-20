//
//  ExUIView.m
//  Eruntech
//
//  Created by 杜明悦 on 13-2-25.
//
//

#import "ESView.h"

@implementation UIView(ESView)

/**
 查找当前UIView的UIViewController
 */
- (UIViewController*) searchViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

-(void)defaultStyle{
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 3.0;
    
    self.layer.shadowOffset =  CGSizeMake(3, 5);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowColor =  [UIColor lightTextColor].CGColor;
    
    //    [self.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:self.titleLabel.font.pointSize]];
}
@end
