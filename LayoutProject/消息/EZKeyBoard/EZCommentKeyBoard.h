//
//  EZCommentKeyBoard.h
//  LayoutProject
//
//  Created by ChenTianyu on 16/3/21.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EZEmojiView.h"

@protocol EZCommentKeyBoardDelegate <NSObject>

@optional
@required
- (void)keyBoardBecomeFirstResponder;

// text
- (void)keyboardSendMessage:(NSString *)message;

@end

@interface EZCommentKeyBoard : UIView <UITextViewDelegate, EZEmojiViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    BOOL isEmoji;
    UIView *bgView;
    UIPageControl *pageControlBottom;
    UICollectionView    *scrollView;
    CGFloat kscreenWidth;
    
    NSMutableArray *dataArray;
}

@property (weak, nonatomic) IBOutlet UITextView *TextViewInput;
@property (weak, nonatomic) IBOutlet UIButton *btnEmoji;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (nonatomic, strong) NSString *textplace;

@property (nonatomic, assign) id<EZCommentKeyBoardDelegate> delegate;

/**
 *  第三方表情View
 */
@property (nonatomic, strong) EZEmojiView *emojiView;

@end
