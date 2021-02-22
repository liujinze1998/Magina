//
//  MAGFeedViewController.m
//  Magina
//
//  Created by liujinze on 2020/10/26.
//

#import "MAGFeedViewController.h"
#import "MAGScanViewController.h"
#import "MAGDeviceAuth.h"

@interface MAGFeedViewController ()

@property (nonatomic, strong) UIButton *scanButton;//打开扫一扫

@end

@implementation MAGFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarUI];
    [self.view addSubview:self.scanButton];
}

#pragma setup UI



- (void)createNavBarUI
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.scanButton];
}

#pragma mark - action

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

- (UIButton *)scanButton
{
    if (!_scanButton) {
        _scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scanButton setImage:[UIImage imageNamed:@"scanButton"] forState:UIControlStateNormal];
        [_scanButton addTarget:self action:@selector(scanButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanButton;
}

@end
