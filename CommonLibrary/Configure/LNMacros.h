//
//  LNMacros.h
//  CommonLibrary
//
//  Created by usher on 2019/5/14.
//  Copyright © 2019年 usher. All rights reserved.
//  宏定义

#ifndef LNMacros_h
#define LNMacros_h

// 获取屏幕尺寸
#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

// HEXCOLOR(0x00ff00)
#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define kAppDelegate (AppDelegate *)[UIApplication sharedApplication].delegate;
#define LANGUAGE_MODEL [LNLanguageManager sharedInstance].languageModel

#define TopBarHeight 64.5
#define ThemeColor HEXCOLOR(0xE33235)

#define NaviBarTitleColor  HEXCOLOR(0xFFFFFF)
#define NaviBarItemColor  HEXCOLOR(0xFFFFFF)

#define TabBarTitleNormalColor  HEXCOLOR(0x999999)
#define TabBarTitleSelectColor  HEXCOLOR(0xE33235)
#define TabBarTitleTintColor   HEXCOLOR(0xFFFFFF)

#define BgColor HEXCOLOR(0xF7F7F7)

#define BgDarkColor HEXCOLOR(0x1a1a1a)
#define CellBgColor HEXCOLOR(0xFFFFFF)
#define CellSeparatorColor HEXCOLOR(0x484848)
#define AfterColor HEXCOLOR(0x282828)

#define TextDefaultColor HEXCOLOR(0x101010)
#define TextLightColor  HEXCOLOR(0x7d7d7d)
#define TextGoldColor   HEXCOLOR(0x9165F4)
#define TextDarkGoldColor   HEXCOLOR(0xB0A48C)
#define TextRedColor    HEXCOLOR(0xfd6668)
#define TextWhiteColor  HEXCOLOR(0xFFFFFF)

#define USUIIImage( __name ) [UIImage imageNamed:__name]
#define USKeyWindow [UIApplication sharedApplication].keyWindow

// iOS 10 不打印日志 通过以下方式解决
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#define printf(...)
#endif

// 分辨 不同设备
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

// 分辨不同 手机尺寸
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)// 640*960
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)//640x1136
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)//750x1334
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)//1080x1920
#define iPhoneX_TOP_HEIGHT  ([UIScreen mainScreen].bounds.size.height==812?88:64)
#endif /* LNMacros_h */
