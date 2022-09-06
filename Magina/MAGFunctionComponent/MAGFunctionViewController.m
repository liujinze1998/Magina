//
//  MAGFunctionViewController.m
//  Magina
//
//  Created by liujinze on 2022/9/6.
//

#import "MAGFunctionViewController.h"
#import "MAGScanViewController.h"
#import "MAGDeviceAuth.h"
#import "UIDevice+MAGAdapt.h"
#import "MAGUIConfigCenter.h"
#import <Masonry/Masonry.h>

@interface MAGFunctionViewController ()

@property (nonatomic, strong) UIButton *scanButton;//扫一扫
@property (nonatomic, strong) UIButton *transGifButton;//视频转gif
@property (nonatomic, strong) UIButton *albumButton;//相册
@property (nonatomic, strong) UIButton *switchButton;//方法交换

@end

@implementation MAGFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat buttonWidth = (kScreenWidth - 40 )/ 3; //一排三个 左右间隔10
    CGFloat topOffSet = self.navigationController.navigationBar.frame.size.height + [UIDevice safeAreaTopInset] + 20;//导航栏高度+buffer
    
    //第一排
    [self.view addSubview:self.scanButton];
    [self.view addSubview:self.transGifButton];
    [self.view addSubview:self.switchButton];
    [self.scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonWidth));
        make.top.equalTo(self.view).offset(topOffSet);
        make.left.equalTo(self.view).offset(10);
    }];
    [self.transGifButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonWidth));
        make.top.equalTo(self.scanButton);
        make.left.equalTo(self.scanButton.mas_right).offset(10);
    }];
    [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonWidth));
        make.top.equalTo(self.scanButton);
        make.left.equalTo(self.transGifButton.mas_right).offset(10);
    }];
    
    //第二排
    [self.view addSubview:self.albumButton];
    [self.albumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonWidth));
        make.top.equalTo(self.scanButton.mas_bottom).offset(10);
        make.left.equalTo(self.scanButton);
    }];
}

#pragma mark - action

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

- (void)albumButtonClicked{
    
}

- (void)transGifButtonClicked{
    
}

- (void)switchButtonClicked{
    
}

#pragma mark - getter

- (UIButton *)scanButton
{
    if (!_scanButton) {
        _scanButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _scanButton.backgroundColor = [UIColor greenColor];
        _scanButton.titleLabel.numberOfLines = 2;
        [_scanButton setTitle:@"扫一扫" forState:UIControlStateNormal];
        [_scanButton addTarget:self action:@selector(scanButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanButton;
}

- (UIButton *)transGifButton
{
    if (!_transGifButton) {
        _transGifButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _transGifButton.backgroundColor = [UIColor grayColor];
        _transGifButton.titleLabel.numberOfLines = 2;
        [_transGifButton setTitle:@"视频转gif(未开发)" forState:UIControlStateNormal];
        [_transGifButton addTarget:self action:@selector(transGifButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _transGifButton;
}

- (UIButton *)albumButton
{
    if (!_albumButton) {
        _albumButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _albumButton.backgroundColor = [UIColor grayColor];
        _albumButton.titleLabel.numberOfLines = 2;
        [_albumButton setTitle:@"相册(未开发)" forState:UIControlStateNormal];
        [_albumButton addTarget:self action:@selector(albumButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _albumButton;
}

- (UIButton *)switchButton
{
    if (!_switchButton) {
        _switchButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _switchButton.backgroundColor = [UIColor grayColor];
        _switchButton.titleLabel.numberOfLines = 2;
        [_switchButton setTitle:@"方法交换(未开发)" forState:UIControlStateNormal];
        [_switchButton addTarget:self action:@selector(switchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchButton;
}


@end
