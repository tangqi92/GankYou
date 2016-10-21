//
//  MeizhiDetailViewController.m
//  GankYou
//
//  Created by Tang Qi on 7/2/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "GankModel.h"
#import "MeizhiDetailViewController.h"
#import "MeizhiHUD.h"

@interface MeizhiDetailViewController () <UIGestureRecognizerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) GankModel *gankModel;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MeizhiDetailViewController

#pragma mark - Constructors

- (instancetype)initWithMeizhi:(GankModel *)gankModel {
    self = [super init];
    if (self) {
        self.gankModel = gankModel;
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // 右划手势返回
    self.navigationController.interactivePopGestureRecognizer.delegate = self;

    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];

    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_gankModel.url] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
    }];
    [_scrollView addSubview:_imageView];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    CGFloat offsetY = scrollView.contentOffset.y;
    // 该判断是实现scrollView内部的子控件悬停效果
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    // setup a list of preview actions
    UIPreviewAction *actionLike = [UIPreviewAction
                                actionWithTitle:@"喜欢"
                                style:UIPreviewActionStyleDefault
                                handler:^(UIPreviewAction *_Nonnull action,
                                          UIViewController *_Nonnull previewViewController) {
                                    [MeizhiHUD popupErrorMessage:@"Not yet~"];
                                }];
    
    UIPreviewAction *actionCollection = [UIPreviewAction
                                actionWithTitle:@"收藏"
                                style:UIPreviewActionStyleDefault
                                handler:^(UIPreviewAction *_Nonnull action,
                                          UIViewController *_Nonnull previewViewController) {
                                    [MeizhiHUD popupErrorMessage:@"Not yet~"];
                                }];
    
    UIPreviewAction *actionSave = [UIPreviewAction
                                actionWithTitle:@"保存"
                                style:UIPreviewActionStyleDefault
                                handler:^(UIPreviewAction *_Nonnull action,
                                          UIViewController *_Nonnull previewViewController) {
                                    [MeizhiHUD popupErrorMessage:@"Not yet~"];
                                }];
    
    NSArray *actions = @[ actionLike, actionCollection, actionSave ];
    return actions;
}

@end
