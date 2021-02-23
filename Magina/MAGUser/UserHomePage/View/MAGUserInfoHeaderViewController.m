//
//  MAGUserInfoHeaderViewController.m
//  dd
//
//  Created by bytedance on 2020/10/21.
//

#import "MAGUserInfoHeaderViewController.h"
#import "People.h"

#import "UIDevice+MAGAdapt.h"
#import "MAGCaptureAlbumManager.h"
#import "Magina-Swift.h"

#import <Masonry/Masonry.h>

@interface MAGUserInfoHeaderViewController () <MAGImagePickerDelegate>

@property (nonatomic, strong) UIView *parentView;//牵扯太多，懂得都懂
@property (nonatomic, assign) CGFloat topOffset;

@property (nonatomic, strong) UIImageView *userBackgroundImageView;//顶部背景图片
@property (nonatomic, strong) UIButton *userHeadButton;//个人&头像
@property (nonatomic, strong) UIButton *settingsButton;//系统设置

@end

@implementation MAGUserInfoHeaderViewController

- (instancetype)initWithParentView:(UIView *)view navHeight:(CGFloat)height
{
    self = [super init];
    if (self) {
        self.parentView = view;
        self.topOffset = height + [UIDevice safeAreaTopInset];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.view setFrame:CGRectMake(self.parentView.frame.origin.x, self.parentView.frame.origin.y - self.topOffset, self.parentView.frame.size.width, self.parentView.frame.size.height + self.topOffset)];
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.nameLab.text = [People SharedInstance].name;
    self.dNumLab.text = [People SharedInstance].DNum;
}

- (void)setUI
{
    [self.view addSubview:self.userBackgroundImageView];
    [self.view addSubview:self.userHeadButton];
    [self.view addSubview:self.settingsButton];
    
    [self.userBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height * 0.4));
    }];
    
    [self.userHeadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.top.equalTo(self.userBackgroundImageView.mas_bottom).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    [self.settingsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.bottom.equalTo(self.userHeadButton.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(140, 40));
    }];
    
    [self nameLabel];
    [self dNumLabel];
    [self jianjie];
}


- (void)nameLabel{
    _nameLab = [[UILabel alloc]init];
    [self.view addSubview:_nameLab];
    _nameLab.text = [People SharedInstance].name;
    _nameLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:24];
    CGSize sizeNew = [_nameLab.text sizeWithAttributes:@{NSFontAttributeName:_nameLab.font}];
    if(sizeNew.width>375) sizeNew.width = 375;
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(16);
        make.top.equalTo(self.view.mas_top).with.offset(219);
        make.size.mas_equalTo(CGSizeMake(sizeNew.width, sizeNew.height));
    }];
    _nameLab.textColor = [UIColor whiteColor];
}

- (void)dNumLabel{
    UILabel* lab = [[UILabel alloc]init];
    _dNumLab = lab;
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(16);
        make.top.equalTo(self.view.mas_top).with.offset(257);
        make.size.mas_equalTo(CGSizeMake(110, 17));
    }];
    lab.adjustsFontSizeToFitWidth = YES;
    lab.text = [[NSString alloc]initWithFormat:@"抖音号：%@",[People SharedInstance].DNum];
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
}

- (void)jianjie{
    UILabel* lab = [[UILabel alloc]init];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(16);
        make.top.equalTo(self.view.mas_top).with.offset(299);
        make.size.mas_equalTo(CGSizeMake(343, 21));
    }];
    lab.text = @"你还没有填写个人简介，点击添加...";
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
}

- (void)homePageDidScroll:(CGFloat)dropValue
{
    //图片高度
    CGFloat imageHeight = self.userBackgroundImageView.bounds.size.height;
    //图片宽度/Users/bytedance/Desktop/Magina/Magina/MAGUser/UserInfo/New Group
    CGFloat imageWidth = self.userBackgroundImageView.bounds.size.width;

    //下拉
    if (dropValue < 0) {
        CGFloat totalHeight = imageHeight + ABS(dropValue);
        CGFloat multiple = totalHeight / imageHeight;
        CGFloat totalWidth = imageWidth * multiple;
        self.userBackgroundImageView.frame = CGRectMake(-(totalWidth - imageWidth) * 0.5, dropValue, totalWidth, totalHeight);
    }
}

#pragma mark - action
- (void)backgroundImageViewClicked
{
    UIAlertController *replaceBGImageAlertSheet = [UIAlertController alertControllerWithTitle:@"更换背景图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [replaceBGImageAlertSheet addAction:[UIAlertAction actionWithTitle:@"现在拍一张" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MAGCaptureAlbumManager *imagePickerManager = [MAGCaptureAlbumManager sharedManager];
        imagePickerManager.delegate = self;
        [imagePickerManager replaceImageFromCaptureWithCurrentController:self];
        
    }]];
    [replaceBGImageAlertSheet addAction:[UIAlertAction actionWithTitle:@"相册选一张" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MAGCaptureAlbumManager *imagePickerManager = [MAGCaptureAlbumManager sharedManager];
        imagePickerManager.delegate = self;
        [imagePickerManager replaceImageFromAlbumWithCurrentController:self];
    }]];
    [replaceBGImageAlertSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:replaceBGImageAlertSheet animated:YES completion:nil];
}

- (void)settingsButtonClicked
{
    //系统设置 XLForm实现
}

- (void)editUserInfoButtonClicked
{
    MAGUserInfoViewController *infoViewController = [[MAGUserInfoViewController alloc] init];
//    [self.navigationController pushViewController:infoViewController animated:YES];
    [self presentViewController:infoViewController animated:YES completion:nil];
}

#pragma mark - MAGImagePicker

- (void)didFinishPickingImage:(UIImage *)image
{
    self.userBackgroundImageView.image = image;
}

#pragma mark - init UI

- (UIImageView *)userBackgroundImageView
{
    if (!_userBackgroundImageView) {
        _userBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WechatIMG14.jpeg"]];
        [_userBackgroundImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_userBackgroundImageView setClipsToBounds:YES];
        [_userBackgroundImageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundImageViewClicked)];
        [_userBackgroundImageView addGestureRecognizer:tapGesture];
        _userBackgroundImageView.userInteractionEnabled = YES;
    }
    return _userBackgroundImageView;
}

- (UIButton *)userHeadButton
{
    if (!_userHeadButton) {
        _userHeadButton = [[UIButton alloc] init];
        [_userHeadButton setImage:[UIImage imageNamed:@"touxiang.jpeg"] forState:UIControlStateNormal];
        [_userHeadButton addTarget:self action:@selector(editUserInfoButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userHeadButton;
}

- (UIButton *)settingsButton
{
    if (!_settingsButton) {
        _settingsButton = [[UIButton alloc] init];
        [_settingsButton setTitle:@"系统设置" forState:UIControlStateNormal];
        _settingsButton.backgroundColor = [UIColor grayColor];
        [_settingsButton addTarget:self action:@selector(settingsButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingsButton;
}

@end
