//
//  UITextView+PlaceHolder.h
//  CommonLibrary
//
//  Created by usher on 2019/5/14.
//  Copyright © 2019年 usher. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (PlaceHolder)
/** 占位符*/
@property (nonatomic, copy) NSString *zw_placeHolder;

@property (nonatomic, copy) NSString *placeholder;
/** 占位符颜色*/
@property (nonatomic, strong) UIColor *zw_placeHolderColor;
/** 限制字数*/
@property (nonatomic, assign) NSInteger zw_limitCount;
/** lab的右边距(默认10)*/
@property (nonatomic, assign) CGFloat zw_labMargin;
/** lab的高度(默认20)*/
@property (nonatomic, assign) CGFloat zw_labHeight;
/** 统计限制字数Label*/
@property (nonatomic, readonly) UILabel *zw_inputLimitLabel;
@end

NS_ASSUME_NONNULL_END
