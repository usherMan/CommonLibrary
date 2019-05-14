//
//  LNBaseTableViewController.h
//  LNMobileProject
//
//  Created by  六牛科技 on 2017/11/6.
//
//  山东六牛网络科技有限公司 https://liuniukeji.com
//

#import <UIKit/UIKit.h>
#import "LNBaseTableViewCell.h"

typedef void(^SuccessBlock)(id responseObject);
typedef void(^FailedBlock)(NSString *errorMsg);
@interface LNBaseTableViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>


// 表视图
@property (nonatomic, strong) UITableView *tableView;
/**
 单元格加载的数据，可以在子类中处理
 */
@property (nonatomic, strong) NSMutableArray *dataArray;


/**
 !!!! 单元格的名称，需要在子类中指定自定义的单元格nib文件的名称
 */
@property (nonatomic, copy) NSString *cellNibName;

/**
 单元格的唯一标示，可以在子类中自定义，默认为cellNibName或@"LNBaseTableViewCell"
 */
@property (nonatomic, copy) NSString *cellIdentifer;

/**
 单元格的高度，可以在子类中自定义，默认高度50
 */
@property (nonatomic, assign) CGFloat cellHeight;

/**
 是否展示空视图，默认为YES
 */
@property (nonatomic, assign) BOOL showEnptyView;


/**
 加载数据，子类需要复写
 
 @param page page description
 */
- (void)loadData:(NSInteger)page;

/**
 加载网络数据
 @param url 请求的链接
 @param params 请求参数
 @param success 请求成功后的反馈数据
 */
- (void)loadDataWithUrl:(NSString *)url params:(NSDictionary *)params success:(SuccessBlock)success fail:(FailedBlock)fail;

/**
 监测空视图状态
 */
- (void)checkEmptyViewStatus;

@end
