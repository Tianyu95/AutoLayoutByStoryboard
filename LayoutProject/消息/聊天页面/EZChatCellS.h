//
//  EZChatCellS.h
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/15.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLEmojiLabel.h"
#import "EZChatMessageModel.h"
#import "EZAVAudioPlayer.h"


@protocol EZChatCellSDelegate <NSObject>

@optional
/**
 *  点击多媒体消息的时候统一触发这个回调
 *
 *  @param message   被操作的目标消息Model
 *  @param indexPath 该目标消息在哪个IndexPath里面
 *  @param messageTableViewCell 目标消息在该Cell上
 */

/**
 *  双击文本消息，触发这个回调
 *
 *  @param message   被操作的目标消息Model
 *  @param indexPath 该目标消息在哪个IndexPath里面
 */

/**
 *  点击消息发送者的头像回调方法
 *
 *  @param indexPath 该目标消息在哪个IndexPath里面
 */

/**
 *  Menu Control Selected Item
 *
 *  @param bubbleMessageMenuSelecteType 点击item后，确定点击类型
 */
- (void)tapVoice;

@end

@interface EZChatCellS : UITableViewCell <MLEmojiLabelDelegate, UITextViewDelegate, UIGestureRecognizerDelegate, EZAVAudioPlayerDelegate>
{
    BOOL contentVoiceIsPlaying;
    EZAVAudioPlayer *audio;

}
@property (nonatomic, assign) id <EZChatCellSDelegate> delegate;

@property (weak, nonatomic) IBOutlet MLEmojiLabel *chatContent;
@property (weak, nonatomic) IBOutlet UILabel *chatTime;
@property (weak, nonatomic) IBOutlet UIView *chatBgView;

@property (weak, nonatomic) IBOutlet UIImageView *chatImg;
@property (weak, nonatomic) IBOutlet UIButton *headerimg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatBgConstraints;
@property (weak, nonatomic) IBOutlet UIView *voiceView;
@property (weak, nonatomic) IBOutlet UIImageView *chatBgImg;
@property (weak, nonatomic) IBOutlet UIImageView *imgBg;
@property (weak, nonatomic) IBOutlet UIImageView *voiceImage;
@property (weak, nonatomic) IBOutlet UILabel *second;

@property (nonatomic, assign) EZChatMessageModel *messagedata;

@property (nonatomic, retain) UIActivityIndicatorView *indicator;

- (void)loadMessageData;

- (void)benginLoadVoice;

- (void)didLoadVoice;

-(void)stopPlay;
@end
