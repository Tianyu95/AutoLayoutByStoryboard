//
//  EZemojiCustomFlowLayout.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/25.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "EZemojiCustomFlowLayout.h"

@implementation EZemojiCustomFlowLayout
- (void)prepareLayout {
    [super prepareLayout];
}

static const CGFloat ACTIVE_DISTANCE = 10.0f; //Distance of given cell from center of visible rect
static const CGFloat ITEM_SIZE = 40.0f; // Width/Height of cell.

- (id)init {
    if (self = [super init]) {
        // 设置该UICollectionView只支持水平滚动
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumInteritemSpacing = 0;
        self.sectionInset = UIEdgeInsetsZero;
        // 设置各分区上、下、左、右空白的大小。
        self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        // 设置UICollectionView中各单元格的大小
        self.itemSize = CGSizeMake(ITEM_SIZE, ITEM_SIZE);
        self.minimumLineSpacing = 0;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        if (CGRectIntersectsRect(attribute.frame, rect)) {
            
            CGFloat distance = CGRectGetMidX(visibleRect) - attribute.center.x;
            // Make sure given cell is center
            if (ABS(distance) < ACTIVE_DISTANCE) {
                [self.delegate collectionView:self.collectionView layout:self cellCenteredAtIndexPath:attribute.indexPath];
            }
        }
    }
    return attributes;
}
@end
