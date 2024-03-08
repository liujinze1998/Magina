//
//  AdaptiveContentContainerView.m
//  Magina
//
//  Created by AM on 2021/11/30.
//

#import <Masonry/Masonry.h>
#import "AdaptiveContentContainerView.h"

@interface AdaptiveContentContainerView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray<NSString *> *contentList;

@end

@implementation AdaptiveContentContainerView

- (instancetype)init{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentList = @[@"哈哈哈哈哈",@"呵",@"嘿嘿",@"吼吼吼吼",@"啊",@"时尚大师大所",@"很长很长很长很长很长很长很长"];
        [self setupContainer];
    }
    return self;
}

- (void)setupContainer{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"cell自适应内容宽度";
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(10);
        make.height.mas_equalTo(60);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.estimatedItemSize = CGSizeMake(100, 60);//这个好像没啥用
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor grayColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[HorizontalCollectionViewCell class] forCellWithReuseIdentifier:@"HorizontalCollectionViewCell"];
    [self addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(60);
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self).offset(-10);
    }];
}

#pragma mark - UICollectionViewDelegate / UICollectionViewDataSource / UICollectionViewDelegateFlowLayout
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HorizontalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HorizontalCollectionViewCell" forIndexPath:indexPath];
    [cell refreshWithName:self.contentList[indexPath.item]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.contentList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = self.contentList[indexPath.item];
    CGFloat contentWidth = [str boundingRectWithSize:CGSizeMake(300, 60)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]}
                                             context:nil].size.width;
    CGFloat cellWidth = 35 + contentWidth + 10; //左面的东西 + 字长度 + buffer
    return CGSizeMake(cellWidth, 60);
}

@end

#pragma mark - cell

@interface HorizontalCollectionViewCell()

@property (nonatomic, strong) UIView *imageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation HorizontalCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)refreshWithName:(NSString *)name{
    self.nameLabel.text = name;
    [self.nameLabel sizeToFit];
}

#pragma mark - ui

- (void)setUI{
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.nameLabel];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).offset(5);
        make.centerY.equalTo(self.contentView);
    }];
}

- (UIView *)imageView{
    if (!_imageView) {
        _imageView = [[UIView alloc] init];
        _imageView.backgroundColor = [UIColor greenColor];
    }
    return _imageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"还没内容";
    }
    return _nameLabel;
}

@end
