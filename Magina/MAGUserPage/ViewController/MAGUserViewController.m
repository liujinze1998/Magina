//
//  MAGUserViewController.m
//  Magina
//
//  Created by AM on 2020/10/26.
//

#import "MAGUserViewController.h"
#import <Masonry.h>

#import "MAGUserHeaderView.h"
#import "UIDevice+MAGAdapt.h"
#import "Magina-Swift.h"
#import "People.h"

@interface MAGUserViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *addFriendsButton;//加好友

@property (nonatomic, strong) UIButton *productsTabButton;//作品tab
@property (nonatomic, strong) UIButton *updateStateTabButton;//动态tab
@property (nonatomic, strong) UIButton *favoriteTabButton;//喜欢tab

@property (nonatomic, copy) NSString *ImaName;
@property (nonatomic, assign) NSInteger num; //todo 换成枚举表示tab状态

@end

@implementation MAGUserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDataSource];
    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.collectionView reloadData];
}

- (void)initDataSource
{
    self.ImaName = @"work";
    self.num = [People SharedInstance].works;
}

#pragma mark - set UI

- (void)setUpUI
{
    [self setUpNavBar];
    [self setUpCollectionView];
}

- (void)setUpNavBar
{
    // 设置空的图片背景图片，导航栏透明 BarButtonItem显示
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    // 设置空的shadowImage
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)setUpCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(124, 168);
    flowLayout.minimumLineSpacing = 1.5;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionHeadersPinToVisibleBounds = YES;
    
    CGFloat topOffSet = self.navigationController.navigationBar.frame.size.height + [UIDevice safeAreaTopInset];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y - topOffSet, self.view.bounds.size.width, self.view.bounds.size.height + topOffSet) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [self.collectionView registerClass:[MAGUserHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return self.num;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell sizeToFit];
    UIImageView *imaView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.ImaName]];
    imaView.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    imaView.contentMode = UIViewContentModeScaleAspectFit;
    cell.backgroundColor = [UIColor blackColor];
    [cell addSubview:imaView];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && [kind isEqualToString:UICollectionElementKindSectionFooter]){
        MAGUserHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                  withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        headerView.parentVC = self;
        headerView.backgroundColor = [UIColor blackColor];
        return headerView;
    } else if (indexPath.section == 1 && [kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *switchSourceTabHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                  withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        for (UIView *view in switchSourceTabHeaderView.subviews) {
            [view removeFromSuperview];
        }
        switchSourceTabHeaderView.backgroundColor =[UIColor blackColor];
        [switchSourceTabHeaderView addSubview:self.productsTabButton];
        [switchSourceTabHeaderView addSubview:self.updateStateTabButton];
        [switchSourceTabHeaderView addSubview:self.favoriteTabButton];

        [self.productsTabButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(switchSourceTabHeaderView.mas_centerY);
            make.left.equalTo(switchSourceTabHeaderView.mas_left).offset(20);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
        [self.updateStateTabButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(switchSourceTabHeaderView.mas_centerY);
            make.centerX.equalTo(switchSourceTabHeaderView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
        
        [self.favoriteTabButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(switchSourceTabHeaderView.mas_centerY);
            make.right.equalTo(switchSourceTabHeaderView.mas_right).offset(-20);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
        return switchSourceTabHeaderView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height * 0.05);
    } else {
        return CGSizeMake(0, 0);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height * 0.4);
    } else {
        return CGSizeMake(0, 0);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffSetY = scrollView.contentOffset.y;
//    CGFloat imageHeight = self.headerView.userBackgrondButton.bounds.size.height;
//    CGFloat imageWidth = self.headerView.userBackgrondButton.bounds.size.width;
//
//    //下拉
//    if (contentOffSetY < 0) {
//        CGFloat totalHeight = imageHeight + ABS(contentOffSetY);
//        CGFloat multiple = totalHeight / imageHeight;
//        CGFloat totalWidth = imageWidth * multiple;
//        self.headerView.userBackgrondButton.frame = CGRectMake(-(totalWidth - imageWidth) * 0.5, contentOffSetY, totalWidth, totalHeight);
//    }
}

#pragma mark - action

- (void)productsTabButtonClicked
{
    self.ImaName = @"work";
    self.num = [People SharedInstance].works;
    [self.collectionView reloadData];
}

- (void)updateStateTabButtonClicked
{
    //动态tab todo更新
}

- (void)favoriteTabButtonClicked
{
    self.ImaName = @"touxiang";
    self.num = [People SharedInstance].like;
    [self.collectionView reloadData];
}

#pragma mark - UI load

- (UIButton *)productsTabButton;
{
    if (!_productsTabButton) {
        _productsTabButton = [[UIButton alloc] init];
        _productsTabButton.backgroundColor = [UIColor blackColor];
        [_productsTabButton setTitle:[[NSString alloc] initWithFormat:@"作品%ld", [People SharedInstance].works] forState:UIControlStateNormal];
        [_productsTabButton addTarget:self action:@selector(productsTabButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _productsTabButton;
}

- (UIButton *)updateStateTabButton
{
    if (!_updateStateTabButton) {
        _updateStateTabButton = [[UIButton alloc] init];
        _updateStateTabButton.backgroundColor = [UIColor blackColor];
        [_updateStateTabButton setTitle:[[NSString alloc] initWithFormat:@"动态%ld", [People SharedInstance].dyna] forState:UIControlStateNormal];
        [_favoriteTabButton addTarget:self action:@selector(updateStateTabButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _updateStateTabButton;
}

- (UIButton *)favoriteTabButton
{
    if (!_favoriteTabButton) {
        _favoriteTabButton = [[UIButton alloc] init];
        _favoriteTabButton.backgroundColor = [UIColor blackColor];
        [_favoriteTabButton setTitle:[[NSString alloc] initWithFormat:@"喜欢%ld", [People SharedInstance].like] forState:UIControlStateNormal];
        [_favoriteTabButton addTarget:self action:@selector(favoriteTabButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _favoriteTabButton;
}

@end
