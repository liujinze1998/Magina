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
    [self addSubview:self.launchImageView];
    [self addSubview:self.skipButton];
    [self sendSubviewToBack:self.launchImageView];
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
        _skipButton = [[UIButton alloc] initWithFrame:CGRectMake(300, [UIDevice safeAreaTopInset] + 50, 100, 50)];
        _skipButton.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.7];
        _skipButton.layer.cornerRadius = 10;
        _skipButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_skipButton setTitle:@"跳过动画" forState:UIControlStateNormal];
        [_skipButton addTarget:self action:@selector(skipButtonClicked) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _skipButton;
}

@end
