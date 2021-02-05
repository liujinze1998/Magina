//
//  MAGRootViewController.m
//  Magina
//
//  Created by liujinze on 2020/10/26.
//

#import "MAGRootViewController.h"
#import "MAGFeedViewController.h"
#import "MAGRankViewController.h"
#import "MAGTestViewController.h"
#import "MAGUserViewController.h"
#import "MAGLaunchView.h"

@interface MAGRootViewController ()

@property (nonatomic, strong) MAGLaunchView *launchView;
@property (nonatomic, assign) BOOL hasFirstAppeared;

@end

@implementation MAGRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINavigationController *feedNavVC = [[UINavigationController alloc] initWithRootViewController:[[MAGFeedViewController alloc] init]];
    UINavigationController *rankNavVC = [[UINavigationController alloc] initWithRootViewController:[[MAGRankViewController alloc] init]];
    UINavigationController *testNavVC = [[UINavigationController alloc] initWithRootViewController:[[MAGTestViewController alloc] init]];
    UINavigationController *userNavVC = [[UINavigationController alloc] initWithRootViewController:[[MAGUserViewController alloc] init]];
    
    NSArray *VCArray = [NSArray arrayWithObjects:feedNavVC, rankNavVC, testNavVC, userNavVC, nil];
    self.viewControllers = VCArray;
    
    feedNavVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:nil selectedImage:nil];
    rankNavVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"排行" image:nil selectedImage:nil];
    testNavVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"测试" image:nil selectedImage:nil];
    userNavVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人" image:nil selectedImage:nil];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{
        NSForegroundColorAttributeName:[UIColor grayColor],
        NSFontAttributeName:[UIFont fontWithName:@"HeiTi SC" size:15]
    } forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{
        NSForegroundColorAttributeName:[UIColor redColor],
        NSFontAttributeName:[UIFont fontWithName:@"HeiTi SC" size:15]
    } forState:UIControlStateSelected];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (!self.hasFirstAppeared) {
        self.hasFirstAppeared = YES;
        [self showLaunchAnimation];
    }
}

- (void)showLaunchAnimation
{
    self.launchView = [[MAGLaunchView alloc] initLaunchView];
    [self.view addSubview:self.launchView];
    [self.view bringSubviewToFront:self.launchView];
    [self.launchView startAnimation];
}

@end
