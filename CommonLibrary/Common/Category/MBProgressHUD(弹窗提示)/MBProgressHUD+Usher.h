//
//  MBProgressHUD+Usher.h
//  CommonLibrary
//
//  Created by usher on 2019/5/14.
//  Copyright © 2019年 usher. All rights reserved.
//  弹窗提示

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

// 统一的显示时长
#define kHudShowTime 1.5

#define SHOWMESSAGE(a) [MBProgressHUD showMessage:a];
#define SHOWERROR(a)   [MBProgressHUD showError:a];
#define SHOWLOADING    [MBProgressHUD showActivityMessage:@"加载中..."];
#define REMOVESHOW     [MBProgressHUD hideHUD];

@interface MBProgressHUD (Usher)

#pragma mark 在指定的view上显示hud
+ (void)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;//带“✔️”图片
+ (void)showError:(NSString *)error toView:(UIView *)view;//带“X”图片
+ (void)showWarning:(NSString *)Warning toView:(UIView *)view;//带“！”图片
+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showActivityMessage:(NSString*)message view:(UIView *)view;
+ (MBProgressHUD *)showProgressBarToView:(UIView *)view;//带进度条(hub.progress控制)

#pragma mark 在window上显示hud
+ (void)showMessage:(NSString *)message;//纯文本
+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (void)showWarning:(NSString *)Warning;
+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message;
+ (MBProgressHUD *)showActivityMessage:(NSString*)message;//带“菊花”文本提示

#pragma mark 移除hud
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end

NS_ASSUME_NONNULL_END
