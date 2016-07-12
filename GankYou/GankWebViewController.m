//
//  GankWebViewController.m
//  GankYou
//
//  Created by Tang Qi on 7/12/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "GankWebViewController.h"
#import "HXWebView.h"

@interface GankWebViewController () <HXWebViewDelegate>

@property (nonatomic, strong) HXWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation GankWebViewController

// 创建 webView
- (HXWebView *)webView {
    if (!_webView) {
        // !!!: 这里不该用 magic number
        CGRect frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height - 64);
        _webView = [[HXWebView alloc] initWithFrame:frame];
        _webView.delegate = self;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    [self initWebView];
}

- (void)setNavigation {
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = self.title;
}

- (void)initWebView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.webView];
    
    [self initProgress];
    
    NSString *newUrl = self.gankURL;
    NSString *url = [newUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    DebugLog(@"%@", request);
    [self.webView loadRequest:request];
}

- (void)initProgress {
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, [UIScreen mainScreen].bounds.size.width, progressBarHeight);
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.frame = barFrame;
    self.progressView.backgroundColor = [UIColor clearColor];
    self.progressView.trackTintColor=[UIColor clearColor];
    self.progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.progressView setProgress:0 animated:NO];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    DebugLog(@"开始加载");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    DebugLog(@"结束加载");
    self.title = self.webView.title;
}

- (void)webView:(HXWebView *)webView updateProgress:(double)progress {
    if (progress >= 1.f) {
        [self.progressView setProgress:0.f animated:NO];
    } else {
        [self.progressView setProgress:progress animated:YES];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    DebugLog(@"加载出错：%@", error);
    [self showHUDWithText:@"啊呀~"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
    [self.navigationController.navigationBar bringSubviewToFront:_progressView];
    self.navigationController.navigationBar.clipsToBounds = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_progressView removeFromSuperview];
}

- (void)dealloc {
    
}

@end
