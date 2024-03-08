//
//  MAGFeedViewController.m
//  Magina
//

//  Created by AM on 2020/10/26.
//

#import "MAGFeedViewController.h"

#import "MAGUIConfigCenter.h"
#import "UIDevice+MAGAdapt.h"
#import <Masonry/Masonry.h>
#import <AVFoundation/AVFoundation.h>
#import "MAGBubble.h"

@interface MAGFeedViewController ()

@property (nonatomic, strong) UIButton *imageFeedButton;//打开图文feed
@property (nonatomic, strong) UIButton *videoFeedButton;//打开视频feed
@property (nonatomic, strong) UIButton *listFeedButton;//打开动态feed

@end

@implementation MAGFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFunctionUI];
}

#pragma setup UI


- (void)setFunctionUI
{
    CGFloat buttonWidth = (kScreenWidth - 40 )/ 3; //一排三个 左右间隔10
    CGFloat topOffSet = self.navigationController.navigationBar.frame.size.height + [UIDevice safeAreaTopInset] + 20;//导航栏高度+buffer
    
    //第一排
    [self.view addSubview:self.imageFeedButton];
    [self.view addSubview:self.videoFeedButton];
    [self.view addSubview:self.listFeedButton];
    
    [self.imageFeedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonWidth));
        make.top.equalTo(self.view).offset(topOffSet);
        make.left.equalTo(self.view).offset(10);
    }];
    
    [self.videoFeedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonWidth));
        make.top.equalTo(self.imageFeedButton);
        make.left.equalTo(self.imageFeedButton.mas_right).offset(10);
    }];
    
    [self.listFeedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonWidth));
        make.top.equalTo(self.imageFeedButton);
        make.left.equalTo(self.videoFeedButton.mas_right).offset(10);
    }];
}

#pragma mark - action

- (void)imageFeedButtonClicked{
    
}

- (void)videoFeedButtonClicked{
    
}

- (void)listFeedButtonClicked{
    
}

#pragma mark - getter


- (UIButton *)imageFeedButton
{
    if (!_imageFeedButton) {
        _imageFeedButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _imageFeedButton.backgroundColor = [UIColor grayColor];
        _imageFeedButton.titleLabel.numberOfLines = 2;
        [_imageFeedButton setTitle:@"图文feed\n(未开发)" forState:UIControlStateNormal];
        [_imageFeedButton addTarget:self action:@selector(imageFeedButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imageFeedButton;
}


- (UIButton *)videoFeedButton
{
    if (!_videoFeedButton) {
        _videoFeedButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _videoFeedButton.backgroundColor = [UIColor grayColor];
        _videoFeedButton.titleLabel.numberOfLines = 2;
        [_videoFeedButton setTitle:@"视频feed\n(未开发)" forState:UIControlStateNormal];
        [_videoFeedButton addTarget:self action:@selector(videoFeedButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _videoFeedButton;
}


- (UIButton *)listFeedButton
{
    if (!_listFeedButton) {
        _listFeedButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _listFeedButton.backgroundColor = [UIColor grayColor];
        _listFeedButton.titleLabel.numberOfLines = 2;
        [_listFeedButton setTitle:@"列表feed\n(未开发)" forState:UIControlStateNormal];
        [_listFeedButton addTarget:self action:@selector(listFeedButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _listFeedButton;
}
@end
