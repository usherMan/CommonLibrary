//
//  UILabel+LineSpace.h
//  LNMobileProject
//
//  Created by  六牛科技 on 2017/9/13.
//
//  山东六牛网络科技有限公司 https://liuniukeji.com
//

#import <UIKit/UIKit.h>

@interface UILabel (LineSpace)

/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;


@end
