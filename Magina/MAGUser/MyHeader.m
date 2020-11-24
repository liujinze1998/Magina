//
//  MyHeader.m
//  dd
//
//  Created by bytedance on 2020/10/21.
//

#import "MyHeader.h"
#import "People.h"
#import <Masonry/Masonry.h>
#import "EditViewController.h"
@interface MyHeader ()

@end

@implementation MyHeader

- (void)viewDidLoad {
    [super viewDidLoad];
    [_fatherView addSubview:self.view];
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fatherView);
        make.size.mas_equalTo(CGSizeMake(375, 408));
    }];
    _peo = [People SharedInstance];
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

- (void)backgroundLoad{
    UIImageView *ima =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"WechatIMG14.jpeg"]];
    [self.view addSubview:ima];
    [ima mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(375, 125));
    }];
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)headPortraitLoad{
    UIImageView *ima =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"touxiang.jpeg"]];
    [self.view addSubview:ima];
    [ima mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(16);
        make.top.equalTo(self.view.mas_top).with.offset(113);
        make.size.mas_equalTo(CGSizeMake(94, 94));
    }];
    //[ima.layer setCornerRadius:(ima.frame.size.height/2)];
    //ima.layer.masksToBounds = YES;
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
    _nameLab.text = _peo.name;
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
    lab.text = [[NSString alloc]initWithFormat:@"抖音号：%@",_peo.DNum];
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
    lab.text = [[NSString alloc]initWithFormat:@"%ldw",_peo.getCompliments];
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
    lab.text = [[NSString alloc]initWithFormat:@"%ld",_peo.follow];
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
    lab.text = [[NSString alloc]initWithFormat:@"%ld",_peo.fans];
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view endEditing:YES];
    self.nameLab.text = self.peo.name;
    self.dNumLab.text = self.peo.DNum;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
