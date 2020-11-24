//
//  TableViewCell.m
//  Magina
//
//  Created by bytedance on 2020/11/8.
//

#import "TableViewCell.h"
#import <Masonry.h>

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellView = [[UIView alloc]initWithFrame:self.frame];
        [self addSubview:_cellView];
        _rankLabel = [[UILabel alloc]init];
        [_cellView addSubview:_rankLabel];
        [_rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_cellView.mas_left).with.offset(16);
            make.centerY.equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        _headPortrait = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"touxiang.jpeg"]];
        _headPortrait.contentMode = UIViewContentModeScaleAspectFit;
        [_cellView addSubview:_headPortrait];
        [_headPortrait mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_rankLabel.mas_left).with.offset(32);
            make.centerY.equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        _nameLabel = [[UILabel alloc]init];
        [_cellView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_headPortrait.mas_right).with.offset(16);
            make.centerY.equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(150, 50));
        }];
        _userData = [[UILabel alloc]init];
        _userData.textColor = [UIColor blackColor];
        [_cellView addSubview:_userData];
        _userData.textAlignment=NSTextAlignmentRight;
        [_userData mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self->_cellView.mas_right).with.offset(16);
            make.centerY.equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(150, 50));
        }];
    }
    return self;
}

@end
