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
    [self backgroundLoad];
    [self headPortraitLoad];
    [self friendBut];
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

- (void)backgroundLoad
{
    self.userBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WechatIMG14.jpeg"]];
    [self.userBackgroundImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.userBackgroundImageView setClipsToBounds:YES];
    [self.userBackgroundImageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:self.userBackgroundImageView];
    [self.userBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(375, 125));
    }];
}

- (void)headPortraitLoad
{
    UIImageView *ima =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"touxiang.jpeg"]];
    [self.view addSubview:ima];
    [ima mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(16);
        make.top.equalTo(self.view.mas_top).with.offset(113);
        make.size.mas_equalTo(CGSizeMake(94, 94));
    }];
}



- (void)friendBut{
    UIButton* but = [[UIButton alloc]init];
    [self.view addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(290);
        make.top.equalTo(self.view.mas_top).with.offset(140);
        make.size.mas_equalTo(CGSizeMake(69, 40));
    }];
    [but setTitle:@"+好友" forState:UIControlStateNormal];
    but.backgroundColor = [UIColor grayColor];
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
//    //图片高度
//    CGFloat imageHeight = self.dd_h;
//    //图片宽度
//    CGFloat imageWidth = kScreenWidth;
//    //图片上下偏移量
//    CGFloat imageOffsetY = contentOffSetY;
//
//    //下拉
//    if (imageOffsetY < 0) {
//        CGFloat totalOffset = imageHeight + ABS(imageOffsetY);
//        CGFloat f = totalOffset / imageHeight;
//        self.backgroundImgV.frame = CGRectMake(-(imageWidth * f - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset);
//    }
//
//    _visualEffectView.frame = self.backgroundImgV.frame;
}

@end
