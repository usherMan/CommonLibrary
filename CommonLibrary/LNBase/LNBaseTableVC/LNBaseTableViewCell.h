//
//  LNBaseTableViewCell.h
//  LNMobileProject
//
//  Created by  六牛科技 on 2017/11/6.
//
//  山东六牛网络科技有限公司 https://liuniukeji.com
//


#import <UIKit/UIKit.h>

@protocol LNBaseTableViewCellDelegate <NSObject>
/**
 单元格子视图被点击
 
 @param subView 子视图
 @param type 按钮类型
 @param indexPath 位置
 */
- (void)cellSubViewDidClick:(id)subView type:(NSString *)type cellIndexPath:(NSIndexPath *)indexPath;

@end

@interface LNBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) id<LNBaseTableViewCellDelegate> delegete;

- (void)setData:(id)data;

@end
