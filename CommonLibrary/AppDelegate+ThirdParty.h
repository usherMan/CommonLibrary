//
//  AppDelegate+ThirdParty.h
//  CommonLibrary
//
//  Created by usher on 2019/5/8.
//  Copyright © 2019年 usher. All rights reserved.
//

//第三方服务
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

// QQ应用
static NSString *tencentAppID = @"1106804114";
static NSString *tencentAppkey = @"txR7XOiyqaUwuqsP";

// 微信应用
static NSString *wechatAppID = @"wx60f87b0bf41e64fa";
static NSString *wechatAppSecret = @"244d85a061ea243d1523ea7cb54cc467";

// 微博应用Appkey
static NSString *weiboAppKey = @"2617104885";
static NSString *weiboSecret = @"3bd038049eea5c553929333827df6f1b";
static NSString *weiboRedirectURI = @"http://www.liuniukeji.com";

@interface AppDelegate (ThirdParty)

/**
 配置第三方服务的appkey
 */
- (void)configurationAppKey;


@end

NS_ASSUME_NONNULL_END
