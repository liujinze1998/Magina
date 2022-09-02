//
//  MAGFeedViewController.m
//  Magina
//

/*
 UINavigationItem
 UIButton UILabel
 */

//  Created by liujinze on 2020/10/26.
//

#import "MAGFeedViewController.h"
#import "MAGScanViewController.h"
#import "HorizontalCollectionViewController.h"
#import "MAGDeviceAuth.h"
#import "MAGUIConfigCenter.h"
#import "UIDevice+MAGAdapt.h"
#import <Masonry/Masonry.h>
#import <AVFoundation/AVFoundation.h>

@interface MAGFeedViewController ()

@property (nonatomic, strong) UIButton *scanButton;//打开扫一扫
@property (nonatomic, strong) UIButton *albumButton;//打开IGList相册
@property (nonatomic, strong) UIButton *transGifButton;//视频转gif
@property (nonatomic, strong) UIButton *scrollBannerButton;//横向滑动的collectionView
@property (nonatomic, strong) UIButton *noname2Button;//待定

@end

@implementation MAGFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFunctionUI];
}

#pragma setup UI


- (void)setFunctionUI
{
    CGFloat buttonWidth = (kScreenWidth - 40 )/ 3; //一排三个 左右间隔10
    CGFloat topOffSet = self.navigationController.navigationBar.frame.size.height + [UIDevice safeAreaTopInset] + 20;//导航栏高度+buffer
    
    self.albumButton = [[UIButton alloc] initWithFrame:CGRectZero];
    self.albumButton.backgroundColor = [UIColor grayColor];
    [self.albumButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];//让titleLabel左右局中
    [self.albumButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];//让titleLabel上下局中 这来都是默认 所以后面不用设置
    self.albumButton.titleLabel.numberOfLines = 2;
    self.albumButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;//设置lineBreakMode支持换行
    //setTitleEdgeInsets setImageEdgeInsets 设置image与title的相对边距可以实现同时显示，需要ContentHorizontalAlignment属性支持
    [self.albumButton setTitle:@"collection\n相册(未开发)" forState:UIControlStateNormal];
    [self.albumButton addTarget:self action:@selector(albumButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.albumButton];
    
    self.transGifButton = [[UIButton alloc] initWithFrame:CGRectZero];
    self.transGifButton.backgroundColor = [UIColor grayColor];
    self.transGifButton.titleLabel.numberOfLines = 2;
    [self.transGifButton setTitle:@"视频转gif(未开发)" forState:UIControlStateNormal];
    [self.transGifButton addTarget:self action:@selector(transGifButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.transGifButton];
    
    self.scrollBannerButton = [[UIButton alloc] initWithFrame:CGRectZero];
    self.scrollBannerButton.backgroundColor = [UIColor grayColor];
    self.scrollBannerButton.titleLabel.numberOfLines = 2;
    [self.scrollBannerButton setTitle:@"横滑collection" forState:UIControlStateNormal];
    [self.scrollBannerButton addTarget:self action:@selector(scrollBannerButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.scrollBannerButton];
    
    self.scanButton = [[UIButton alloc] initWithFrame:CGRectZero];
    self.scanButton.backgroundColor = [UIColor grayColor];
    self.scanButton.titleLabel.numberOfLines = 2;
    [self.scanButton setTitle:@"扫一扫" forState:UIControlStateNormal];
    [self.scanButton addTarget:self action:@selector(scanButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.scanButton];
    
    //第一排
    [self.albumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonWidth));
        make.top.equalTo(self.view).offset(topOffSet);
        make.left.equalTo(self.view).offset(10);
    }];
    
    [self.transGifButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonWidth));
        make.top.equalTo(self.albumButton);
        make.left.equalTo(self.albumButton.mas_right).offset(10);
    }];
    
    [self.scrollBannerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonWidth));
        make.top.equalTo(self.albumButton);
        make.left.equalTo(self.transGifButton.mas_right).offset(10);
    }];
    
    //第二排
    [self.scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonWidth));
        make.top.equalTo(self.albumButton.mas_bottom).offset(10);
        make.left.equalTo(self.albumButton);
    }];
    
}

#pragma mark - action

- (void)albumButtonClicked
{
    
}

- (void)transGifButtonClicked
{
    
}

-(void)scrollBannerButtonClicked{
    HorizontalCollectionViewController *horizontalVC = [[HorizontalCollectionViewController alloc] init];
    horizontalVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:horizontalVC animated:YES completion:nil];
}

- (void)scanButtonClicked
{
    if ([MAGDeviceAuth currentAuth] == AVAuthorizationStatusNotDetermined){
        __weak typeof(self) weakSelf = self;
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf scanButtonClickImpl];
            }
        }];
    } else if ([MAGDeviceAuth currentAuth] == AVAuthorizationStatusAuthorized){
        [self scanButtonClickImpl];
    } else {
        NSString *messageText = @"请在iPhone的“设置”-“隐私”-“相机”功能中，找到“Magina”打开相机访问权限";
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"相机无权限" message:messageText preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
}

- (void)scanButtonClickImpl{
    //打开扫码控制器
    dispatch_async(dispatch_get_main_queue(), ^{
        MAGScanViewController *scanVC = [[MAGScanViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:scanVC];
        navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:navigationController animated:YES completion:nil];
    });
}

#pragma mark - lazy init

@end
