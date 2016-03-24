//
//  EZEmojiView.h
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/25.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EZEmojiHelper.h"
#import "EZemojiCustomFlowLayout.h"
@protocol EZEmojiViewDelegate <NSObject>

@optional
- (void)sendBtnClick;

@required
- (void)emojiBtnKey:(NSString *)btnKey value:(NSString *)value;

@end

@interface EZEmojiView : UIView <EZemojiCustomFlowLayoutDelegate>
@property (nonatomic, assign) id<EZEmojiViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *emojiCollection;
@property (weak, nonatomic) IBOutlet UIPageControl *emojiPageControl;

@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@end
