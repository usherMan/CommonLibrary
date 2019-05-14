//
//  AppDelegate+AutoLogin.h
//  CommonLibrary
//
//  Created by usher on 2019/5/8.
//  Copyright © 2019年 usher. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

// 登录用户的账号密码
#define kLoginUserName @"loginUserName"
#define kLoginPassword @"loginPassword"
#define kLoginPrefix @"loginPrefix"
#define kLoginParams @"loginParams"
// 三方登录用户的openID
#define kThirdLoginUserOpenID @"kThirdLoginUserOpenID"

@interface AppDelegate (AutoLogin)
/**
 自动登录
 
 @param didSuccess 登录成功的回调
 @param didFailure 登录失败的回调
 */
-(void)autoLogin:(void(^)(void))didSuccess failure:(void(^)(NSString *error))didFailure;

/**
 登录账号
 
 @param url 登录接口
 @param params 登录参数
 @param didSuccess 登录成功
 @param didFailure 登录失败
 */
- (void)loginWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(void))didSuccess failure:(void(^)(NSString *error))didFailure;

/*
 三方登录
 
 @param url 登录接口
 @param params 登录参数
 @param didSuccess 登录成功
 @param didFailure 登录失败
 */
- (void)thirdLoginWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(void))didSuccess failure:(void(^)(NSString *error))didFailure;

/**
 登录失败，弹出登录界面
 
 @param NSString 失败原因
 */
- (void)presentLoginVC:(NSString *)error;

/**
 保存登录账号密码
 
 @param userName 登录账号
 @param password 登录密码
 */
- (void)saveUserNameAndPassword:(NSString *)userName password:(NSString *)password ;

/**
 保存三方登录用户ID
 
 @param openID 三方登录用户的openID
 */
- (void)saveThirdUserOpenId:(NSString *)openID;

/**
 退出登录
 */
- (void)logout;
@end

NS_ASSUME_NONNULL_END
