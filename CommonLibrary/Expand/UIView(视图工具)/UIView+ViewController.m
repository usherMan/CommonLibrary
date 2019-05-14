//
//  UIView+ViewController.m
//  ShopMobile
//
//  Created by LiuNiu-MacMini-YQ on 2017/4/14.
//  Copyright © 2017年 soubao. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)

- (UIViewController *)controller {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
