//
//  MAGScanViewController.m
//  Magina
//
//  Created by liujinze on 2021/2/4.
//

#import "MAGScanViewController.h"
#import "MAGScanView.h"
#import "MAGCameraScanManager.h"
#import "MAGUIConfigCenter.h"

#import <AVFoundation/AVFoundation.h>

@interface MAGScanViewController ()<MAGCameraScanManagerDelegate>

@property (nonatomic, strong) MAGScanView *scanningView;
@property (nonatomic, strong) MAGCameraScanManager *cameraManager;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *enterAlbumButton;

@property (nonatomic, strong) UILabel *flashtipLabel;
@property (nonatomic, strong) UIButton *flashButton;

@end

@implementation MAGScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.scanningView];
    [self createNavBarUI];
    [self bindScanManager];
    [self addNotification];
    //相机授权
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.cameraManager startRunning];
    [self.cameraManager startSampleBufferDelegate];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.cameraManager stopRunning];
    [self.cameraManager cancelSampleBufferDelegate];
}

- (void)createNavBarUI
{
    self.navigationItem.titleView = self.titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.closeButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.enterAlbumButton];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)bindScanManager
{
    self.cameraManager = [MAGCameraScanManager sharedCameraScanManager];
    self.cameraManager.delegate = self;
    [self.cameraManager createCameraSessionWith:self];
}

- (void)addNotification
{
//    UIApplicationDidEnterBackgroundNotification
    //开关手电筒
}

#pragma mark - 识别回调

- (void)QRCodeScanManager:(MAGCameraScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects
{
    if (!metadataObjects || metadataObjects.count == 0) {
        NSLog(@"未发现二维码");// todo toast instead
    } else {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        NSString *scanResult = obj.stringValue;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"扫描结果" message:scanResult preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        NSLog(@"扫码结果：%@",scanResult);
    }
}

- (void)QRCodeScanManager:(MAGCameraScanManager *)scanManager brightnessValue:(CGFloat)brightnessValue
{
    
}

#pragma mark - action

- (void)closeButtonClick
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)enterAlbumButtonClick
{
    NSLog(@"点击了相册按钮");
    //未开发
}

#pragma mark - private helper methods

#pragma mark - lazy init
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"扫一扫";
    }
    return _titleLabel;
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        _closeButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UIButton *)enterAlbumButton
{
    if (!_enterAlbumButton) {
        _enterAlbumButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_enterAlbumButton setTitle:@"相册" forState:UIControlStateNormal];
        _enterAlbumButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [_enterAlbumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_enterAlbumButton addTarget:self action:@selector(enterAlbumButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterAlbumButton;
}

- (MAGScanView *)scanningView
{
    if (!_scanningView) {
        _scanningView = [[MAGScanView alloc] initWithFrame:CGRectMake(scanBorderX, scanBorderY, scanAreaX, scanAreaX)];
    }
    return _scanningView;
}

@end
