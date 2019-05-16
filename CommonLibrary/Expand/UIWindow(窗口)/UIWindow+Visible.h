//
//  UIWindow+Visible.h
//  ShopMobile
//
//  Created by tsingh on 16/8/6.
//  Copyright © 2016年 soubao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (Visible)

/**
 获取窗口的可视控制器

 @return 控制器
 */
- (UIViewController *)getVisibleViewController;

@end
