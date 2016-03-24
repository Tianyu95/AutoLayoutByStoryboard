//
//  EZChatCellR.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/15.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "EZChatCellR.h"
#import "UIView+FDCollapsibleConstraints.h"

@implementation EZChatCellR

- (void)awakeFromNib {
    // Initialization code
    
    self.chatTime.layer.cornerRadius = 5;
    self.chatTime.layer.masksToBounds = YES;

    self.headerimg.layer.cornerRadius = 25;
    self.headerimg.layer.masksToBounds = YES;

    self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.indicator.center=CGPointMake(80, 15);

    
    self.chatContent.emojiDelegate = self;
    self.chatContent.lineBreakMode = NSLineBreakByCharWrapping;//非常重要的一个属性，开启才图文对齐
    self.chatContent.textAlignment = NSTextAlignmentJustified;
    self.chatContent.disableThreeCommon = NO;
    self.chatContent.isNeedAtAndPoundSign = YES;
    [self.chatContent setCustomEmojiRegex:@"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]"];
    [self.chatContent setCustomEmojiPlistName:@"TTTexpression"];
    
    UITapGestureRecognizer *tapVoice = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapChatVoice:)];
    tapVoice.delegate = self;
    tapVoice.numberOfTouchesRequired = 1;
    [self.voiceView addGestureRecognizer:tapVoice];
    
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapChatImage:)];
    tapImage.delegate = self;
    tapImage.numberOfTouchesRequired = 1;
    [self.chatImg addGestureRecognizer:tapImage];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(EZAVAudioPlayerDidFinishPlay) name:@"VoicePlayHasInterrupt" object:nil];
    
    //红外线感应监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sensorStateChange:)
                                                 name:UIDeviceProximityStateDidChangeNotification
                                               object:nil];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMessagedata:(EZChatMessageModel *)messagedata {
    
    self.imgBg.image = nil;
    self.chatBgImg.image = nil;
    self.chatContent.text = nil;
    self.second.text = nil;//[NSString stringWithFormat:@"%@'s Voice",self.messagedata.voice_duration];
    self.voiceImage.image = nil;//[UIImage imageNamed:@"chat_animation3"];
    
    self.chatImg.image = nil;
    
    
    self.chatTime.fd_collapsed = YES;
    self.chatBgView.fd_collapsed = YES;
    self.voiceView.fd_collapsed = YES;
    self.chatImg.fd_collapsed = YES;
    
    switch (messagedata.mediaType) {
        case EZMessageMediaTypeText:
            self.chatBgView.fd_collapsed = NO;
            self.chatTime.fd_collapsed = NO;

            self.chatBgImg.image = [UIImage imageNamed:@"chatfrom_bg_normal.png"];
            [self.chatContent setEmojiText:messagedata.content];
            self.imgBg.image = nil;
            break;
        case EZMessageMediaTypePhoto:
            self.chatImg.fd_collapsed = NO;
            self.chatImg.image = [UIImage imageNamed:@"9"];
            self.imgBg.image = [UIImage imageNamed:@"chatfrom_bg_normal"];
            [self makeMaskView:self.chatImg withImage:self.imgBg.image];
            break;
        case EZMessageMediaTypeVoice:
            self.chatBgImg.image = nil;
            self.imgBg.image = nil;
            self.voiceView.fd_collapsed = NO;
            self.chatContent.text = @"";
            self.voiceImage.image = [UIImage imageNamed:@"chat_animation3"];
            self.voiceImage.animationImages = [NSArray arrayWithObjects:
                                               [UIImage imageNamed:@"chat_animation_white1"],
                                               [UIImage imageNamed:@"chat_animation_white2"],
                                               [UIImage imageNamed:@"chat_animation_white3"],nil];
            self.voiceImage.animationDuration = 1;
            self.voiceImage.animationRepeatCount = 0;
            self.second.text = [NSString stringWithFormat:@"%@'s Voice",messagedata.voice_duration];
//            [self didLoadVoice];
            break;
        default:
            break;
    }
    
    if (messagedata.image_id.length > 0) {
    } else if (messagedata.voice_id) {
    } else if (messagedata.content.length >0) {
    }
    
//    if (self.chatBgView.fd_collapsed) {
//        self.chatBgConstraints.priority = 249;
//    } else {
//        self.chatBgConstraints.priority = 1000;
//    }
    

        NSString *hstr = [NSString stringWithFormat:@"headTest%d",2];
        [self.headerimg setImage:[UIImage imageNamed:hstr] forState:UIControlStateNormal];
}

- (void)makeMaskView:(UIView *)view withImage:(UIImage *)image
{
    CGRect itemFrame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    UIImageView *imageViewMask = [[UIImageView alloc] initWithImage:image];
    imageViewMask.frame = CGRectInset(itemFrame, 0.0f, 0.0f);
    view.layer.mask = imageViewMask.layer;
}

- (void)didLoadVoice
{
    self.voiceImage.hidden = NO;
    [self.indicator stopAnimating];
    [self.voiceImage startAnimating];
}
-(void)stopPlay
{
    //    if(self.voice.isAnimating){
    [self.voiceImage stopAnimating];
    //  leonardo dicaprio  }
}

#pragma mark - MLEmojiLabelDelegate(评论 + 内容点的击事件处理)
- (void)mlEmojiLabel:(MLEmojiLabel*)emojiLabel didSelectLink:(NSString*)link withType:(MLEmojiLabelLinkType)type
{
    switch(type){
        case MLEmojiLabelLinkTypeURL://URL
            NSLog(@"点击了链接%@",link);
            break;
        case MLEmojiLabelLinkTypePhoneNumber://phone
            NSLog(@"点击了电话%@",link);
            break;
        case MLEmojiLabelLinkTypeEmail://Email
            NSLog(@"点击了邮箱%@",link);
            break;
        case MLEmojiLabelLinkTypeAt://@
            NSLog(@"点击了用户%@",link);
            break;
        case MLEmojiLabelLinkTypePoundSign://#
            NSLog(@"点击了话题%@",link);
            break;
        case MLEmojiLabelLinkTypeAppointedcharacters://appointedText
            NSLog(@"点击了指定文字%@",link);
            break;
        case MLEmojiLabelLinkTypeExpectForAppointRegion://otherRegion
            NSLog(@"--");
            break;
    }
}
- (void)tapChatImage:(UITapGestureRecognizer *)sender {
    NSLog(@"chatimage");
}
- (void)tapChatVoice:(UITapGestureRecognizer *)sender {
    NSLog(@"tapChatVoice");

    if(!contentVoiceIsPlaying){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"VoicePlayHasInterrupt" object:nil];
        contentVoiceIsPlaying = YES;
        audio = [EZAVAudioPlayer sharedInstance];
        audio.delegate = self;
        //        [audio playSongWithUrl:voiceURL];
        [audio playSongWithData:self.messagedata.voice_id];
    }else{
        [self EZAVAudioPlayerDidFinishPlay];
    }
}

////////////////////////////////
- (void)EZAVAudioPlayerBeiginLoadVoice
{
    [self benginLoadVoice];
}
- (void)EZAVAudioPlayerBeiginPlay
{
    //开启红外线感应
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    [self didLoadVoice];
}
- (void)EZAVAudioPlayerDidFinishPlay
{
    //关闭红外线感应
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    contentVoiceIsPlaying = NO;
    [self stopPlay];
    [[EZAVAudioPlayer sharedInstance] stopSound];
}
/////////
//处理监听触发事件
-(void)sensorStateChange:(NSNotificationCenter *)notification;
{
    if ([[UIDevice currentDevice] proximityState] == YES){
        NSLog(@"Device is close to user");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    }
    else{
        NSLog(@"Device is not close to user");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
}
@end
