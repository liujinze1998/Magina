//
//  MAGRankViewController.m
//  Magina
//
//  Created by liujinze on 2020/10/26.
//

#import "MAGRankViewController.h"
#import "MyTableViewContrllor.h"
#import <Masonry.h>

@interface MAGRankViewController ()

@end

@implementation MAGRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    // Do any additional setup after loading the view.
    MyTableViewContrllor *vc = [[MyTableViewContrllor alloc] initWithStyle:UITableViewStyleGrouped];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [vc.header.alertButton addTarget:self action:@selector(showVCAlert) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)showVCAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *stepChallenge = [UIAlertAction actionWithTitle:@"发起步数挑战" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了发起步数挑战按钮");
    }];
    UIAlertAction *donation = [UIAlertAction actionWithTitle:@"捐赠步数" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了捐赠步数按钮");
    }];
    UIAlertAction *send = [UIAlertAction actionWithTitle:@"发送给朋友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了发送给朋友按钮");
    }];
    UIAlertAction *shared = [UIAlertAction actionWithTitle:@"分享到朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了分享到朋友圈按钮");
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消按钮");
    }];
    [alertController addAction:stepChallenge];
    [alertController addAction:donation];
    [alertController addAction:send];
    [alertController addAction:shared];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end

