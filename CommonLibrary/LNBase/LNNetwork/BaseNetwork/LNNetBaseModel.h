//
//  BaseModel.h
//  MobileProject
//
//  Created by 云网通 on 16/5/30.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNNetBaseModel : NSObject
@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *msg;
//子类 自己写 data 属性, 因为 data 不一定都是 NSDictionary，还可能是 NSArray NSNumber NSSString 等
//@property (nonatomic, copy) NSDictionary *data;
@end

@interface LNNetBaseModel (Helper)

- (BOOL)isSuccess;

- (NSError *)error;

@end
