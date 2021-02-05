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

@interface MAGScanViewController ()<MAGCameraScanManagerDelegate>

@property (nonatomic, strong) MAGScanView *scanningView;
@property (nonatomic, strong) MAGCameraScanManager *cameraManager;

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *enterAlbumButton;

@property (nonatomic, strong) UILabel *flashtipLabel;
@property (nonatomic, strong) UIButton *flashButton;

@end

@implementation MAGScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scanningView];
    [self createNavBarUI];
    [self bindScanManager];
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
    self.cameraManager.delegate = self;
}

- (void)createNavBarUI
{
    self.navigationItem.title = @"扫一扫";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.closeButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.enterAlbumButton];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)bindScanManager
{
    self.cameraManager = [MAGCameraScanManager sharedCameraScanManager];
    [self.cameraManager createCameraSessionWith:self];
}

#pragma mark - 识别回调

- (void)QRCodeScanManager:(MAGCameraScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects
{
    
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

#pragma mark - lazy init

- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UIButton *)enterAlbumButton
{
    if (!_enterAlbumButton) {
        _enterAlbumButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_enterAlbumButton setTitle:@"相册" forState:UIControlStateNormal];
        [_enterAlbumButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
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
