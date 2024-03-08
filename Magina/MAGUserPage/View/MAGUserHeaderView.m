//
//  MAGUserHeaderView.m
//  Magina
//
//  Created by AM on 2021/2/25.
//

#import "MAGUserHeaderView.h"
#import <Masonry/Masonry.h>
#import "MAGCaptureAlbumManager.h"
#import "MAGSettingsViewController.h"

@interface MAGUserHeaderView () <MAGImagePickerDelegate>

@end

@implementation MAGUserHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    [self addSubview:self.userBackgrondButton];
    [self addSubview:self.userHeadButton];
    [self addSubview:self.settingsButton];
    
    [self.userBackgrondButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.width, self.bounds.size.height * 0.4));
    }];
    
    [self.userHeadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20);
        make.top.equalTo(self.userBackgrondButton.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    [self.settingsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-20);
        make.bottom.equalTo(self.userHeadButton.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(140, 40));
    }];
    [self.userBackgrondButton addTarget:self action:@selector(backgroundButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.userHeadButton addTarget:self action:@selector(editUserInfoButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.settingsButton addTarget:self action:@selector(settingsButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - action

- (void)backgroundButtonClicked
{
    UIAlertController *replaceBGImageAlertSheet = [UIAlertController alertControllerWithTitle:@"更换背景图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [replaceBGImageAlertSheet addAction:[UIAlertAction actionWithTitle:@"现在拍一张" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MAGCaptureAlbumManager *imagePickerManager = [MAGCaptureAlbumManager sharedManager];
        imagePickerManager.delegate = self;
        [imagePickerManager replaceImageFromCaptureWithCurrentController:self.parentVC];

    }]];
    [replaceBGImageAlertSheet addAction:[UIAlertAction actionWithTitle:@"相册选一张" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MAGCaptureAlbumManager *imagePickerManager = [MAGCaptureAlbumManager sharedManager];
        imagePickerManager.delegate = self;
        [imagePickerManager replaceImageFromAlbumWithCurrentController:self.parentVC];
    }]];
    [replaceBGImageAlertSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self.parentVC presentViewController:replaceBGImageAlertSheet animated:YES completion:nil];
}

- (void)settingsButtonClicked
{
    MAGSettingsViewController *settingVC = [[MAGSettingsViewController alloc] init];
    [self.parentVC.navigationController pushViewController:settingVC animated:YES];
}

- (void)editUserInfoButtonClicked
{
    MAGUserInfoViewController *infoViewController = [[MAGUserInfoViewController alloc] init];
    [self.parentVC.navigationController pushViewController:infoViewController animated:YES];
}

#pragma mark - MAGImagePickerDelegate

- (void)didFinishPickingImage:(UIImage *)image
{
    self.userBackgrondButton.imageView.image = image;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - init lazy

- (UIButton *)userBackgrondButton
{
    if (!_userBackgrondButton) {
        _userBackgrondButton = [[UIButton alloc] init];
        [_userBackgrondButton setImage:[UIImage imageNamed:@"WechatIMG14"] forState:UIControlStateNormal];
        [_userBackgrondButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_userBackgrondButton.imageView setClipsToBounds:YES];
        [_userBackgrondButton.imageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    }
    return _userBackgrondButton;
}

- (UIButton *)userHeadButton
{
    if (!_userHeadButton) {
        _userHeadButton = [[UIButton alloc] init];
        [_userHeadButton setImage:[UIImage imageNamed:@"touxiang.jpeg"] forState:UIControlStateNormal];
    }
    return _userHeadButton;
}

- (UIButton *)settingsButton
{
    if (!_settingsButton) {
        _settingsButton = [[UIButton alloc] init];
        [_settingsButton setTitle:@"系统设置" forState:UIControlStateNormal];
        _settingsButton.backgroundColor = [UIColor grayColor];
    }
    return _settingsButton;
}

@end

