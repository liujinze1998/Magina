//
//  HorizontalCollectionViewController.m
//  Magina
//
//  Created by liujinze on 2021/7/27.
//

#import "HorizontalCollectionViewController.h"
#import "AdaptiveContentContainerView.h"
#import "FirstCellZoomInContainerView.h"
#import <Masonry/Masonry.h>

@interface HorizontalCollectionViewController ()

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) AdaptiveContentContainerView *contentContainerView;
@property (nonatomic, strong) FirstCellZoomInContainerView *zoomInContainerView;

@end

@implementation HorizontalCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.contentContainerView = [[AdaptiveContentContainerView alloc] init];
    [self.view addSubview:self.contentContainerView];
    [self.contentContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.view).offset(150);
        make.height.mas_equalTo(150);
    }];
    
    self.zoomInContainerView = [[FirstCellZoomInContainerView alloc] init];
    [self.view addSubview:self.zoomInContainerView];
    [self.zoomInContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentContainerView);
        make.right.equalTo(self.contentContainerView);
        make.top.equalTo(self.contentContainerView.mas_bottom).offset(10);
        make.height.mas_equalTo(300);
    }];
    
    self.closeButton = [[UIButton alloc] init];
    [self.closeButton setTitle:@"关闭本页面" forState:UIControlStateNormal];
    [self.closeButton setBackgroundColor:[UIColor redColor]];
    [self.closeButton addTarget:self action:@selector(closeVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.zoomInContainerView.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
}

- (void)closeVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
