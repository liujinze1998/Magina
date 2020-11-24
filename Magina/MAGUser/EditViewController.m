//
//  EditViewController.m
//  dd
//
//  Created by bytedance on 2020/10/21.
//

#import "EditViewController.h"
#import "People.h"
#import <Masonry/Masonry.h>
@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _peo = [People SharedInstance];
    self.view.backgroundColor = [UIColor blackColor];
    [self editTitleLabel];
    [self backBtn];
    [self nameLab];
    [self dNumLab];
    [self nameTextField];
    [self dNumTextField];
    [self btn];
    // Do any additional setup after loading the view.
}

- (void)editTitleLabel{
    UILabel* lab = [[UILabel alloc]init];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(50);
        make.size.mas_equalTo(CGSizeMake(275, 24));
    }];
    lab.text = @"编辑个人资料";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
}

- (void)backBtn{
    UIButton* btn = [[UIButton alloc]init];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(11);
        make.left.equalTo(self.view.mas_left).with.offset(11);
        make.size.mas_equalTo(CGSizeMake(52, 24));
    }];
    [btn setTitle:@"<返回" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
    [btn addTarget:self action:@selector(backBtnTouchUp) forControlEvents:UIControlEventTouchUpInside];
}

- (void)nameLab{
    UILabel* lab = [[UILabel alloc]init];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(75);
        make.top.equalTo(self.view.mas_top).with.offset(200);
        make.size.mas_equalTo(CGSizeMake(50,50));
    }];
    lab.text = @"名字:";
    lab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
    lab.textColor = [UIColor whiteColor];
}

- (void)dNumLab{
    UILabel* lab = [[UILabel alloc]init];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(75);
        make.top.equalTo(self.view.mas_top).with.offset(260);
        make.size.mas_equalTo(CGSizeMake(75,50));
    }];
    lab.text = @"抖音号:";
    lab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
    lab.textColor = [UIColor whiteColor];
}

- (void)nameTextField{
    _nameTF = [[UITextField alloc]init];
    [self.view addSubview:_nameTF];
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(170);
        make.top.equalTo(self.view.mas_top).with.offset(200);
        make.size.mas_equalTo(CGSizeMake(200,50));
    }];
    _nameTF.text = _peo.name;
    _nameTF.textColor = [UIColor whiteColor];
    _nameTF.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];;
}

- (void)dNumTextField{
    _dNumTF = [[UITextField alloc]init];
    [self.view addSubview:_dNumTF];
    [_dNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(170);
        make.top.equalTo(self.view.mas_top).with.offset(260);
        make.size.mas_equalTo(CGSizeMake(200,50));
    }];
    _dNumTF.text = _peo.DNum;
    _dNumTF.textColor = [UIColor whiteColor];
    _dNumTF.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];;
}

- (void)btn{
    UIButton* btn = [[UIButton alloc]init];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).with.offset(320);
        make.size.mas_equalTo(CGSizeMake(50, 100));
    }];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
    [btn addTarget:self action:@selector(okBtnTouch) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backBtnTouchUp{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)okBtnTouch{
    _peo.name = _nameTF.text;
    _peo.DNum = _dNumTF.text;
    [self.navigationController popViewControllerAnimated:YES];
    
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
