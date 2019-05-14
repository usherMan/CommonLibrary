//
//  AppDelegate+AutoLogin.m
//  CommonLibrary
//
//  Created by usher on 2019/5/8.
//  Copyright © 2019年 usher. All rights reserved.
//
#import "AppDelegate+AutoLogin.h"
@implementation AppDelegate (AutoLogin)
/**
 自动登录
 
 @param didSuccess 登录成功的回调
 @param didFailure 登录失败的回调
 */
-(void)autoLogin:(void(^)(void))didSuccess failure:(void(^)(NSString *error))didFailure{
    
    // 获取本地存储的三方登录用户的openid
    NSString *openIDUser = [[NSUserDefaults standardUserDefaults] stringForKey:kThirdLoginUserOpenID];;
//    NSLog(@"++++++++++++%@",[SPMobileApplication sharedInstance].loginUser.token);
    // 获取本地存储的账号密码
    NSString *SERVICE_NAME = [[NSBundle mainBundle] bundleIdentifier];
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:SERVICE_NAME];
    NSString *username = [keychain stringForKey:kLoginUserName];
    NSString *password = [keychain stringForKey:kLoginPassword];
    NSString *prefix = [keychain stringForKey:kLoginPrefix];
    NSString *openID = [keychain stringForKey:kThirdLoginUserOpenID];
    NSString *userINfo = [keychain stringForKey:@"GLOBALUSERINFO"];
    
    NSDictionary *params;
    NSString *uuid =nil;
    
    //测试
    //openID = @"";
    if (openID.length !=0) {
        // 三方账号自动登录
        [self thirdLoginWithUrl:@"mobileIndex/login.do" params:@{@"loginType":@"3",@"deviceid":uuid,@"loginDevice":@"2",@"openid":openID} success:^{
            // 登录成功回调
            didSuccess();
        } failure:^(NSString *error) {
            // 登录失败回调
            didFailure(error);
        }];
    }else if (password && username) {
        if ([username containsString:@"@"]) {
//            params = @{@"loginType":@"2",@"email":username,@"pwd":[LNEncryption md5:password],@"deviceid":uuid,@"loginDevice":@"2"};
        }else {
//            params = @{@"loginType":@"1",@"phonePrefix":prefix,@"phone":username,@"pwd":[LNEncryption md5:password],@"deviceid":uuid,@"loginDevice":@"2"};
        }
        // 系统账号自动登录
        [self loginWithURL:@"mobileIndex/login.do" params:params success:^{
            // 登录成功回调
            didSuccess();
        } failure:^(NSString *error) {
            // 登录失败回调
            didFailure(error);
        }];
    }else{
        // 无登录信息
        didFailure(nil);
    }
}


/**
 账号密码登录
 
 @param url 登录接口
 @param params 登录参数
 @param didSuccess 登录成功
 @param didFailure 登录失败
 */
- (void)loginWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(void))didSuccess failure:(void(^)(NSString *error))didFailure {

}

/*
 三方登录
 
 @param url 登录接口
 @param params 登录参数
 @param didSuccess 登录成功
 @param didFailure 登录失败
 */
- (void)thirdLoginWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(void))didSuccess failure:(void(^)(NSString *error))didFailure {
    
//    [SVProgressHUD showWithStatus:LANGUAGE_MODEL.logging];
//    LNNetWorkAPI *api = [[LNNetWorkAPI alloc] initWithUrl:url parameters:params];
//    [api startWithBlockSuccess:^(__kindof LCBaseRequest *request) {
//        [SVProgressHUD dismiss];
//        if ([request.responseJSONObject[@"code"] isEqualToString:@"success"]) {
//            NSString * token = [NSString stringWithFormat:@"%@",request.responseJSONObject[@"data"][@"token"]];
//            NSString * userid = [NSString stringWithFormat:@"%@",request.responseJSONObject[@"data"][@"userid"]];
//            // 缓存用户信息
//            [self getUserInfoWidthToken:token Userid:userid];
//
//            // 登录成功回调
//            didSuccess();
//
//        }else{
//            // 登录失败回调
//            didFailure(request.responseJSONObject[@"msg"]);
//        }
//    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
//        [SVProgressHUD dismiss];
//        // 登录失败回调
//        didFailure(error.localizedDescription);
//    }];
}
/**
 登录失败，弹出登录界面
 
 @param NSString 失败原因
 */
- (void)presentLoginVC:(NSString *)error {
    if (error.length > 0) {
        [SVProgressHUD showErrorWithStatus:error];
    }
//    LoginViewController *vc = [[LoginViewController alloc] init];
//    LNNavigationController *navi = [[LNNavigationController alloc] initWithRootViewController:vc];
//    [self.window.rootViewController presentViewController:navi animated:YES completion:nil];
}

/**
 保存登录账号密码
 
 @param userName 登录账号
 @param password 登录密码
 */
- (void)saveUserNameAndPassword:(NSString *)userName password:(NSString *)password prefix:(NSString *)prefix {
    
    // 获取本地保存的登录账号密码
    NSString *SERVICE_NAME = [[NSBundle mainBundle] bundleIdentifier];
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:SERVICE_NAME];
    NSString *keychainName = [keychain stringForKey:kLoginUserName];
    NSString *keychainPass = [keychain stringForKey:kLoginPassword];
    NSString *keychainPrefix = [keychain stringForKey:kLoginPrefix];
    if (![userName isEqualToString:keychainName] ) { //|| keychainName == nil
        [keychain setString:userName forKey:kLoginUserName];
    }
    if(![password isEqualToString:keychainPass] ){ // || keychainPass == nil
        [keychain setString:password forKey:kLoginPassword];
    }
    if(![prefix isEqualToString:keychainPrefix] ){ // || keychainPass == nil
        [keychain setString:prefix forKey:kLoginPrefix];
    }
}

/**
 保存三方登录用户ID
 
 @param openID 三方登录用户的openID
 */
- (void)saveThirdUserOpenId:(NSString *)openID {
    // 获取本地存储的三方登录用户的openid
    NSString *SERVICE_NAME = [[NSBundle mainBundle] bundleIdentifier];
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:SERVICE_NAME];
    NSString *keychainOpenID = [keychain stringForKey:kThirdLoginUserOpenID];
    NSLog(@"openID:%@",openID);
    if (![openID isEqualToString:keychainOpenID] ) { //|| keychainName == nil
        [keychain setString:openID forKey:kThirdLoginUserOpenID];
    }
}
@end
