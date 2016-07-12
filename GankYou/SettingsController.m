//
//  SettingsController.m
//  GankYou
//
//  Created by Tang Qi on 7/12/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "SettingsController.h"
#import "PodsController.h"
#import "GankModel.h"

@interface SettingsController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataSource;

@end

static NSString *const kCellHasSwitchID = @"HasSwitchCell";
static NSString *const kCellHasDIID = @"HasDICell"; // DI -> DisclosureIndicator
static NSString *const kCellHasSecondLabelID = @"HasSecondLabelCell";
static NSString *const kCellLogOutID = @"LogOutCell";

@implementation SettingsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1. 不行
    self.navigationController.navigationBar.hidden = NO;
    // 2. 得用以下两种方式之一
    //    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"设置";
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    // 不显示空 cell
    _tableView.tableFooterView = [[UIView alloc] init];
    // 设置行高
    _tableView.rowHeight = 44;
    _tableView.sectionFooterHeight = 0;
    _tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellHasSwitchID];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellHasDIID];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellHasSecondLabelID];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellLogOutID];
    
    [self.view addSubview:_tableView];
    
    self.dataSource = @[ @[ @"夜间模式切换" ], @[ @"清除缓存" ], @[ @"去评分", @"源代码", @"开源库", @"版本号" ], @[ @"退出当前账号" ]];
}

- (void)dealloc {
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    [self.tableView removeFromSuperview];
    self.tableView = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showTabBar:self.tabBarController];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rowsData = self.dataSource[section];
    return rowsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID;
    
    switch (indexPath.section) {
        case 0:
            cellID = kCellHasSwitchID;
            break;
        case 1:
            cellID = kCellHasSecondLabelID;
            break;
        case 2: {
            if (indexPath.row < 3) {
                cellID = kCellHasDIID;
            } else {
                cellID = kCellHasSecondLabelID;
            }
        } break;
        case 3:
            cellID = kCellLogOutID;
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        UISwitch *nightModeSwitch = [[UISwitch alloc] init];
        cell.accessoryView = nightModeSwitch;
    } else if (indexPath.section == 1) {
        UILabel *cacheLabel = [UILabel new];
        NSString *cache = [self getCacheSizeStr];
        cacheLabel.text = cache;
        [cacheLabel sizeToFit];
        cell.accessoryView = cacheLabel;
    } else if (indexPath.section == 2 && indexPath.row == 3) {
        UILabel *versionLabel = [UILabel new];
        NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        versionLabel.text = version;
        [versionLabel sizeToFit];
        cell.accessoryView = versionLabel;
    } else if (indexPath.section == 3) {
        // 退出当前账号
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = kColorMain;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
    } else if (indexPath.section == 1) {
        [self showCleanAlert];
    } else if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                
                break;
            case 1:
                
                break;
            case 2: {
                PodsController *podsVC = [[PodsController alloc] init];
                [self.navigationController pushViewController:podsVC animated:YES];
                [self hideTabBar:self.tabBarController];
                break;
            }
            default:
                
                break;
        }
        
    } else if (indexPath.section == 3) {
        
    }
    // 还原 TableView 选中状态
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (NSString *)getCacheSizeStr {
    float cacheSize = [[SDImageCache sharedImageCache] getSize] / 1024 /1024;
    NSString *clearCacheSizeStr;
    if(cacheSize >= 1){
        clearCacheSizeStr = [NSString stringWithFormat:@"%.1fM",cacheSize];
    }else{
        clearCacheSizeStr = [NSString stringWithFormat:@"%.1fK",cacheSize * 1024];
    }
    DebugLog(@"图片缓存大小:%@",clearCacheSizeStr);
    return clearCacheSizeStr;
}

- (void)showCleanAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"缓存清除" message:@"确定要清除图片缓存吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionSure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        DebugLog(@"确认");
        [self cleanCache];
    }];
    
    UIAlertAction *actionCancle= [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        DebugLog(@"取消");
    }];
    
    [alert addAction:actionSure];
    [alert addAction:actionCancle];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)cleanCache {
    // 清除缓存
    [[SDImageCache sharedImageCache] clearDisk];
    // 提示
    [self showHUDWithText:@"清楚完毕"];
    
    [self.tableView reloadData];
}

@end
