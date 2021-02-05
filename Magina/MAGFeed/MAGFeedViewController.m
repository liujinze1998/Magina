//
//  MAGFeedViewController.m
//  Magina
//
//  Created by liujinze on 2020/10/26.
//

#import "MAGFeedViewController.h"
#import "MAGScanViewController.h"

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
    NSLog(@"点击了扫一扫入口");
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
