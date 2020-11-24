//
//  MyHeaderView.m
//  MyTableView
//
//  Created by bytedance on 2020/10/15.
//

#import "MyHeaderView.h"
#import <Masonry.h>
#import "DataArray.h"
#import "RankData.h"
#import "MAGRankViewController.h"

@implementation MyHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 200);
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"work.jpeg"]];
        [self addSubview:backImage];
        backImage.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-44-5);
        backImage.userInteractionEnabled = YES;
        RankData* item = [DataArray sharedInstance].dataList[5];
        UIView *backView = [[UIView alloc] init];
        [self addSubview:backView];
        backView.userInteractionEnabled = YES;
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).with.offset(-5);
            make.left.equalTo(self.mas_left);
            make.size.mas_equalTo(CGSizeMake(self.frame.size.width, 44));
        }];
        backView.backgroundColor = [UIColor whiteColor];
        NSDate *date = [NSDate date];
        NSTimeZone *timeZone=[NSTimeZone systemTimeZone];
        NSInteger interval=[timeZone secondsFromGMTForDate:date];
        NSDate * localdate=[date dateByAddingTimeInterval:interval];
        NSDateFormatter *f=[NSDateFormatter new];
        f.dateFormat=@"yyyy年MM月dd日";
        NSString *strdate=[f stringFromDate:localdate];
        NSLog(@"%@",strdate);
        UILabel *dateLabel = [[UILabel alloc] init];
        dateLabel.text = strdate;
        dateLabel.textColor = [UIColor whiteColor];
        [backImage addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backImage.mas_left).with.offset(20);
            make.top.equalTo(backImage.mas_top).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(300, 40));
        }];
        UILabel *rankLabel = [[UILabel alloc] init];
        rankLabel.text = [[NSString alloc] initWithFormat:@"6"];
        [backView addSubview:rankLabel];
        [rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backView.mas_left).with.offset(16);
            make.top.equalTo(backView.mas_top);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        UIImageView *headPortrait =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"touxiang.jpeg"]];
        [backView addSubview:headPortrait];
        [headPortrait mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rankLabel.mas_left).with.offset(32);
            make.top.equalTo(rankLabel.mas_top);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.text = item.name;
        [backView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headPortrait.mas_right).with.offset(16);
            make.top.equalTo(headPortrait.mas_top);
            make.size.mas_equalTo(CGSizeMake(150, 50));
        }];
        UILabel *userData = [[UILabel alloc]init];
        userData.text = [[NSString alloc] initWithFormat:@"%ld",item.dataNumber];
        userData.textColor = [UIColor blackColor];
        [backView addSubview:userData];
        userData.textAlignment=NSTextAlignmentRight;
        [userData mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(backView.mas_right).with.offset(-36);
            make.top.equalTo(headPortrait.mas_top);
            make.size.mas_equalTo(CGSizeMake(150, 50));
        }];
        _alertButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
        _alertButton.showsTouchWhenHighlighted=YES;
        _alertButton.adjustsImageWhenHighlighted=YES;
        [backImage addSubview:_alertButton];
        [_alertButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(dateLabel.mas_centerY).with.offset(0);
            make.right.equalTo(backImage.mas_right).with.offset(-10);
            make.size.mas_equalTo(CGSizeMake(22, 15));
        }];
        [_alertButton setTitle:@"···" forState:UIControlStateNormal];
    }
    return self;
}

@end
