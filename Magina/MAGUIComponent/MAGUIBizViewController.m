//
//  MAGUIBizViewController.m
//  Magina
//
//  Created by liujinze on 2020/10/26.
//

#import "MAGUIBizViewController.h"
//base import
#import "MAGUIConfigCenter.h"
#import "UIDevice+MAGAdapt.h"
#import <Masonry/Masonry.h>
//横滑collection
#import "HorizontalCollectionViewController.h"

@interface MAGUIBizViewController ()

@property (nonatomic, strong) UIButton *scrollBannerButton;//横向滑动的collectionView
@property (nonatomic, strong) UIButton *halfScreenButton;//展示半屏面板
@property (nonatomic, strong) UIButton *alertButton;//确认视图
@property (nonatomic, strong) UIButton *alertTextButton;//带输入功能的确认视图
@property (nonatomic, strong) UIButton *loadingButton;//展示loading
@property (nonatomic, strong) UIButton *toastButton;//展示toast

@end

@implementation MAGUIBizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat buttonWidth = (kScreenWidth - 40 )/ 3; //一排三个 左右间隔10
    CGFloat topOffSet = self.navigationController.navigationBar.frame.size.height + [UIDevice safeAreaTopInset] + 20;//导航栏高度+buffer
    
    //第一排
    [self.view addSubview:self.scrollBannerButton];
    [self.view addSubview:self.halfScreenButton];
    [self.view addSubview:self.alertButton];
    [self.scrollBannerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonWidth));
        make.top.equalTo(self.view).offset(topOffSet);
        make.left.equalTo(self.view).offset(10);
    }];
    [self.halfScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonWidth));
        make.top.equalTo(self.scrollBannerButton);
        make.left.equalTo(self.scrollBannerButton.mas_right).offset(10);
    }];
    [self.alertButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonWidth));
        make.top.equalTo(self.scrollBannerButton);
        make.left.equalTo(self.halfScreenButton.mas_right).offset(10);
    }];
    
    //第二排
    [self.view addSubview:self.alertTextButton];
    [self.view addSubview:self.loadingButton];
    [self.view addSubview:self.toastButton];
    [self.alertTextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonWidth));
        make.top.equalTo(self.scrollBannerButton.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
    }];
    [self.loadingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonWidth));
        make.top.equalTo(self.alertTextButton);
        make.left.equalTo(self.alertTextButton.mas_right).offset(10);
    }];
    [self.toastButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonWidth));
        make.top.equalTo(self.alertTextButton);
        make.left.equalTo(self.loadingButton.mas_right).offset(10);
    }];
}

#pragma mark - action

- (void)scrollBannerButtonClicked{
    HorizontalCollectionViewController *horizontalVC = [[HorizontalCollectionViewController alloc] init];
    horizontalVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:horizontalVC animated:YES completion:nil];
}

- (void)halfScreenButtonClicked{
    
}

- (void)alertButtonClicked{
    
}
- (void)alertTextButtonClicked{
    
}
- (void)toastButtonClicked{
    
}
- (void)loadingButtonClicked{
    
}
#pragma mark - getter

- (UIButton *)scrollBannerButton
{
    if (!_scrollBannerButton) {
        _scrollBannerButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _scrollBannerButton.backgroundColor = [UIColor greenColor];
        _scrollBannerButton.titleLabel.numberOfLines = 2;
        [_scrollBannerButton setTitle:@"横滑collection" forState:UIControlStateNormal];
        [_scrollBannerButton addTarget:self action:@selector(scrollBannerButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scrollBannerButton;
}

- (UIButton *)halfScreenButton
{
    if (!_halfScreenButton) {
        _halfScreenButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _halfScreenButton.backgroundColor = [UIColor grayColor];
        _halfScreenButton.titleLabel.numberOfLines = 2;
        [_halfScreenButton setTitle:@"半屏面板(未开发)" forState:UIControlStateNormal];
        [_halfScreenButton addTarget:self action:@selector(halfScreenButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _halfScreenButton;
}

- (UIButton *)alertButton{
    if (!_alertButton) {
        _alertButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _alertButton.backgroundColor = [UIColor grayColor];
        _alertButton.titleLabel.numberOfLines = 2;
        [_alertButton setTitle:@"确认框(未开发)" forState:UIControlStateNormal];
        [_alertButton addTarget:self action:@selector(alertButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _alertButton;
}

- (UIButton *)alertTextButton{
    if (!_alertTextButton) {
        _alertTextButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _alertTextButton.backgroundColor = [UIColor grayColor];
        _alertTextButton.titleLabel.numberOfLines = 2;
        [_alertTextButton setTitle:@"输入确认框(未开发)" forState:UIControlStateNormal];
        [_alertTextButton addTarget:self action:@selector(alertTextButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _alertTextButton;
}

- (UIButton *)toastButton{
    if (!_toastButton) {
        _toastButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _toastButton.backgroundColor = [UIColor grayColor];
        _toastButton.titleLabel.numberOfLines = 2;
        [_toastButton setTitle:@"提示视图(未开发)" forState:UIControlStateNormal];
        [_toastButton addTarget:self action:@selector(toastButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _toastButton;
}

- (UIButton *)loadingButton{
    if (!_loadingButton) {
        _loadingButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _loadingButton.backgroundColor = [UIColor grayColor];
        _loadingButton.titleLabel.numberOfLines = 2;
        [_loadingButton setTitle:@"加载视图" forState:UIControlStateNormal];
        [_loadingButton addTarget:self action:@selector(loadingButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loadingButton;
}
@end
