//
//  HorizontalCollectionViewController.m
//  Magina
//
//  Created by liujinze on 2021/7/27.
//

#import "HorizontalCollectionViewController.h"
#import "HorizontalCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface HorizontalCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray<NSString *> *relateMusicList;

@end

@implementation HorizontalCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.relateMusicList = @[@"哈哈哈哈哈",@"呵呵",@"嘿嘿额嘿嘿嘿黑",@"吼吼吼吼",@"亲亲亲亲亲"];
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.estimatedItemSize = CGSizeMake(100, 60);//这个好像没啥用
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor grayColor];
//    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[HorizontalCollectionViewCell class] forCellWithReuseIdentifier:@"HorizontalCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"标题描述";
    [self.view addSubview:self.titleLabel];
    
    self.closeButton = [[UIButton alloc] init];
    [self.closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [self.closeButton setBackgroundColor:[UIColor redColor]];
    [self.closeButton addTarget:self action:@selector(closeVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeButton];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(200);
        make.left.equalTo(self.view).offset(20);
        make.height.mas_equalTo(60);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(200);
        make.height.mas_equalTo(60);
        make.left.equalTo(self.titleLabel.mas_right).offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
}

- (void)closeVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",self.relateMusicList[indexPath.item]);
}

#pragma mark - UICollectionViewDataSource
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HorizontalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HorizontalCollectionViewCell" forIndexPath:indexPath];
    [cell refreshWithName:self.relateMusicList[indexPath.item]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.relateMusicList.count;
}
#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = self.relateMusicList[indexPath.item];
    CGFloat contentWidth = [str boundingRectWithSize:CGSizeMake(300, 60)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]}
                                             context:nil].size.width;
    CGFloat cellWidth = 35 + contentWidth + 10; //左面的东西 + 字长度 + buffer
    return CGSizeMake(cellWidth, 60);
}

#pragma

@end
