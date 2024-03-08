//
//  MAGResponder.m
//  Magina
//
//  Created by AM on 2022/10/10.
//

#import "MAGResponder.h"

@implementation MAGResponder

+ (UIViewController *)topViewController
{
    return [self topViewControllerForController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController *)topViewControllerForController:(UIViewController *)rootViewController
{
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        return [self topViewControllerForController:[navigationController.viewControllers lastObject]];
    }
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabController = (UITabBarController *)rootViewController;
        return [self topViewControllerForController:tabController.selectedViewController];
    }
    if (rootViewController.presentedViewController) {
        return [self topViewControllerForController:rootViewController.presentedViewController];
    }
    return rootViewController;
}

@end
