//
//  LNBaseTableViewController.m
//  LNMobileProject
//
//  Created by  六牛科技 on 2017/11/6.
//
//  山东六牛网络科技有限公司 https://liuniukeji.com
//

#import "LNBaseTableViewController.h"
#import "LNBaseTableViewCell.h"// 单元格
#import "LNBaseTableViewAPI.h"// 请求
#import "EmptyDataSource.h"

@interface LNBaseTableViewController ()

// 空视图
@property (strong, nonatomic) EmptyDataSource *emptyDataSource;

/**
 分页数据
 */
@property (nonatomic, assign) NSInteger page;


@end

@implementation LNBaseTableViewController

#pragma mark - ---- 生命周期 ----
- (instancetype)init {
    self = [super init];
    if (self) {
        self.showEnptyView = YES;
        self.cellIdentifer = @"LNBaseTableViewCell";
        self.cellHeight = 50;
        self.page = 1;
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.showEnptyView = YES;
        self.cellIdentifer = @"LNBaseTableViewCell";
        self.cellHeight = 50;
        self.page = 1;
    }
    return self;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.showEnptyView = YES;
        self.cellIdentifer = @"LNBaseTableViewCell";
        self.cellHeight = 50;
        self.page = 1;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BgColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 初始化tableView
    [self.view addSubview:self.tableView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_offset(0);
    }];
    
    // 注册tableView单元格
    [self.tableView registerClass:[LNBaseTableViewCell class] forCellReuseIdentifier:self.cellIdentifer];
    
    // 空视图
    if (self.showEnptyView == YES) {
        self.tableView.emptyDataSetSource = self.emptyDataSource;
        self.tableView.emptyDataType = EmptyDataTypeLoading;
    }
    // 加载数据
    self.page = 1;
    [self loadData:self.page];
}

#pragma mark - ---- 代理相关 ----
#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    LNBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifer];
    cell.indexPath = indexPath;
    if (indexPath.row < self.dataArray.count) {
        [cell setData:self.dataArray[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell did clikc");
}

#pragma mark - ---- 私有方法 ----
- (void)endRefrish {
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (self.showEnptyView) {
        if (self.dataArray.count == 0) {
            self.tableView.emptyDataType = EmptyDataTypeList;
            [self.tableView reloadEmptyDataSet];
        }else {
            [self.tableView removeEmptyDataSet];
        }
    }
}

#pragma mark - --- getters 和 setters ----
- (UITableView *)tableView {

    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorColor = HEXCOLOR(0xE6E6E6);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 1;
            [self loadData:self.page];
        }];
//        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            self.page ++;
//            [self loadData];
//        }];
    }
    return _tableView;
}


- (NSMutableArray *)dataArray {

    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (EmptyDataSource *)emptyDataSource{
    if (!_emptyDataSource) {
        _emptyDataSource = [[EmptyDataSource alloc] init];
    }
    return _emptyDataSource;
}


- (void)setCellNibName:(NSString *)cellNibName {
    _cellNibName = cellNibName;
    if ([_cellIdentifer isEqualToString:@"LNBaseTableViewCell"]) {
        _cellIdentifer = cellNibName;
    }
    if ([self.cellIdentifer isEqualToString:@"LNBaseTableViewCell"]) {
        self.cellIdentifer = self.cellNibName;
        [self.tableView registerNib:[UINib nibWithNibName:self.cellNibName bundle:nil] forCellReuseIdentifier:self.cellIdentifer];
    }else {
        [self.tableView registerNib:[UINib nibWithNibName:self.cellNibName bundle:nil] forCellReuseIdentifier:self.cellIdentifer];
    }
}
- (void)setCellIdentifer:(NSString *)cellIdentifer {
    _cellIdentifer = cellIdentifer;
    if (self.cellNibName) {
        [self.tableView registerNib:[UINib nibWithNibName:self.cellNibName bundle:nil] forCellReuseIdentifier:self.cellIdentifer];
    }
}

#pragma mark - 开放函数
/**
 加载数据，子类需要复写
 
 @param page page description
 */
- (void)loadData:(NSInteger)page {
    if (page == 1) {
        [self.dataArray removeAllObjects];
    }
    [self.dataArray addObject:@""];
    [self.dataArray addObject:@""];
    [self.dataArray addObject:@""];
    [self.dataArray addObject:@""];
    [self.tableView reloadData];
    [self checkEmptyViewStatus];
    [self endRefrish];
}

/**
 加载网络数据
 @param url 请求的链接
 @param params 请求参数
 @param success 请求成功后的反馈数据
 */
- (void)loadDataWithUrl:(NSString *)url params:(NSDictionary *)params success:(SuccessBlock)success fail:(FailedBlock)fail {
    if (self.showEnptyView == YES && _dataArray == nil) {
        [self.tableView reloadEmptyDataSet];
    }
    __weak typeof(self) weakSelf = self;
    LNBaseTableViewAPI *api = [[LNBaseTableViewAPI alloc] initWithUrl:url parameters:params];
    [api startWithBlockSuccess:^(__kindof LCBaseRequest *request) {
        
        NSLog(@"%@", url);
        NSLog(@"%@", request.responseJSONObject);
        
        // 反馈数据
        if ([[request.responseJSONObject objectForKey:@"code"] isEqualToString:@"success"]) {
            [self.dataArray removeAllObjects];
            success(request.responseJSONObject);
        }else {
            if ([request.responseJSONObject objectForKey:@"msg"]) {
                fail([request.responseJSONObject objectForKey:@"msg"]);
            }else if ([request.responseJSONObject objectForKey:@"info"]) {
                fail([request.responseJSONObject objectForKey:@"info"]);
            }else {
                fail(@"数据出错");
            }
        }
        [self endRefrish];
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        [weakSelf endRefrish];
        weakSelf.tableView.emptyDataType = EmptyDataTypeConnectError;
        [weakSelf.tableView reloadEmptyDataSet];
        fail(error.domain);
    }];
}

/**
 监测空视图状态
 */
- (void)checkEmptyViewStatus {
    
    if (self.showEnptyView == YES) {
        if (self.dataArray.count == 0) {
            // 设置空视图
            self.tableView.emptyDataType = EmptyDataTypeList;
            [self.tableView reloadEmptyDataSet];
        } else {
            // 移除空试图
            [self.tableView removeEmptyDataSet];
        }
    }
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

@end
