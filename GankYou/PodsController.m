//
//  PodsController.m
//  GankYou
//
//  Created by Tang Qi on 7/12/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "PodsController.h"
#import "Pods.h"
#import "PodsCell.h"
#import "GankWebBroswer.h"

@interface PodsController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation PodsController

///**
// *  懒加载
// */
//- (NSMutableArray *)dataSource {
//    if(!_dataSource) {
//
//        _dataSource = [self data];
//
//    }
//    return _dataSource;
//}

- (void)generateData {
    NSMutableArray *data = [[NSMutableArray alloc] init];
    
    Pods *pod1 = [[Pods alloc] initWithName:@"AFNetworking" description:@"A delightful networking framework for iOS, OS X, watchOS, and tvOS." url:@"https://github.com/AFNetworking/AFNetworking"];
    Pods *pod2 = [[Pods alloc] initWithName:@"CHTCollectionViewWaterfallLayout" description:@"The waterfall (i.e., Pinterest-like) layout for UICollectionView." url:@"https://github.com/chiahsien/CHTCollectionViewWaterfallLayout"];
    Pods *pod3 = [[Pods alloc] initWithName:@"Masonry" description:@"Harness the power of AutoLayout NSLayoutConstraints with a simplified, chainable and expressive syntax. Supports iOS and OSX Auto Layout." url:@"https://github.com/SnapKit/Masonry"];
    Pods *pod4 = [[Pods alloc] initWithName:@"MJRefresh" description:@"An easy way to use pull-to-refresh." url:@"https://github.com/CoderMJLee/MJRefresh"];
    Pods *pod5 = [[Pods alloc] initWithName:@"MJExtension" description:@"A fast, convenient and nonintrusive conversion between JSON and model. Your model class don't need to extend another base class. You don't need to modify any model file." url:@"https://github.com/CoderMJLee/MJExtension"];
    Pods *pod6 = [[Pods alloc] initWithName:@"RDVTabBarController" description:@"Highly customizable tabBar and tabBarController for iOS." url:@"https://github.com/robbdimitrov/RDVTabBarController"];
    Pods *pod7 = [[Pods alloc] initWithName:@"SDWebImage" description:@"Asynchronous image downloader with cache support as a UIImageView category." url:@"https://github.com/rs/SDWebImage"];
    Pods *pod8 = [[Pods alloc] initWithName:@"SVProgressHUD" description:@"A clean and lightweight progress HUD for your iOS and tvOS app." url:@"https://github.com/SVProgressHUD/SVProgressHUD"];
    Pods *pod9 = [[Pods alloc] initWithName:@"WMPageController" description:@"An easy solution to page controllers like NetEase News." url:@"https://github.com/wangmchn/WMPageController"];
    Pods *pod10 = [[Pods alloc] initWithName:@"ZOZolaZoomTransition" description:@"Zoom transition that animates the entire view heirarchy. Used extensively in the Zola iOS application." url:@"https://github.com/NewAmsterdamLabs/ZOZolaZoomTransition"];
    
    [data addObject:pod1];
    [data addObject:pod2];
    [data addObject:pod3];
    [data addObject:pod4];
    [data addObject:pod5];
    [data addObject:pod6];
    [data addObject:pod7];
    [data addObject:pod8];
    [data addObject:pod9];
    [data addObject:pod10];
    
    _dataSource =  data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 初始化控件
    [self initViews];
    [self generateData];
}

- (void)initViews {
    // Tableview 实际高度（显示内容）
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView registerClass:[PodsCell class] forCellReuseIdentifier:kCellIdentifier_PodsCell];
    
    // 设置高度自适应：IOS 8.0
    _tableView.estimatedRowHeight = 64;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.view addSubview:_tableView];
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
    PodsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_PodsCell];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // 传递数据
    cell.pods = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    Pods *pods = self.dataSource[indexPath.row];
    [GankWebBroswer openWebWithURLString:pods.podsURL];
    [self hideTabBar:self.tabBarController];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // ???: 是否调用 reload
}

@end
