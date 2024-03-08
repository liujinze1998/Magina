//
//  HorizontalCollectionViewCell.m
//  Magina
//
//  Created by liujinze on 2021/7/27.
//

#import "HorizontalCollectionViewCell.h"
#import <Masonry/Masonry.h>

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
