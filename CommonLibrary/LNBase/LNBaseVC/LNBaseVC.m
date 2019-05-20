//
//  LNBaseVC.m
//  LNBaseProject
//
//  Created by LiuNiu-MacMini-YQ on 2016/12/23.
//  Copyright © 2016年 LiuNiu-MacMini-YQ. All rights reserved.
//

#import "LNBaseVC.h"
#import "UIWindow+Visible.h"
#import "AppDelegate.h"
@interface LNBaseVC ()

@end

@implementation LNBaseVC

#pragma mark - ---- 生命周期 ----
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = BgColor;
    //登录为true，没有登录为false
    self.userLogin = false;
}

/**
 *  设置导航栏
 */
-(void)initNavigationBar{
    
}
/**
 * 显示某选项卡
 */
-(void)showTabWithIndex:(NSInteger)selectIndex{
    
    
//    UITabBarController* tabBarVC = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController ;
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
//    delegate.mainTabBarController.selectedIndex = selectIndex;

    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
@end
