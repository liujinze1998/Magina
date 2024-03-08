//
//  MAGHalfScreenTableViewCell.m
//  Magina
//
//  Created by AM on 2022/10/10.
//

#import "MAGHalfScreenTableViewCell.h"
#import <Masonry/Masonry.h>

@interface MAGHalfScreenTableViewCell()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *icon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation MAGHalfScreenTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self != nil) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    self.containerView = [[UIView alloc] init];
    self.containerView.backgroundColor = [UIColor whiteColor];
    self.containerView.layer.cornerRadius = 12;
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.icon];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.subTitleLabel];
    [self constraintsBasicUI];
}

- (void)setupWithItem:(MAGHalfScreenCellData *)item
{
    self.titleLabel.text = item.title;
    BOOL hasSubTitle = item.subTitle != nil && item.subTitle.length > 0;
    self.subTitleLabel.hidden = !hasSubTitle;
    self.subTitleLabel.text = item.subTitle;
    
    if (hasSubTitle) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.containerView).offset(15.5);
            make.height.mas_equalTo(21);
            make.left.equalTo(self.icon.mas_right).offset(16);
            make.right.equalTo(self.containerView).offset(-16);
        }];
        
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(2);
            make.height.mas_equalTo(18);
            make.left.equalTo(self.icon.mas_right).offset(16);
            make.right.equalTo(self.containerView).offset(-16);
        }];
    } else {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.containerView);
            make.height.mas_equalTo(21);
            make.left.equalTo(self.icon.mas_right).offset(16);
            make.right.equalTo(self.containerView).offset(-16);
        }];
    }
}

- (void)constraintsBasicUI
{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-8);
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(16);
        make.centerY.equalTo(self.containerView);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
}

#pragma mark - getter
- (UIView *)icon{
    if (!_icon) {
        _icon = [[UIView alloc] init];
        _icon.backgroundColor = [UIColor greenColor];
    }
    return _icon;
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.lineBreakMode = NSLineBreakByClipping;
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
        _subTitleLabel.lineBreakMode = NSLineBreakByClipping;
        _subTitleLabel.textColor = [UIColor grayColor];
    }
    return _subTitleLabel;
}

@end
