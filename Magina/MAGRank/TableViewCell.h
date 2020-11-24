//
//  TableViewCell.h
//  Magina
//
//  Created by bytedance on 2020/11/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UILabel *rankLabel;
@property (nonatomic, strong) UIImageView *headPortrait;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *userData;

@end

NS_ASSUME_NONNULL_END
