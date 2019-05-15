//
//  NSString+StringHelp.h
//  MobileProject
//
//  Created by 云网通 on 16/8/23.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringHelp)

/**
 *  判断字符串是否为空 YES为空 NO 不为空
 *
 *  @return YES为空 NO 不为空
 *
 *  [str isBlankString]，str的值为nil，那么就会返回为nil。而nil。而nil对应的值为0，再对应到Bool上就是NO，判断不了
 */
+ (BOOL)isBlankString:(NSString *)str;

#pragma mark NSDate 转 NSString
/**
 返回 yyyy-MM-dd HH:mm:ss 格式时间字符串
 
 @return 格式时间字符串
 */
- (NSString *)stringOfYMDHMS;
/**
 返回 年-月-日  格式时间字符串
 
 @return 格式时间字符串
 */
- (NSString *)stringOfYMD;
/**
 返回 HH：mm：ss 格式时间字符串
 
 @return 格式时间字符串
 */
- (NSString*)stringOfHMS;
/**
 返回 HH：mm：ss 格式时间字符串
 
 @param timeInterval 描述
 @return 格式时间字符串
 */
+ (NSString*)stringWithTimeInterval:(NSInteger)timeInterval;
/**
 返回 特定格式的字符串（今天，昨天，周几，今年，去年）
 
 @return 时间字符串
 */
- (NSString *)timeTextOfDate;

/**
 将某个时间转化成 时间戳
 */
- (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

/**
 将某个时间戳转化成时间
 */
- (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;

/**
 格式化时间 由时间戳 转化成 时间间隔
 @return 几分钟前
 */
- (NSString *)timeInterval;

#pragma mark 正则表达式相关
/** 邮箱验证 */
- (BOOL)isValidEmail;

/** 手机号码验证 */
- (BOOL)isValidPhoneNum;

/** 车牌号验证 */
- (BOOL)isValidCarNo;

/** 网址验证 */
- (BOOL)isValidUrl;

/** 邮政编码 */
- (BOOL)isValidPostalcode;

/** 纯汉字 */
- (BOOL)isValidChinese;

/** 工商税号 */
- (BOOL)isValidTaxNo;

/**
 @brief  是否符合IP格式，xxx.xxx.xxx.xxx
 */
- (BOOL)isValidIP;

/** 身份证验证 refer to http://blog.csdn.net/afyzgh/article/details/16965107*/
- (BOOL)isValidIdCardNum;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     containDigtal   包含数字
 @param     containLetter   包含字母
 @param     containOtherCharacter   其他字符
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 *  计算 字符串 高度
 *
 *  @param font   字体大小
 *  @param width 限定长度
 *
 *  @return 字符串所占位置
 */
- (CGSize)textSizeWithFont:(CGFloat)font totalSizeWidth:(CGFloat)width;

//当前字符串是否只包含空白字符和换行符
- (BOOL)isWhitespaceAndNewlines;
//去除字符串前后的空白和换行符
- (NSString *)removeWhiteSpaceAndNewLine;
//去除字符串空格
- (NSString *)removeWhiteSpace;
//去除字符串换行
- (NSString *)removeNewLine;

/** 去掉html格式 */
- (NSString *)removeHtmlFormat;

// 对 手机号 中间4位处理
- (NSString *)processPhoneNumber;




@end
