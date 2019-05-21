//
//  UIView+Extend.h
//  CommonLibrary
//
//  Created by usher on 2019/5/21.
//  Copyright © 2019年 usher. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extend)
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;

- (void)setSize:(CGSize)size;
- (void)setOrigin:(CGPoint)point;

- (CGFloat)height;
- (CGFloat)width;
- (CGFloat)x;
- (CGFloat)y;
- (void)centerInHorizontal:(UIView *)parentView;
- (void)centerInVertical:(UIView *)parentView;
- (void)centerInView:(UIView *)parentView;

- (CALayer *)addSubLayerWithFrame:(CGRect)frame color:(CGColorRef)colorRef;

- (void)addTopAndBottomLineWithColor:(CGColorRef)color;
- (void)addTopAndBottomLineWithHeight:(float)height color:(CGColorRef)colorRef;

- (CALayer *)addTopFillLineWithColor:(CGColorRef)color;
- (CALayer *)addBottomFillLineWithColor:(CGColorRef)color;

- (void)tapGestureWithTarget:(id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
