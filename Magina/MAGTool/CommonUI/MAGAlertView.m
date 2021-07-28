//
//  MAGAlertView.m
//  Magina
//
//  Created by liujinze on 2021/7/27.
//

#import "MAGAlertView.h"
#import <Masonry/Masonry.h>

@interface MAGAlertView()

@property (nonatomic, copy) dispatch_block_t confirmAction;
@property (nonatomic, copy) dispatch_block_t cancelAction;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIView *horizontalLine;
@property (nonatomic, strong) UIView *verticalLine;
@property (nonatomic, assign) BOOL isAnimating;

@end

@implementation MAGAlertView
#pragma mark - public

+ (void)showAlertOnView:(UIView *)view
              withTitle:(NSString *)title
     confirmButtonTitle:(NSString *)confirmTitle
      cancelButtonTitle:(NSString *)cancelTitle
           confirmBlock:(dispatch_block_t)actionBlock
            cancelBlock:(dispatch_block_t)cancelBlock{
    MAGAlertView *alert = [[MAGAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                                    withTitle:title
                                           confirmButtonTitle:confirmTitle
                                            cancelButtonTitle:cancelTitle
                                                 confirmBlock:actionBlock
                                                  cancelBlock:cancelBlock];
    [alert showOnView:view];
}

- (instancetype)initWithFrame:(CGRect)frame
                    withTitle:(NSString *)title
           confirmButtonTitle:(NSString *)confirmTitle
            cancelButtonTitle:(NSString *)cancelTitle
                 confirmBlock:(dispatch_block_t)actionBlock
                  cancelBlock:(dispatch_block_t)cancelBlock{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.text = title;
        [self.confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
        [self.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
        self.confirmAction = actionBlock;
        self.cancelAction = cancelBlock;
        [self setupUI];
    }
    return self;
}

- (void)showOnView:(UIView *)view
{
    if (!view) return;
    if (self.isAnimating) return;
    if (!self.superview) {
        [view addSubview:self];
    }
    
    self.isAnimating = YES;
    self.containerView.alpha = 0;
    self.containerView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.containerView.alpha = 1;
        self.containerView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.isAnimating = NO;
    }];
}

- (void)p_dismiss
{
    if (!self.superview) return;
    if (self.isAnimating) return;
    self.isAnimating = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self endEditing:YES];
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.containerView.alpha = 0;
            self.containerView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        } completion:^(BOOL finished) {
            self.isAnimating = NO;
            [self removeFromSuperview];
        }];
    });
}

#pragma mark

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    //make other vision weaken dim
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self addSubview:self.containerView];
    
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.confirmButton];
    [self.containerView addSubview:self.cancelButton];
    [self.containerView addSubview:self.horizontalLine];
    [self.containerView addSubview:self.verticalLine];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(280);
        make.height.mas_equalTo(120);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView);
        make.height.mas_equalTo(24);
        make.top.equalTo(self.containerView).offset(24);
    }];
    [self.horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.equalTo(self.containerView);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(24);
        make.height.mas_equalTo(0.5);
    }];
    [self.verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(self.containerView);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(47.5);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.containerView);
        make.top.equalTo(self.horizontalLine.mas_bottom);
        make.right.equalTo(self.verticalLine.mas_left);
    }];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.containerView);
        make.top.equalTo(self.horizontalLine.mas_bottom);
        make.left.equalTo(self.verticalLine.mas_right);
    }];
}

- (void)didMoveToSuperview
{
    if (self.superview) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.superview);
        }];
    }
}

#pragma mark - Actions

- (void)didClickConfirmButton:(id)sender
{
    if (self.confirmAction) {
        self.confirmAction();
    }
    [self p_dismiss];
}

- (void)didClickCancelButton:(id)sender
{
    if (self.cancelAction) {
        self.cancelAction();
    }
    [self p_dismiss];
}

#pragma mark - getter

- (UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.layer.cornerRadius = 12;
    }
    return _containerView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
        _titleLabel.textColor = [UIColor blackColor];;
    }
    return _titleLabel;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] init];
        [_confirmButton addTarget:self action:@selector(didClickConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
        [_confirmButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    return _confirmButton;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton addTarget:self action:@selector(didClickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _cancelButton;
}

- (UIView *)horizontalLine
{
    if (!_horizontalLine) {
        _horizontalLine = [[UIView alloc] init];
        _horizontalLine.backgroundColor = [UIColor grayColor];
    }
    return _horizontalLine;
}

- (UIView *)verticalLine
{
    if (!_verticalLine) {
        _verticalLine = [[UIView alloc] init];
        _verticalLine.backgroundColor = [UIColor grayColor];
    }
    return _verticalLine;
}

@end

