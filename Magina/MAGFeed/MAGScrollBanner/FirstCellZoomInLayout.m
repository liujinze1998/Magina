//
//  FirstCellZoomInLayout.m
//  Magina
//
//  Created by liujinze on 2021/11/30.
//

#import "FirstCellZoomInLayout.h"

@implementation FirstCellZoomInLayout

- (void)prepareLayout{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //获取原有的所有cell的布局信息
    NSArray *originalArr = [super layoutAttributesForElementsInRect:rect];
    //获取collectionView的相关属性
    UIEdgeInsets sectionInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:0];
    CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //因为加上了self.collectionView.contentoffset.x,所以first代表的是显示在界面上的最左边的cell
    CGRect first = CGRectMake(sectionInsets.left + self.collectionView.contentOffset.x, sectionInsets.top + self.collectionView.contentOffset.y, itemSize.width, itemSize.height);
    //需要放大的cell的大小
    CGSize firstCellSize = [self.delegate sizeForFirstCell];
    CGFloat totalOffset = 0;
    for (UICollectionViewLayoutAttributes *attributes in originalArr) {
        CGRect originFrame = attributes.frame;
        //判断两个矩形是否相交，判断cell与需要放大的cell的frame是否有相交，如果相交，需要修改cell的frame
        if (CGRectIntersectsRect(first, originFrame)) {
            //如果相交，获取两个矩形相交的区域
            CGRect insertRect = CGRectIntersection(first, originFrame);
            attributes.size = CGSizeMake(itemSize.width + (insertRect.size.width / itemSize.width) * (firstCellSize.width - itemSize.width), itemSize.height + (insertRect.size.width) / (itemSize.width) * (firstCellSize.height - itemSize.height));
           //计算因为放大第一个导致的cell的中心点的偏移量
            CGFloat currentOffsetX = attributes.size.width - itemSize.width;
            attributes.center = CGPointMake(attributes.center.x + totalOffset + currentOffsetX / 2, attributes.center.y);
            totalOffset = totalOffset + currentOffsetX;
        } else {
            //当cell的最小x值大于第一个cell的最大x值时，cell的偏移量需要加上totolOffset
            if (CGRectGetMinX(originFrame) >= CGRectGetMaxX(first)) {
                attributes.center = CGPointMake(attributes.center.x + totalOffset, attributes.center.y);
            }
        }
    }
    return originalArr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CGFloat finalPointX = 0;
    //根据最终的偏移量计算出最终停留的cell的index值，向上取整
    NSInteger index = ceil(proposedContentOffset.x / (itemSize.width + self.minimumInteritemSpacing));
    //根据index值计算出相应的偏移量
    finalPointX = (itemSize.width + self.minimumInteritemSpacing) * index;
    //得到最终停留点
    CGPoint finalPoint = CGPointMake(finalPointX, proposedContentOffset.y);
    return finalPoint;
}
@end
