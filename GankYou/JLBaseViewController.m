//
//  JLTableViewController.m
//  设置页面的封装
//
//  Created by 袁俊亮 on 16/4/11.
//  Copyright © 2016年 豹修. All rights reserved.
//

#import "JLBaseViewController.h"
#import "UIScrollView+PullBig.h"
#import "SettingsController.h"

@interface JLBaseViewController ()

@property (nonatomic, strong) UIImageView *topView;

@end

@implementation JLBaseViewController

#pragma mark - 懒加载

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

// 重写一下三个方法是为了保证无论外界如何调用，都创建的是分组样式
- (instancetype)init {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)awakeFromNib {
    [super initWithStyle:UITableViewStyleGrouped];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    [self setTopView];
    // 状态栏关键
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)setNavigation {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showTabBar:self.tabBarController];
}

/**
 *  通过监听 contentOffset
 */
- (void)setTopView {
    UIImageView *topView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_head_view"]];
    topView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height * 0.35);
    topView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView setBigView:topView withHeaderView:nil];
    
    self.topView = topView;
    
    // 获取最新的图片替换
    UIImage *localImage = [UIImage imageNamed:@"topImage.png"];
    if (localImage != nil) {
        self.topView.image = localImage;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 先取出对应组的小数组
    JLSettingGroup *group = self.dataSource[section];
    // 返回小数组的长度
    return group.items.count;  
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1. 创建 cell
    SettingsCell *cell = [SettingsCell cellWithTableView:tableView];
    
    // 2. 先取出对应组的组模型
    JLSettingGroup *group = self.dataSource[indexPath.section];
    // 3. 从组模型中取出对应行的模型
    JLSettingItem *item = group.items[indexPath.row];
    // 4. 进行复制
    cell.item = item;
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // 立即取消选中
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 先取出对应组的组模型
    JLSettingGroup *group = self.dataSource[indexPath.section];
    // 从组模型中取出对应行的模型
    JLSettingItem *item = group.items[indexPath.row];
    // 判断block是否保存了代码
    if (item.option != nil) {
        // 保存了代码，就执行block中保存的代码
        item.option();
    }else if ([item isKindOfClass:[JLSettingArrowItem class]]) {
        // 创建目标控制器并且添加到栈中
        JLSettingArrowItem *arrowItem = (JLSettingArrowItem *)item;
        UIViewController *vc = [[arrowItem.destVcClass alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                // TODO:
                break;
            case 1:
                // TODO:
                break;
        }
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [self hideTabBar:self.tabBarController];
                [self pushToAboutPage];
                break;
        }
    }
    // 还原 TableView 选中状态
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

// 添加头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // 先取出对应组的组模型
    JLSettingGroup *group = self.dataSource[section];
    return group.headerTitle;
}

// 底部标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    // 先取出对应的组模型
    JLSettingGroup *group = self.dataSource[section];
    return group.footerTitle;
}

-(void)pushToAboutPage {
    SettingsController *settingsVC = [[SettingsController alloc] init];
    [self.navigationController pushViewController:settingsVC animated:YES];
}

- (void)hideTabBar:(UITabBarController *)tabbarcontroller {
    [UIView beginAnimations:nil context:NULL];
    for (UIView *view in tabbarcontroller.view.subviews) {
        if ([view isKindOfClass:[UITabBar class]]) {
            [view setFrame:CGRectMake(view.frame.origin.x, kScreen_Height, view.frame.size.width, view.frame.size.height)];
        } else {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, kScreen_Height)];
        }
    }
    [UIView commitAnimations];
}

- (void)showTabBar:(UITabBarController *)tabbarcontroller {
    [UIView beginAnimations:nil context:NULL];
    for (UIView *view in tabbarcontroller.view.subviews) {
        if ([view isKindOfClass:[UITabBar class]]) {
            [view setFrame:CGRectMake(view.frame.origin.x, kScreen_Height - view.frame.size.height, view.frame.size.width, view.frame.size.height)];
        } else {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, kScreen_Height - view.frame.size.height)];
        }
    }
    [UIView commitAnimations];
}

@end
