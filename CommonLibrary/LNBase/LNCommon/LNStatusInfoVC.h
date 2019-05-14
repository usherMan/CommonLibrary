//
//  LNStatusInfoVC.h
//  ShopMobile
//
//  Created by LiuYanQiMini on 2017/5/11.
//  Copyright © 2017年 soubao. All rights reserved.
//

#import "LNBaseVC.h"

@interface LNStatusInfoVC : LNBaseVC
@property (copy, nonatomic) NSString *statusInfo;
@property (weak, nonatomic) IBOutlet UILabel *statusInfoLabel;

@property (assign, nonatomic) NSInteger removeIndex;    // 删除几个 默认一个



@end
