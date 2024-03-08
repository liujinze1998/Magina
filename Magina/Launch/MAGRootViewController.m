//
//  MAGRootViewController.m
//  Magina
//
//  Created by AM on 2020/10/26.
//

#import "MAGRootViewController.h"
#import "MAGFeedViewController.h"
#import "MAGFunctionViewController.h"
#import "MAGUIBizViewController.h"
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
    UINavigationController *funcNavVC = [[UINavigationController alloc] initWithRootViewController:[[MAGFunctionViewController alloc] init]];
    UINavigationController *UINavVC = [[UINavigationController alloc] initWithRootViewController:[[MAGUIBizViewController alloc] init]];
    UINavigationController *userNavVC = [[UINavigationController alloc] initWithRootViewController:[[MAGUserViewController alloc] init]];
    
    NSArray *VCArray = [NSArray arrayWithObjects:feedNavVC, funcNavVC, UINavVC, userNavVC, nil];
    self.viewControllers = VCArray;
    
    feedNavVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:nil selectedImage:nil];
    funcNavVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"功能" image:nil selectedImage:nil];
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
