//
//  LNBaseVC.h
//  LNBaseProject
//
//  Created by LiuNiu-MacMini-YQ on 2016/12/23.
//  Copyright © 2016年 LiuNiu-MacMini-YQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface LNBaseVC : UIViewController
@property (nonatomic, assign) BOOL userLogin;

// 未登录的情况下 是否需要 登录 状态 默认 NO 不做检查
@property (assign, nonatomic) BOOL loginCheck;


-(void)initNavigationBar;
-(void)showTabWithIndex:(NSInteger)selectIndex;
@end
