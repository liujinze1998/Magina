//
//  FirstCellZoomInLayout.h
//  Magina
//
//  Created by AM on 2021/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FirstCellZoomInLayoutDelegate <UICollectionViewDelegateFlowLayout>

- (CGSize)sizeForFirstCell;

@end

@interface FirstCellZoomInLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<FirstCellZoomInLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
