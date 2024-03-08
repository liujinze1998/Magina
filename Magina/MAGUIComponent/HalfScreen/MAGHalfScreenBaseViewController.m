//
//  MAGHalfScreenBaseViewController.m
//  Magina
//
//  Created by AM on 2022/10/10.
//

#import "MAGHalfScreenBaseViewController.h"
#import <Masonry/Masonry.h>
#import "MAGResponder.h"

@interface MAGHalfScreenBaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, readwrite) UIView *containerView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, assign) CGPoint lastLocation;
@property (nonatomic, strong) UIPanGestureRecognizer *panGes;

@property (nonatomic, assign) BOOL isPresented;
@property (nonatomic, assign, readwrite) BOOL isShowing;

@end

@implementation MAGHalfScreenBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;

    [self.view addSubview:self.maskView];
    self.maskView.alpha = 0;
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    self.containerView = [[UIView alloc] init];
    self.containerView.backgroundColor = [UIColor darkGrayColor];

    self.containerView.layer.masksToBounds = YES;
    [self.view addSubview:self.containerView];

    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(@(0));
    }];

    if (!self.disablePanGes) {
        self.panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(selfPanned:)];
        self.panGes.maximumNumberOfTouches = 1;
        self.panGes.delegate = self;
        [self.containerView addGestureRecognizer:self.panGes];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.containerHeight));
    }];
    [self defaultShowAnimation];
}

- (void)viewDidLayoutSubviews
{
    UIRectCorner corner = UIRectCornerTopLeft|UIRectCornerTopRight;
    if (!self.onlyTopCornerClips) {
        corner |= UIRectCornerBottomLeft | UIRectCornerBottomRight;
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.containerView.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
    CAShapeLayer *mask = [CAShapeLayer new];
    mask.path = path.CGPath;
    self.containerView.layer.mask = mask;
}

- (void)presentViewController:(void(^)(void))completion
{
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:self];
    navigation.modalPresentationStyle = UIModalPresentationOverFullScreen;
    navigation.navigationBar.hidden = YES;
    [[MAGResponder topViewController] presentViewController:navigation animated:NO completion:completion];
    self.isPresented = YES;
    self.isShowing = YES;
}

- (void)presentOnViewController:(UIViewController *)viewController
{
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [viewController presentViewController:self animated:NO completion:nil];
    self.isPresented = YES;
    self.isShowing = YES;
}

- (void)showOnView:(UIView *)view
{
    if (self.view.superview != view) {
        [view addSubview:self.view];
        [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view);
        }];
        self.isShowing = YES;
    }
}

- (void)defaultShowAnimation
{
    UIViewAnimationOptions option = 0;
    NSTimeInterval timeInterval = [self defaultShowAnimationDuration];
    [UIView animateWithDuration:timeInterval delay:0 options:option animations:^{
        self.maskView.alpha = 1;
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)tapDismiss
{
    [self dismiss];
}

- (void)slideDismiss
{
    [self dismiss];
}

- (void)dismiss
{
    [self dismiss:^{}];
}

- (void)dismiss:(void(^)(void))afterDismissBlock
{
    [self dismissWithDuration:0 afterDismissBlock:afterDismissBlock];
}

- (void)dismissWithDuration:(CGFloat)duration afterDismissBlock:(void(^)(void))afterDismissBlock
{
    if (self.dismissBlock) {
        self.dismissBlock();
    }
    void(^completion)(void) = ^{
        if (self.isPresented) {
            [self dismissViewControllerAnimated:NO completion: ^{
                self.isPresented = NO;
                if (afterDismissBlock) {
                    afterDismissBlock();
                }
            }];
        }
        [self.view removeFromSuperview];
        self.isShowing = NO;
    };
    [self defaultHideAnimationWithDuration:duration completion:completion];
}

- (void)defaultHideAnimationWithDuration:(CGFloat)duration completion:(void(^)(void))completion
{
    UIViewAnimationOptions option = UIViewAnimationOptionCurveEaseOut;
    NSTimeInterval timeInterval = [self defaultHideAnimationDuration];
    [UIView animateWithDuration:duration ?: timeInterval delay:0 options:option animations:^{
        self.maskView.alpha = 0.f;
        self.containerView.transform = CGAffineTransformMakeTranslation(0, self.containerView.frame.size.height);
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (void)selfPanned:(UIPanGestureRecognizer *)ges
{
    CGPoint velocity = [ges velocityInView:self.view];
    CGPoint location = [ges locationInView:self.view];
    if (self.isContentViewScroll && self.contentView.contentOffset.y > 0) {
        self.lastLocation = location;
        return;
    }

    switch (ges.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.lastLocation = location;
            if (velocity.y > 0 && self.isContentViewScroll && self.contentView.contentOffset.y <= 0) {
                self.contentView.scrollEnabled = NO;
            }
        }
        break;
        case UIGestureRecognizerStateChanged:
        {
            if (velocity.y > 0 && self.isContentViewScroll && self.contentView.contentOffset.y <= 0) {
                self.contentView.scrollEnabled = NO;
            }
            CGFloat diff = location.y - self.lastLocation.y;
            self.lastLocation = location;
            CGRect frame = self.containerView.frame;
            frame.origin.y += diff;
            if (frame.origin.y >= self.view.frame.size.height - frame.size.height) {
                self.containerView.frame = frame;
            }
        }
        break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            CGFloat dismissThreshold = CGRectGetHeight(self.view.frame);
            if (self.isFullScreen) {
                dismissThreshold += (CGRectGetHeight(self.view.frame) / 2.0f);
            }
            if (self.containerView.frame.origin.y >= dismissThreshold || velocity.y >= 300) {
                [self slideDismiss];
            } else {
                CGRect frame = self.containerView.frame;
                frame.origin.y = self.view.frame.size.height - frame.size.height;
                [UIView animateWithDuration:0.2 animations:^{
                    self.containerView.frame = frame;
                } completion:^(BOOL finished) {
                    if (self.isContentViewScroll) {
                        self.contentView.scrollEnabled = YES;
                    }
                }];
            }
        }
        break;
        default:
            break;
    }
}

- (void)setMaskColor:(UIColor *)maskColor
{
    _maskColor = maskColor;
    self.maskView.backgroundColor = maskColor;
}

- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _maskView.userInteractionEnabled = YES;
        [_maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDismiss)]];
    }
    return _maskView;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.panGes) {
        CGPoint velocity = [self.panGes velocityInView:self.contentView];
        if ((fabs(velocity.x) > fabs(velocity.y))) {
            return NO;
        } else {
            return YES;
        }
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer == self.panGes) {
        return YES;
    }
    return NO;
}

- (NSTimeInterval)defaultShowAnimationDuration
{
    return 0.3;
}

- (NSTimeInterval)defaultHideAnimationDuration
{
    return 0.3;
}

@end
