//
//  MAGUserInfoHeaderViewController.m
//  dd
//
//  Created by bytedance on 2020/10/21.
//

#import "MAGUserInfoHeaderViewController.h"
#import "People.h"
#import <Masonry/Masonry.h>
#import "MAGEditUserInfoViewController.h"
@interface MAGUserInfoHeaderViewController ()

@property(nonatomic, strong) UIView *parentView;//牵扯太多，懂得都懂
@property (nonatomic, strong) UIImageView *userBackgroundImageView;//顶部背景图片
@property (nonatomic, strong) UIButton *userHeadButton;//头像
@property (nonatomic, strong) UIButton *addNewFriendButton;//加好友
@property (nonatomic, strong) UIButton *editUserInfoButton;//编辑资料
//@property (nonatomic, strong) UIImageView *userBackgroundImageView;//顶部背景图片
//@property (nonatomic, strong) UIImageView *userBackgroundImageView;//顶部背景图片
//@property (nonatomic, strong) UIImageView *userBackgroundImageView;//顶部背景图片

@end

@implementation MAGUserInfoHeaderViewController

- (instancetype)initWithParentView:(UIView *)view
{
    self = [super init];
    if (self) {
        self.parentView = view;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.view setFrame:self.parentView.frame];
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
    [self.view addSubview:self.editUserInfoButton];
    [self.view addSubview:self.addNewFriendButton];
    
    [self.userBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height * 0.3));
    }];
    
    [self.userHeadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.top.equalTo(self.userBackgroundImageView.mas_bottom).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
   
    [self.addNewFriendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.bottom.equalTo(self.userHeadButton.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(70, 40));
    }];
    
    [self.editUserInfoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.addNewFriendButton.mas_left).with.offset(-5);
        make.bottom.equalTo(self.userHeadButton.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(140, 40));
    }];
    
    [self nameLabel];
    [self dNumLabel];
    [self jianjie];
    [self getComplimentsNum];
    [self getCompliments];
    [self followNum];
    [self follow];
    [self fansNum];
    [self fans];
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

- (void)getComplimentsNum{
    UILabel* lab = [[UILabel alloc]init];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(16);
        make.top.equalTo(self.view.mas_top).with.offset(364);
        make.size.mas_equalTo(CGSizeMake(39, 24));
    }];
    lab.text = [[NSString alloc]initWithFormat:@"%ldw",[People SharedInstance].getCompliments];
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
}

- (void)getCompliments{
    UILabel* lab = [[UILabel alloc]init];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(60);
        make.top.equalTo(self.view.mas_top).with.offset(365);
        make.size.mas_equalTo(CGSizeMake(30, 21));
    }];
    lab.text = @"获赞";
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
}

- (void)followNum{
    UILabel* lab = [[UILabel alloc]init];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(106);
        make.top.equalTo(self.view.mas_top).with.offset(364);
        make.size.mas_equalTo(CGSizeMake(16, 24));
    }];
    lab.text = [[NSString alloc]initWithFormat:@"%ld",[People SharedInstance].follow];
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
}

- (void)follow{
    UILabel* lab = [[UILabel alloc]init];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(129);
        make.top.equalTo(self.view.mas_top).with.offset(365);
        make.size.mas_equalTo(CGSizeMake(30, 21));
    }];
    lab.text = @"关注";
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
}

- (void)fansNum{
    UILabel* lab = [[UILabel alloc]init];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(175);
        make.top.equalTo(self.view.mas_top).with.offset(364);
        make.size.mas_equalTo(CGSizeMake(28, 24));
    }];
    lab.text = [[NSString alloc]initWithFormat:@"%ld",[People SharedInstance].fans];
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
}

- (void)fans{
    UILabel* lab = [[UILabel alloc]init];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(209);
        make.top.equalTo(self.view.mas_top).with.offset(365);
        make.size.mas_equalTo(CGSizeMake(30, 21));
    }];
    lab.text = @"粉丝";
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
}

- (void)homePageDidScroll:(CGFloat)dropValue
{
    //图片高度
    CGFloat imageHeight = self.userBackgroundImageView.bounds.size.height;
    //图片宽度
    CGFloat imageWidth = self.userBackgroundImageView.bounds.size.width;

    //下拉
    if (dropValue < 0) {
        CGFloat totalHeight = imageHeight + ABS(dropValue);
        CGFloat multiple = totalHeight / imageHeight;
        CGFloat totalWidth = imageWidth * multiple;
        self.userBackgroundImageView.frame = CGRectMake(-(totalWidth - imageWidth) * 0.5, dropValue, totalWidth, totalHeight);
    }
//
//    _visualEffectView.frame = self.backgroundImgV.frame;
}

#pragma mark - action
- (void)addNewFriendButtonClicked
{
    //加好友 未开发
}

- (void)userHeadButtonClicked
{
    //换头像-imagepicker
}

- (void)editUserInfoButtonClicked
{
    MAGEditUserInfoViewController *editInfoViewController = [[MAGEditUserInfoViewController alloc] init];
    [self presentViewController:editInfoViewController animated:YES completion:nil];
}

#pragma mark - init UI

- (UIImageView *)userBackgroundImageView
{
    if (!_userBackgroundImageView) {
        _userBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WechatIMG14.jpeg"]];
        [_userBackgroundImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_userBackgroundImageView setClipsToBounds:YES];
        [_userBackgroundImageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    }
    return _userBackgroundImageView;
}

- (UIButton *)userHeadButton
{
    if (!_userHeadButton) {
        _userHeadButton = [[UIButton alloc] init];
        [_userHeadButton setImage:[UIImage imageNamed:@"touxiang.jpeg"] forState:UIControlStateNormal];
        [_userHeadButton addTarget:self action:@selector(userHeadButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userHeadButton;
}

- (UIButton *)addNewFriendButton
{
    if (!_addNewFriendButton) {
        _addNewFriendButton = [[UIButton alloc] init];
        _addNewFriendButton.backgroundColor = [UIColor grayColor];
        [_addNewFriendButton setTitle:@"+好友" forState:UIControlStateNormal];
        [_addNewFriendButton addTarget:self action:@selector(addNewFriendButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addNewFriendButton;
}

- (UIButton *)editUserInfoButton
{
    if (!_editUserInfoButton) {
        _editUserInfoButton = [[UIButton alloc] init];
        [_editUserInfoButton setTitle:@"编辑资料" forState:UIControlStateNormal];
        _editUserInfoButton.backgroundColor = [UIColor grayColor];
        [_editUserInfoButton addTarget:self action:@selector(editUserInfoButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editUserInfoButton;
}

@end
