//
//  EZKeyBoard.h
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/19.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EZEmojiView.h"
#import "EZMoreTool.h"

#import "Mp3Recorder.h"

typedef enum {
    keyboardVertical = 0,
    keyboardHorizontal
    
} KBAutoSize;

typedef enum {//定义user defined runtime attributts的 keyType： number
    keyboardDefaute = 0,
    keyboardComment
} KBViewType;

@protocol EZKeyBoardDelegate <NSObject>

@optional
@required
- (void)keyBoardBecomeFirstResponder;

// text
- (void)keyboardSendMessage:(NSString *)message;

// image
- (void)keyboardSendPicture:(UIImage *)image;

// audio
- (void)keyboardSendVoice:(NSData *)voice time:(NSInteger)second;


@end

@interface EZKeyBoard : UIView <UITextViewDelegate, EZEmojiViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, Mp3RecorderDelegate>
{
    Mp3Recorder *MP3;
    NSInteger playTime;
    NSTimer *playTimer;

    BOOL isEmoji;
    UIView *bgView;
    UIPageControl *pageControlBottom;
    UICollectionView    *scrollView;
    CGFloat kscreenWidth;
    
    NSMutableArray *dataArray;
}
@property (nonatomic, assign) id<EZKeyBoardDelegate> delegate;
@property (nonatomic) int XKBautosize;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *btnChangeVoiceState;
@property (weak, nonatomic) IBOutlet UITextView *TextViewInput;
@property (weak, nonatomic) IBOutlet UIButton *btnVoiceRecord;
@property (weak, nonatomic) IBOutlet UIButton *btnEmoji;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;
@property (nonatomic, retain) UIViewController *superVC;
@property (nonatomic) KBViewType keyType;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (nonatomic, strong) NSString *textplace;
/**
 *  第三方表情View
 */
@property (nonatomic, strong) EZEmojiView *emojiView;
@property (nonatomic, strong) EZMoreTool *moreTool;

//默认为空，传值 @someone:
- (void)replytext:(NSString *)textplace;
@end
