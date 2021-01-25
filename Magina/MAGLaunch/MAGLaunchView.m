//
//  MAGLaunchView.m
//  Magina
//
//  Created by liujinze on 2021/1/25.
//

#import "MAGLaunchView.h"
#import "MAGUIConfigCenter.h"
#import "UIDevice+MAGAdapt.h"

#import <Masonry/Masonry.h>

static const CGFloat startAnimationDuration = 1;
static const CGFloat endAnimationDuration = 1;
static const CGFloat finishAnimationDuration = 0.5;

@interface MAGLaunchView()

@property (nonatomic, strong) UIImageView *launchImageView;
@property (nonatomic, strong) UIButton *skipButton; //跳过启动动画

@end

@implementation MAGLaunchView

- (instancetype)init
{
    return [self initLaunchView];
}

- (instancetype)initLaunchView
{
    self = [super initWithFrame:kScreenRect];
    if (self) {
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI
{
    self.launchImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    if ([UIDevice isLandDirect]) {
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage_horizontal"];
    } else {
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage_vertical"];
    }
    self.launchImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.launchImageView addSubview:self.skipButton];
    [self.skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.launchImageView.mas_right).offset(20);
        make.top.equalTo(self.launchImageView.mas_top).offset(-50-[UIDevice safeAreaTopInset]);
    }];
    [self addSubview:self.launchImageView];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - action

- (void)startAnimation
{
    self.launchImageView.alpha = 0.9;
    [UIView animateWithDuration:5
                          delay:0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
        self.launchImageView.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:endAnimationDuration
                              delay:0
                            options:UIViewAnimationOptionTransitionNone
                         animations:^{
            self.launchImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:finishAnimationDuration
                             animations:^{
                self.launchImageView.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }];
        
    }];
}

- (void)skipButtonClicked
{
    [self removeFromSuperview];
}

#pragma mark - lazy init
- (UIButton *)skipButton
{
    if (!_skipButton) {
        _skipButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        _skipButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
        _skipButton.layer.cornerRadius = 10;
        _skipButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_skipButton setTitle:@"跳过动画" forState:UIControlStateNormal];
        [_skipButton addTarget:self action:@selector(skipButtonClicked) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _skipButton;
}

@end
