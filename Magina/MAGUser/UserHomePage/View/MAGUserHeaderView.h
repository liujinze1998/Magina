//
//  MAGUserHeaderView.h
//  Magina
//
//  Created by liujinze on 2021/2/25.
//

#import <UIKit/UIKit.h>
#import "MAGUserViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAGUserHeaderView : UICollectionReusableView

@property (nonatomic, strong) MAGUserViewController *parentVC;
@property (nonatomic, strong) UIButton *userHeadButton;//个人&头像
@property (nonatomic, strong) UIButton *settingsButton;//系统设置
@property (nonatomic, strong) UIButton *userBackgrondButton;//顶部背景图片

@end

NS_ASSUME_NONNULL_END
