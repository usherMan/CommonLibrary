//
//  UIWindow+Visible.m
//  ShopMobile
//
//  Created by tsingh on 16/8/6.
//  Copyright © 2016年 soubao. All rights reserved.
//

#import "UIWindow+Visible.h"

@implementation UIWindow (Visible)

- (UIViewController *)getVisibleViewController {
    
    return [UIWindow getVisibleViewControllerFrom:self.rootViewController];
}

+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [UIWindow getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [UIWindow getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [UIWindow getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
    
}

@end
