//
//  FirstCellZoomInContainerView.m
//  Magina
//
//  Created by liujinze on 2021/11/30.
//

#import "FirstCellZoomInContainerView.h"
#import "FirstCellZoomInLayout.h"
#import <Masonry/Masonry.h>

@interface FirstCellZoomInContainerView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,FirstCellZoomInLayoutDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray<NSString *> *contentList;

@end

@implementation FirstCellZoomInContainerView

- (instancetype)init{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupContainer];
    }
    return self;
}

- (CGSize)sizeForFirstCell{
    return CGSizeMake(150, 150);
}

- (void)setupContainer{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"首个cell自动放大";
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(10);
        make.height.mas_equalTo(60);
    }];
    
    FirstCellZoomInLayout *layout = [[FirstCellZoomInLayout alloc] init];
    layout.delegate = self;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor grayColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.decelerationRate = 0.9;
    [self.collectionView registerClass:[RectCollectionViewCell class] forCellWithReuseIdentifier:@"RectCollectionViewCell"];
    [self addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self).offset(-10);
        make.height.mas_equalTo(210);
    }];
}

#pragma mark - UICollectionViewDelegate / UICollectionViewDataSource
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RectCollectionViewCell" forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(80, 80);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 1, 50, 1);
}

@end

#pragma mark - cell

@implementation RectCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor purpleColor];
    }
    return self;
}

@end
