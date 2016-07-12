//
//  GankTableViewController.m
//  GankYou
//
//  Created by Tang Qi on 7/12/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "GankCell.h"
#import "GankModel.h"
#import "GankNetAPIManager.h"
#import "GankTableViewController.h"
#import "GankWebViewController.h"

// 每页加载的大小
static const NSInteger kPageSize = 10;
// 标记，防止网络不好既上拉又下拉，照成数据混乱，以最后一次为主
static NSInteger flag = 0;

@interface GankTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation GankTableViewController

/**
 *  懒加载
 */
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化控件
    [self initViews];
    // 初始化刷新
    [self initRefresh];
}

- (void)initViews {
    // Tableview 实际高度（显示内容）
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView registerClass:[GankCell class] forCellReuseIdentifier:kCellIdentifier_GankCell];

    // 设置高度自适应：iOS 8.0
    _tableView.estimatedRowHeight = 70;
    _tableView.rowHeight = UITableViewAutomaticDimension;

    [self.view addSubview:_tableView];
}

/**
 *  初始化刷新
 */
- (void)initRefresh {

    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewGanks)];
    // !!!: 刷新下
    [self.tableView.mj_header beginRefreshing];
    // 上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreGanks)];

    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = NO;
    [self.tableView.mj_footer setHidden:YES];
}

/**
 *  获取数据
 *
 *  @param pageSize  每页大小
 *  @param pageIndex 第几页
 */
- (void)loadNewGanks {
    _pageIndex = 1;
    flag = 0;
    [[GankNetAPIManager sharedManager] request_GankData_WithType:_gankDataType pageSize:kPageSize pageIndex:_pageIndex success:^(NSDictionary *dic) {
        if (flag == 1) {
            return;
        }

        _pageIndex++;

        // 字典转模型
        self.dataSource = [GankModel mj_objectArrayWithKeyValuesArray:dic[@"results"]];

        DebugLog(@"loadNewDatas: %@", self.dataSource);

        if (self.dataSource.count > 0) {
            [self.tableView.mj_footer setHidden:NO];
            [self.tableView reloadData];
        }

        // 结束刷新
        [self.tableView.mj_header endRefreshing];

    }
        failure:^(NSError *error) {
            DebugLog(@"loadNewDatas 失败：%@", error);
            // 结束刷新
            [self.tableView.mj_header endRefreshing];
        }];
}

- (void)loadMoreGanks {
    flag = 1;
    [[GankNetAPIManager sharedManager] request_GankData_WithType:_gankDataType pageSize:kPageSize pageIndex:_pageIndex success:^(NSDictionary *dic) {
        if (flag == 0) {
            return;
        }
        // 页码 +1
        _pageIndex++;

        // 字典转模型
        NSMutableArray *newDatas = [GankModel mj_objectArrayWithKeyValuesArray:dic[@"results"]];

        DebugLog(@"loadMoreGanks: %@", newDatas);

        // 判断新的数据和旧的数据有没有一样的
        GankModel *gankModel;
        GankModel *gankModelNew;
        for (int i = 0; i < self.dataSource.count; i++) {
            gankModel = self.dataSource[i];
            for (int j = 0; j < newDatas.count; j++) {
                gankModelNew = newDatas[j];
                if ([gankModelNew._id isEqualToString:gankModel._id]) {
                    DebugLog(@"移除：%@", gankModelNew.desc);
                    //移除出集合
                    [newDatas removeObjectAtIndex:j];
                }
            }
        }

        if (newDatas != nil && newDatas.count > 0) {
            // 把请求的数组放到当前类别的数组集合中去
            [self.dataSource addObjectsFromArray:newDatas];
            [self.tableView reloadData];
        }
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    }
        failure:^(NSError *error) {
            DebugLog(@"loadMoreGanks 失败：%@", error);
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
        }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // iOS 8
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 获取Cell
    GankCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_GankCell];
    // 传递数据
    cell.gankModel = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 取消选中
    GankModel *gankModel = self.dataSource[indexPath.row];

    DebugLog(@"gankURL: %@", gankModel.url);

    GankWebViewController *webViewVC = [[GankWebViewController alloc] init];
    webViewVC.gankURL = gankModel.url;
    webViewVC.gankTitle = gankModel.desc;
    [self hideTabBar:self.tabBarController];
    [self.navigationController pushViewController:webViewVC animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showTabBar:self.tabBarController];
    // ???: 是否需要调用 reload
}

@end
