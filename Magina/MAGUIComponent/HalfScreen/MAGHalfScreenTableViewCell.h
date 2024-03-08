//
//  MAGHalfScreenTableViewCell.h
//  Magina
//
//  Created by AM on 2022/10/10.
//

#import <UIKit/UIKit.h>
#import "MAGHalfScreenCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAGHalfScreenTableViewCell : UITableViewCell

- (void)setupWithItem:(MAGHalfScreenCellData *)item;

@end

NS_ASSUME_NONNULL_END
