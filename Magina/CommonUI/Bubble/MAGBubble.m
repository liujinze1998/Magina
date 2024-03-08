//
//  MAGBubble.m
//  Magina
//
//  Created by AM on 2022/9/30.
//

#import "MAGBubble.h"
#import <Masonry/Masonry.h>

@interface MAGBubble()

@property (nonatomic, strong) UILabel *contextLabel;

@end

@implementation MAGBubble

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBlankView:)]];
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    self.contextLabel = [[UILabel alloc] init];
    self.contextLabel.text = @"内容";
    [self addSubview:self.contextLabel];
    [self.contextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 50));
        make.center.equalTo(self);
    }];
}

- (void)tapBlankView:(UIGestureRecognizer *)gesture
{
    [self removeFromSuperview];
}

@end
