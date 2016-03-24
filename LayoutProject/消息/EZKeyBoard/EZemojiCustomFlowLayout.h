//
//  EZemojiCustomFlowLayout.h
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/25.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * The customViewFlowLayoutDelegate protocol defines methods that let you coordinate with
 *location of cell which is centered.
 */

@protocol EZemojiCustomFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

/** Informs delegate about location of centered cell in grid.
 *  Delegate should use this location 'indexPath' information to
 *   adjust it's conten associated with this cell.
 *   @param indexpath of cell in collection view which is centered.
 */

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout cellCenteredAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface EZemojiCustomFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, weak) id<EZemojiCustomFlowLayoutDelegate> delegate;

@end
