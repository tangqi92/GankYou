//
//  MeizhiViewController.m
//  GankYou
//
//  Created by Tang Qi on 7/2/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "GankNetAPIManager.h"
#import "MeizhiCCell.h"
#import "MeizhiDetailViewController.h"
#import "MeizhiViewController.h"
#import "ZOZolaZoomTransition.h"
#import "MineViewController.h"
#import <CHTCollectionViewWaterfallLayout.h>
#import "MeizhiPhotoBrowser.h"

static const NSInteger kPageSize = 10;

@interface MeizhiViewController () <UICollectionViewDataSource, UINavigationControllerDelegate, ZOZolaZoomTransitionDelegate, CHTCollectionViewDelegateWaterfallLayout, UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MeizhiCCell *selectedCell;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) MeizhiDetailViewController *currentPreviewController;

@end

@implementation MeizhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CHTCollectionViewWaterfallLayout *waterFallLayout = [[CHTCollectionViewWaterfallLayout alloc] init];
    // 设置边距
    waterFallLayout.minimumInteritemSpacing = 10;
    waterFallLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:waterFallLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = kColorMainBG;
    [self.collectionView registerClass:[MeizhiCCell class] forCellWithReuseIdentifier:kCCellIdentifier_MeizhiCCell];
    [self.view addSubview:self.collectionView];

    self.navigationController.delegate = self;
    
    //Register 3D touch event - sourceView 为 self.view 所以不需要在 cellForItemAtIndexPath 重复注册，否则会导致运行卡顿
    if ([self respondsToSelector:@selector(traitCollection)]) {
        if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
            if (self.traitCollection.forceTouchCapability==UIForceTouchCapabilityAvailable) {
                [self registerForPreviewingWithDelegate:self
                                             sourceView:self.view];
            }
        }
    }

    [self initRefresh];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showTabBar:self.tabBarController];
    // TODO: 刷新数据
}

- (void)initRefresh {
    //    // 似乎下面并没有产生循环引用
    //    __weak __typeof(self) weakSelf = self;
    // 下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 1;
        [[GankNetAPIManager sharedManager] request_GankData_WithType:@"福利" pageSize:kPageSize pageIndex:_pageIndex success:^(NSDictionary *dic) {
            _pageIndex++;
            // 字典转模型
            NSMutableArray *dataArray = [GankModel mj_objectArrayWithKeyValuesArray:dic[@"results"]];
            self.dataSource = [NSMutableArray array];
            for (GankModel *gank in dataArray) {
                [self.dataSource insertObject:gank atIndex:self.dataSource.count];
            }
            // !!!: 刷新表格
            [self.collectionView reloadData];
            // 结束刷新
            [self.collectionView.mj_header endRefreshing];
        }
            failure:^(NSError *error) {
                // 结束刷新
                [self.collectionView.mj_header endRefreshing];
            }];
    }];

    [self.collectionView.mj_header beginRefreshing];

    // 上拉加载
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [[GankNetAPIManager sharedManager] request_GankData_WithType:@"福利" pageSize:kPageSize pageIndex:_pageIndex success:^(NSDictionary *dic) {
            _pageIndex++;
            // 字典转模型
            NSMutableArray *dataArray = [GankModel mj_objectArrayWithKeyValuesArray:dic[@"results"]];
            for (GankModel *gank in dataArray) {
                [self.dataSource addObject:gank];
            }
            [self.collectionView reloadData];
            // 结束刷新
            [self.collectionView.mj_footer endRefreshing];
        }
            failure:^(NSError *error) {
                // 结束刷新
                [self.collectionView.mj_footer endRefreshing];
            }];
    }];
    // 默认先隐藏 footer
    self.collectionView.mj_footer.hidden = YES;
}

#pragma mark - UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // 设置尾部控件的显示和隐藏
    self.collectionView.mj_footer.hidden = self.dataSource.count == 0;
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MeizhiCCell *cell = (MeizhiCCell *) [collectionView dequeueReusableCellWithReuseIdentifier:kCCellIdentifier_MeizhiCCell forIndexPath:indexPath];
    GankModel *gank = [self.dataSource objectAtIndex:indexPath.row];

    // 1.
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:gank.url] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (image) {
//            if (!CGSizeEqualToSize(gank.imageSize, image.size)) {
//                gank.imageSize = image.size;
//                // !!!: 一定要刷新
//                [collectionView reloadItemsAtIndexPaths:@[ indexPath ]];
//            }
//        }
//    }];

    //    // 2.
    [cell setGankModel:gank withCompleted:^{
        [collectionView reloadItemsAtIndexPaths:@[ indexPath ]];
    }];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // !!!: 必须有这一句，为了下面 UINavigationControllerDelegate
    self.selectedCell = (MeizhiCCell *) [collectionView cellForItemAtIndexPath:indexPath];
    GankModel *gank = [self.dataSource objectAtIndex:indexPath.row];
    [MeizhiPhotoBrowser browserPhotoWithURL:[NSURL URLWithString:gank.url] fromView:self.selectedCell];
//    MeizhiDetailViewController *detailController = [[MeizhiDetailViewController alloc] initWithMeizhi:gank];
//    [self.navigationController pushViewController:detailController animated:YES];
//    [self hideTabBar:self.tabBarController];
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    GankModel *gank = [self.dataSource objectAtIndex:indexPath.row];

    if (!CGSizeEqualToSize(gank.imageSize, CGSizeZero)) {
        return gank.imageSize;
    }
    return CGSizeMake(150, 200);
}

#pragma mark - UINavigationControllerDelegate Methods

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    // Sanity
    if (fromVC != self && toVC != self) return nil;

    // Determine if we're presenting or dismissing
    ZOTransitionType type = (fromVC == self) ? ZOTransitionTypePresenting : ZOTransitionTypeDismissing;

    // Create a transition instance with the selected cell's imageView as the target view
    ZOZolaZoomTransition *zoomTransition = [ZOZolaZoomTransition transitionFromView:_selectedCell.imageView
                                                                               type:type
                                                                           duration:0.5
                                                                           delegate:self];
    zoomTransition.fadeColor = self.collectionView.backgroundColor;

    return zoomTransition;
}

#pragma mark - ZOZolaZoomTransitionDelegate Methods

- (CGRect)zolaZoomTransition:(ZOZolaZoomTransition *)zoomTransition
        startingFrameForView:(UIView *)targetView
              relativeToView:(UIView *)relativeView
          fromViewController:(UIViewController *)fromViewController
            toViewController:(UIViewController *)toViewController {

    if (fromViewController == self) {
        // We're pushing to the detail controller. The starting frame is taken from the selected cell's imageView.
        return [_selectedCell.imageView convertRect:_selectedCell.imageView.bounds toView:relativeView];
    } else if ([fromViewController isKindOfClass:[MeizhiDetailViewController class]]) {
        // We're popping back to this master controller. The starting frame is taken from the detailController's imageView.
        MeizhiDetailViewController *detailController = (MeizhiDetailViewController *) fromViewController;
        return [detailController.imageView convertRect:detailController.imageView.bounds toView:relativeView];
    }

    return CGRectZero;
}

- (CGRect)zolaZoomTransition:(ZOZolaZoomTransition *)zoomTransition
       finishingFrameForView:(UIView *)targetView
              relativeToView:(UIView *)relativeView
          fromViewController:(UIViewController *)fromViewComtroller
            toViewController:(UIViewController *)toViewController {

    if (fromViewComtroller == self) {
        // We're pushing to the detail controller. The finishing frame is taken from the detailController's imageView.
        MeizhiDetailViewController *detailController = (MeizhiDetailViewController *) toViewController;
        return [detailController.imageView convertRect:detailController.imageView.bounds toView:relativeView];
    } else if ([fromViewComtroller isKindOfClass:[MeizhiDetailViewController class]]) {
        // We're popping back to this master controller. The finishing frame is taken from the selected cell's imageView.
        return [_selectedCell.imageView convertRect:_selectedCell.imageView.bounds toView:relativeView];
    }

    return CGRectZero;
}

- (NSArray *)supplementaryViewsForZolaZoomTransition:(ZOZolaZoomTransition *)zoomTransition {
    // Here we're returning all UICollectionViewCells that are clipped by the edge
    // of the screen. These will be used as "supplementary views" so that the clipped
    // cells will be drawn in their entirety rather than appearing cut off during the
    // transition animation.

    NSMutableArray *clippedCells = [NSMutableArray arrayWithCapacity:[[self.collectionView visibleCells] count]];
    for (UICollectionViewCell *visibleCell in self.collectionView.visibleCells) {
        CGRect convertedRect = [visibleCell convertRect:visibleCell.bounds toView:self.view];
        if (!CGRectContainsRect(self.view.frame, convertedRect)) {
            [clippedCells addObject:visibleCell];
        }
    }
    return clippedCells;
}

- (CGRect)zolaZoomTransition:(ZOZolaZoomTransition *)zoomTransition
   frameForSupplementaryView:(UIView *)supplementaryView
              relativeToView:(UIView *)relativeView {

    return [supplementaryView convertRect:supplementaryView.bounds toView:relativeView];
}

#pragma UIViewControllerPreviewingDelegate methods - Peek
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    if ([self.presentedViewController isKindOfClass:[MeizhiDetailViewController class]]) {
        return nil;
    }else{
        // http://stackoverflow.com/questions/33002637/3d-touch-peek-and-pop-from-uitableviewcell-how-to-hand-over-data-to-other-uiview
        CGPoint cellPostion = [self.collectionView convertPoint:location fromView:self.view];
        NSIndexPath *indexPath = [self.collectionView
                                  indexPathForItemAtPoint:cellPostion];
        GankModel *gank = self.dataSource[indexPath.row];
        self.currentPreviewController = [[MeizhiDetailViewController alloc] initWithMeizhi:gank];
        return self.currentPreviewController;
    }
}

//Pop
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self.navigationController pushViewController:self.currentPreviewController animated:YES];
    [self hideTabBar:self.tabBarController];
}

@end
