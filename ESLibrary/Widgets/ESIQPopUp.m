//
//  ESIQPopUp.m
//  Neighbour
//
//  Created by 明悦 on 16/1/27.
//  Copyright © 2016年 ray. All rights reserved.
//

#import "ESIQPopUp.h"

@implementation ESIQPopUp
@synthesize showOnRect,popWidth,fieldFrame,popUpColor;

-(void)drawRect:(CGRect)rect{
    const CGFloat *color=CGColorGetComponents(popUpColor.CGColor);
    
    UIGraphicsBeginImageContext(CGSizeMake(30, 20));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, color[0], color[1], color[2], 1);
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 0), 7.0, [UIColor blackColor].CGColor);
    CGPoint points[3] = { CGPointMake(15, 5), CGPointMake(25, 25),
        CGPointMake(5,25)};
    CGContextAddLines(ctx, points, 3);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGRect imgframe=CGRectMake((showOnRect.origin.x+((showOnRect.size.width-30)/2)), ((showOnRect.size.height/2)+showOnRect.origin.y), 30, 13);
    
    UIImageView *img=[[UIImageView alloc] initWithImage:viewImage highlightedImage:nil];
    [self addSubview:img];
    img.translatesAutoresizingMaskIntoConstraints=NO;
    NSDictionary *dict=NSDictionaryOfVariableBindings(img);
    [img.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[img(%f)]",imgframe.origin.x,imgframe.size.width] options:NSLayoutFormatDirectionLeadingToTrailing  metrics:nil views:dict]];
    [img.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[img(%f)]",imgframe.origin.y,imgframe.size.height] options:NSLayoutFormatDirectionLeadingToTrailing  metrics:nil views:dict]];
    
    UIFont *font=[UIFont fontWithName:FontName size:FontSize];
    CGSize size=[self.strMsg boundingRectWithSize:CGSizeMake(fieldFrame.size.width-(PaddingInErrorPopUp*2), 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    size=CGSizeMake(ceilf(size.width), ceilf(size.height));
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectZero];
    [self insertSubview:view belowSubview:img];
    view.backgroundColor=self.popUpColor;
    view.layer.cornerRadius=5.0;
    view.layer.shadowColor=[[UIColor blackColor] CGColor];
    view.layer.shadowRadius=5.0;
    view.layer.shadowOpacity=1.0;
    view.layer.shadowOffset=CGSizeMake(0, 0);
    view.translatesAutoresizingMaskIntoConstraints=NO;
    dict=NSDictionaryOfVariableBindings(view);
    [view.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[view(%f)]",fieldFrame.origin.x+(fieldFrame.size.width-(size.width+(PaddingInErrorPopUp*2))),size.width+(PaddingInErrorPopUp*2)] options:NSLayoutFormatDirectionLeadingToTrailing  metrics:nil views:dict]];
    [view.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[view(%f)]",imgframe.origin.y+imgframe.size.height,size.height+(PaddingInErrorPopUp*2)] options:NSLayoutFormatDirectionLeadingToTrailing  metrics:nil views:dict]];
    
    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectZero];
    lbl.font=font;
    lbl.numberOfLines=0;
    lbl.backgroundColor=[UIColor clearColor];
    lbl.text=self.strMsg;
    lbl.textColor=ColorFont;
    [view addSubview:lbl];
    
    lbl.translatesAutoresizingMaskIntoConstraints=NO;
    dict=NSDictionaryOfVariableBindings(lbl);
    [lbl.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[lbl(%f)]",(float)PaddingInErrorPopUp,size.width] options:NSLayoutFormatDirectionLeadingToTrailing  metrics:nil views:dict]];
    [lbl.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[lbl(%f)]",(float)PaddingInErrorPopUp,size.height] options:NSLayoutFormatDirectionLeadingToTrailing  metrics:nil views:dict]];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    [self removeFromSuperview];
    return NO;
}

@end
