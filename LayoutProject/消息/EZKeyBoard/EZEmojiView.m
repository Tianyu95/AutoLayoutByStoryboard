//
//  EZEmojiView.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/25.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "EZEmojiView.h"
#import "EZEmojiCollectionViewCell.h"

@implementation EZEmojiView

static NSString * const reuseIdentifier = @"EZEmojiCollectionViewCell";

-(void)awakeFromNib
{
    [self.emojiCollection registerNib:[UINib nibWithNibName:@"EZEmojiCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    EZemojiCustomFlowLayout *flowLayout = [[EZemojiCustomFlowLayout alloc]init];
    flowLayout.delegate = self;
    self.emojiCollection.collectionViewLayout = flowLayout;
    
    self.sendBtn.layer.cornerRadius = 5;
    self.sendBtn.layer.masksToBounds = YES;

}

- (IBAction)deleteCheck:(id)sender {
    [self.delegate emojiBtnKey:@"delete" value:@""];

}


#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [EZEmojiHelper shareInstance].emojiMap.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    EZEmojiCollectionViewCell *cell = (EZEmojiCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
     [[EZEmojiHelper shareInstance].emojiMapImg_str objectForKey:@""];
    cell.emojiImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"Expression_%ld",indexPath.row +1 + indexPath.section*36]];
    
    // Configure the cell
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectItemAtIndexPath = %ld",indexPath.row);
    NSString *tapStrimg = [NSString stringWithFormat:@"Expression_%ld@2x.png",indexPath.row+1];
    NSString *text = [[EZEmojiHelper shareInstance].emojiMapStr_img objectForKey:tapStrimg];
    NSLog(@"%@ == %@",tapStrimg,text);    
    [self.delegate emojiBtnKey:tapStrimg value:text];
}

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

#pragma mark - 实现CustomViewFlowLayoutDelegate
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout cellCenteredAtIndexPath:(NSIndexPath *)indexPath page:(int)page{
    self.emojiPageControl.currentPage = page; // 分页控制器当前显示的页数
    
}
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout cellCenteredAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"index = %ld",indexPath.row);
    
    self.emojiPageControl.currentPage = indexPath.row*3/[EZEmojiHelper shareInstance].emojiMap.count;
}




@end
