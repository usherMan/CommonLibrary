//
//  LNBaseTableViewCell.m
//  LNMobileProject
//
//  Created by  六牛科技 on 2017/11/6.
//
//  山东六牛网络科技有限公司 https://liuniukeji.com
//

#import "LNBaseTableViewCell.h"

@implementation LNBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setData:(id)data {
    self.textLabel.text = @"LNBaseTableViewCell";
}

@end
