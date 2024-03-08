//
//  MAGHalfScreenContainerViewController.m
//  Magina
//
//  Created by AM on 2022/10/10.
//

#import "MAGHalfScreenContainerViewController.h"
#import "MAGHalfScreenTableViewCell.h"
#import "UIDevice+MAGAdapt.h"
#import <Masonry/Masonry.h>

static const NSInteger kHalfScreenCellHeight = 80;

@interface MAGHalfScreenContainerViewController ()

@end

@interface MAGHalfScreenContainerViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<MAGHalfScreenCellData *> *itemsArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *fakeBar;

@end

@implementation MAGHalfScreenContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (instancetype)initWithInputData:(MAGHalfScreenVCInputData *)inputData;
{
    self = [super init];
    if (self) {
        _itemsArray = inputData.itemsArray;
    }
    return self;
}

- (void)setUI
{
    self.containerView.layer.masksToBounds = YES;
    self.containerView.backgroundColor = [UIColor systemPinkColor];
    self.containerHeight = [self calculateContentHeight];
    self.containerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, [self containerHeight]);
    //添加头部UI
    [self addHeaderUI];
    [self.containerView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(16);
        make.left.right.equalTo(self.containerView);
        make.bottom.equalTo(self.containerView).offset([UIDevice safeAreaBottomInset]);
    }];
    self.contentView = self.tableView;
    [self.tableView reloadData];
}

- (void)addHeaderUI
{
    self.fakeBar = [[UIView alloc] init];
    self.fakeBar.backgroundColor = [UIColor blackColor];
    self.fakeBar.clipsToBounds = YES;
    self.fakeBar.layer.cornerRadius = 2;
    [self.containerView addSubview:self.fakeBar];
    [self.fakeBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@4);
        make.width.equalTo(@36);
        make.top.equalTo(self.containerView).offset(10);
        make.centerX.equalTo(self.containerView);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightHeavy];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor darkGrayColor];
    self.titleLabel.text = @"半屏面板标题";
    [self.containerView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fakeBar.mas_bottom).offset(16);
        make.centerX.equalTo(self.containerView);
        make.height.mas_equalTo(22);
    }];
}


#pragma mark - override
- (CGFloat)cornerRadius
{
    return 16.0f;
}

- (BOOL)onlyTopCornerClips
{
    return YES;;
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHalfScreenCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MAGHalfScreenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self reuseId]];
    if (cell == nil) {
        cell = [[MAGHalfScreenTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self reuseId]];
    }
    if (indexPath.row < self.itemsArray.count) {
        MAGHalfScreenCellData *item = [self.itemsArray objectAtIndex:indexPath.row];
        [cell setupWithItem:item];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.itemsArray.count) {
        MAGHalfScreenCellData *item = [self.itemsArray objectAtIndex:indexPath.row];
        if (self.selectBlock) {
            self.selectBlock(item.number);
        }
        [self dismiss];
    }
}

#pragma mark - getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:MAGHalfScreenTableViewCell.class forCellReuseIdentifier:[self reuseId]];
    }
    return _tableView;
}

- (CGFloat)calculateContentHeight
{
    CGFloat height = 68 + [UIDevice safeAreaBottomInset];
    height += self.itemsArray.count * kHalfScreenCellHeight;
    return height;
}

- (NSString *)reuseId
{
    return @"MAGHalfScreenTableViewCell";
}

@end
