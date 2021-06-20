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
#import "MAGDeviceAuth.h"
#import "MAGUIConfigCenter.h"
#import "UIDevice+MAGAdapt.h"
#import <Masonry/Masonry.h>

@interface MAGFeedViewController ()

@property (nonatomic, strong) UIButton *scanButton;//打开扫一扫
@property (nonatomic, strong) UIButton *albumButton;//打开IGList相册
@property (nonatomic, strong) UIButton *transGifButton;//视频转gif
@property (nonatomic, strong) UIButton *noname1Button;//待定
@property (nonatomic, strong) UIButton *noname2Button;//待定

@end

@implementation MAGFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarUI];
    [self setFunctionUI];
}

#pragma setup UI

- (void)createNavBarUI
{
    self.scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.scanButton setImage:[UIImage imageNamed:@"scanButton"] forState:UIControlStateNormal];
    [self.scanButton addTarget:self action:@selector(scanButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.scanButton];
    [self.view addSubview:self.scanButton];
}

- (void)setFunctionUI
{
    CGFloat buttonWidth = (kScreenWidth - 40 )/ 3; //一排三个 左右间隔10
    CGFloat topOffSet = self.navigationController.navigationBar.frame.size.height + [UIDevice safeAreaTopInset] + 20;//导航栏高度+buffer
    
    self.albumButton = [[UIButton alloc] initWithFrame:CGRectZero];
    self.albumButton.backgroundColor = [UIColor greenColor];
    [self.albumButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];//让titleLabel左右局中
    [self.albumButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];//让titleLabel上下局中 这来都是默认 所以后面不用设置
    self.albumButton.titleLabel.numberOfLines = 2;
    self.albumButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;//设置lineBreakMode支持换行
    //setTitleEdgeInsets setImageEdgeInsets 设置image与title的相对边距可以实现同时显示，需要ContentHorizontalAlignment属性支持
    [self.albumButton setTitle:@"打开\n相册" forState:UIControlStateNormal];
    [self.albumButton addTarget:self action:@selector(albumButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.albumButton];
    
    self.transGifButton = [[UIButton alloc] initWithFrame:CGRectZero];
    self.transGifButton.backgroundColor = [UIColor greenColor];
    self.transGifButton.titleLabel.numberOfLines = 2;
    [self.transGifButton setTitle:@"视频\n转gif" forState:UIControlStateNormal];
    [self.transGifButton addTarget:self action:@selector(transGifButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.transGifButton];
    
    self.noname1Button = [[UIButton alloc] initWithFrame:CGRectZero];
    self.noname1Button.backgroundColor = [UIColor greenColor];
    self.noname1Button.titleLabel.numberOfLines = 2;
    [self.noname1Button setTitle:@"等待\n开发" forState:UIControlStateNormal];
    [self.noname1Button addTarget:self action:@selector(nonameButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.noname1Button];
    
    self.noname2Button = [[UIButton alloc] initWithFrame:CGRectZero];
    self.noname2Button.backgroundColor = [UIColor greenColor];
    self.noname2Button.titleLabel.numberOfLines = 2;
    [self.noname2Button setTitle:@"等待\n开发" forState:UIControlStateNormal];
    [self.noname2Button addTarget:self action:@selector(nonameButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.noname2Button];
    
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
    
    [self.noname1Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonWidth));
        make.top.equalTo(self.albumButton);
        make.left.equalTo(self.transGifButton.mas_right).offset(10);
    }];
    
    //第二排
    [self.noname2Button mas_makeConstraints:^(MASConstraintMaker *make) {
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

-(void)nonameButtonClicked{
    
}

- (void)scanButtonClicked
{
    if (![MAGDeviceAuth hasCameraAuth]) {
        NSString *messageText = @"请在iPhone的“设置”-“隐私”-“相机”功能中，找到“Magina”打开相机访问权限";
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"相机无权限" message:messageText preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    //打开扫码控制器
    MAGScanViewController *scanVC = [[MAGScanViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:scanVC];
    navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - lazy init

@end
