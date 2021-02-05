//
//  MAGScanViewController.m
//  Magina
//
//  Created by liujinze on 2021/2/4.
//

#import "MAGScanViewController.h"
#import "MAGScanView.h"
#import "MAGCameraScanManager.h"

@interface MAGScanViewController ()

@property (nonatomic, strong) MAGScanView *scanningView;
@property (nonatomic, strong) MAGCameraScanManager *cameraManager;

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *enterAlbumButton;

@end

@implementation MAGScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self createNavBarUI];
}

// 以push/pop形式推出navvc的childvc的时候 这样设置动画更加平滑
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//}

- (void)createNavBarUI
{
    self.navigationItem.title = @"扫一扫";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.closeButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.enterAlbumButton];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
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

@end
