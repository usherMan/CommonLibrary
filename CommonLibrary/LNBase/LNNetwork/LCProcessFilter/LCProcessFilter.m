//
// Created by Chenyu Lan on 8/27/14.
// Copyright (c) 2014 Fenbi. All rights reserved.
//

#import "LCProcessFilter.h"
#import "LCBaseRequest.h"
#import "AppDelegate.h"
//#import "LGAlertViewController.h"
//#import "LoginViewController.h"

@implementation LCProcessFilter
/**
 *  统一添加提交参数 统一加工key,lang
 *  统一加工
 *  @param argument NSDictionary
 *  @param queryArgument NSDictionary
 *
 *  @return NSDictionary
 */
- (NSDictionary *)processArgumentWithRequest:(NSDictionary *)argument query:(NSDictionary *)queryArgument{
    // 判断是否需要统一加工提交参数
    if([argument objectForKey:@"noAES"]){
        return argument;
    }
    
    NSMutableDictionary *argumentMutableDict = [[NSMutableDictionary alloc] initWithDictionary:argument];
//    if([SPMobileApplication sharedInstance].isLogined) {
//        SPUser *loginUser = [SPMobileApplication sharedInstance].loginUser;
//        if (loginUser.token) {
//            [argumentMutableDict setValue:loginUser.token forKey:@"token"];
//            NSLog(@"\n%@\n",loginUser.token)
//        }
//        if (loginUser.token) {
//            [argumentMutableDict setValue:loginUser.userid forKey:@"userid"];
//        }
//        [argumentMutableDict setValue:[[SPMobileApplication sharedInstance] getPhoneDeviceID] forKey:@"deviceid"];
//    }
    return argumentMutableDict;
}

/**
 *  用于统一加工返回数据
 *
 *  @param response response
 *
 *  @return 处理后的response
 */
- (id)processResponseWithRequest:(id)response{
    // 数据处理
    NSMutableDictionary *responseObject = [[NSMutableDictionary alloc] initWithDictionary:response];
    
    if ([response objectForKey:@"code"]) {
        NSString *code = [response objectForKey:@"code"];
        NSString *msg = [response objectForKey:@"msg"];
//        if ([code isEqualToString:@"authError"] && [msg isEqualToString:@"登录设备已更换"]) {
//            if (![[[self getCurrentVC] class] isEqual:[LoginViewController class]]&&![[[self getCurrentVC] class] isEqual:[LGAlertViewController class]]){
//                NSLog(@"%@",response);
//                [[[LGAlertView alloc] initWithTitle:LANGUAGE_MODEL.tip message:LANGUAGE_MODEL.txt_login_other_device style:0 buttonTitles:nil cancelButtonTitle:LANGUAGE_MODEL.done destructiveButtonTitle:nil actionHandler:nil cancelHandler:^(LGAlertView * _Nonnull alertView) {
//                    [[AppDelegate shareAppDelegate] logout];
//                } destructiveHandler:nil] showAnimated:YES completionHandler:nil];
//                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//                // 清空本地账号
//                [delegate saveUserNameAndPassword:nil password:@"" prefix:@""];
//                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"tripartite_open_id"];
//            }else{
//            }
//        }
    }
    
    if ([responseObject objectForKey:@"status"]) {
        NSInteger status = [[responseObject objectForKey:@"status"] integerValue];
        if (status == -1) {
        }
    }
    // result -> data
    if ([responseObject objectForKey:@"result"]) {
        [responseObject setObject:[responseObject objectForKey:@"result"] forKey:@"data"];
    }
    // info -> msg
    if ([responseObject objectForKey:@"info"]) {
        [responseObject setObject:[responseObject objectForKey:@"info"] forKey:@"msg"];
    }
    return responseObject;
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }

    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

@end
