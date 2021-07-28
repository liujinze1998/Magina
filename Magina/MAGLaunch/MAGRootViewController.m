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

@property (nonatomic, assign) BOOL hasFirstAppeared;

@end

@implementation MAGRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINavigationController *feedNavVC = [[UINavigationController alloc] initWithRootViewController:[[MAGFeedViewController alloc] init]];
    UINavigationController *rankNavVC = [[UINavigationController alloc] initWithRootViewController:[[MAGRankViewController alloc] init]];
    UINavigationController *UINavVC = [[UINavigationController alloc] initWithRootViewController:[[MAGTestViewController alloc] init]];
    UINavigationController *userNavVC = [[UINavigationController alloc] initWithRootViewController:[[MAGUserViewController alloc] init]];
    
    NSArray *VCArray = [NSArray arrayWithObjects:feedNavVC, rankNavVC, UINavVC, userNavVC, nil];
    self.viewControllers = VCArray;
    
    feedNavVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:nil selectedImage:nil];
    rankNavVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"排行" image:nil selectedImage:nil];
    UINavVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"UI" image:nil selectedImage:nil];
    userNavVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人" image:nil selectedImage:nil];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{
        NSForegroundColorAttributeName:[UIColor grayColor],
        NSFontAttributeName:[UIFont fontWithName:@"HeiTi SC" size:18]
    } forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{
        NSForegroundColorAttributeName:[UIColor redColor],
        NSFontAttributeName:[UIFont fontWithName:@"HeiTi SC" size:18]
    } forState:UIControlStateSelected];
}

@end
