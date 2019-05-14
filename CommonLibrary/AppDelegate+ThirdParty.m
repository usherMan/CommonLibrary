//
//  AppDelegate+ThirdParty.m
//  CommonLibrary
//
//  Created by usher on 2019/5/8.
//  Copyright © 2019年 usher. All rights reserved.
//

#import "AppDelegate+ThirdParty.h"
#import "OpenShareHeader.h"

@implementation AppDelegate (ThirdParty)

- (void)configurationAppKey {
    
    //第一步：注册key
    [OpenShare connectQQWithAppId:tencentAppID];
    [OpenShare connectWeixinWithAppId:wechatAppID];
    [OpenShare connectWeiboWithAppKey:weiboAppKey];
}

/*
 三方登录的回调事件
 */
// iOS9 以上用这个方法接收
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    NSLog(@"%@", options);
    //第二步：添加回调
    if ([OpenShare handleOpenURL:url]) {
        return YES;
    }
    //这里可以写上其他OpenShare不支持的客户端的回调，比如支付宝等。
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    //第二步：添加回调
    if ([OpenShare handleOpenURL:url]) {
        return YES;
    }
    //这里可以写上其他OpenShare不支持的客户端的回调，比如支付宝等。
    return YES;
}
@end
