//
//  EZKeyBoard.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/19.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "EZKeyBoard.h"
#import "UUProgressHUD.h"
#import "EZProgressHUD.h"
#import "UIView+FDCollapsibleConstraints.h"

#import "Masonry.h"

@implementation EZKeyBoard


//将数字转为
#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)init {
    if (self = [super init]) {
        
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib
{
    [[NSBundle mainBundle] loadNibNamed:@"EZKeyBoard" owner:self options:nil];
    [self addSubview:self.contentView];
    
    
    if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortrait
        || [[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortraitUpsideDown) {
        //竖屏
        NSLog(@"createEmojiView竖屏");
    } else {
        //横屏
        NSLog(@"createEmojiView横屏");
    }

    if (self.keyType == keyboardComment) {
        self.btnChangeVoiceState.fd_collapsed = YES;
        self.btnMore.fd_collapsed = YES;
    }
//    self.btnChangeVoiceState.fd_collapsed = YES;
//    self.btnEmoji.fd_collapsed = YES;
//    self.btnMore.fd_collapsed = YES;

    MP3 = [[Mp3Recorder alloc]initWithDelegate:self];

    [self createEmojiView];
    
    self.TextViewInput.layer.cornerRadius = 4;
    self.TextViewInput.layer.masksToBounds = YES;
    self.TextViewInput.delegate = self;
    self.TextViewInput.layer.borderWidth = 1;
    self.TextViewInput.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
    
    self.btnVoiceRecord.hidden = YES;
//    [self.btnChangeVoiceState setBackgroundImage:[UIImage imageNamed:@"chat_voice_record"] forState:UIControlStateNormal];
    
    [self.btnVoiceRecord addTarget:self action:@selector(beginRecordVoice:) forControlEvents:UIControlEventTouchDown];
    [self.btnVoiceRecord addTarget:self action:@selector(endRecordVoice:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnVoiceRecord addTarget:self action:@selector(cancelRecordVoice:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
    [self.btnVoiceRecord addTarget:self action:@selector(RemindDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [self.btnVoiceRecord addTarget:self action:@selector(RemindDragEnter:) forControlEvents:UIControlEventTouchDragEnter];

}
-(void)createEmojiView
{
    //emojiView
    self.emojiView = [[[NSBundle mainBundle] loadNibNamed:@"EZEmojiView" owner:self options:nil] lastObject];
    self.emojiView.delegate = self;
    [self.emojiView.sendBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    
    //moreview
    self.moreTool = [[[NSBundle mainBundle] loadNibNamed:@"EZMoreTool" owner:self options:nil] lastObject];
    [self.moreTool.btn1 addTarget:self action:@selector(moreBtnChekc:) forControlEvents:UIControlEventTouchUpInside];
    [self.moreTool.btn2 addTarget:self action:@selector(moreBtnChekc:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)imageViewTap:(id)sender {
    self.btnEmoji.selected = !self.btnEmoji.selected;
    self.btnMore.selected = NO;
    
    self.btnChangeVoiceState.selected = NO;

    self.btnVoiceRecord.hidden = YES;
    self.TextViewInput.hidden = NO;
    self.placeholderLabel.hidden = self.TextViewInput.hidden;

    if (self.btnEmoji.selected) {
        [self.TextViewInput resignFirstResponder];
        self.TextViewInput.inputView = self.emojiView;///////biao qing
//        self.TextViewInput.inputView = self.emojiAutoView;///////biao qing
        [self.TextViewInput becomeFirstResponder];
    } else {
        [self.TextViewInput resignFirstResponder];
        self.TextViewInput.inputView = nil;
        [self.TextViewInput becomeFirstResponder];
    }
}

- (IBAction)moreViewTap:(id)sender {
    self.btnMore.selected = !self.btnMore.selected;
    
    if (self.btnMore.selected) {
        [self.TextViewInput resignFirstResponder];
        self.TextViewInput.inputView = self.moreTool;///////biao qing
        [self.TextViewInput becomeFirstResponder];
    } else {
        [self.TextViewInput resignFirstResponder];
        self.TextViewInput.inputView = nil;
    }
}


- (IBAction)voiceRecord:(id)sender {
    self.btnChangeVoiceState.selected = !self.btnChangeVoiceState.selected;
    self.btnEmoji.selected = !self.btnChangeVoiceState.selected;
    
    if (self.btnChangeVoiceState.selected) {
        [self.TextViewInput resignFirstResponder];
    }else{
        [self.TextViewInput becomeFirstResponder];
    }
    self.btnVoiceRecord.hidden = !self.btnChangeVoiceState.selected;
    self.TextViewInput.hidden = self.btnChangeVoiceState.selected;
    self.placeholderLabel.hidden = self.TextViewInput.hidden;
}

- (void)replytext:(NSString *)textplace {
    self.textplace = textplace;
    self.placeholderLabel.text = textplace;
}

- (void)sendMessage {
    NSLog(@"sendMessage = %@",self.TextViewInput.text);
    [self.delegate keyboardSendMessage:self.TextViewInput.text];

    self.TextViewInput.text = nil;
    [self.TextViewInput resignFirstResponder];
    
}

#pragma mark - Add Picture
- (void)moreBtnChekc:(id)sender {
    UIButton *item = sender;
    switch (item.tag) {
        case 221:
            NSLog(@"Al");
            [self openPicLibrary];

            break;
        case 222:
            NSLog(@"carema");
            [self addCarema];

            break;
        default:
            break;
    }

}
-(void)addCarema{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.superVC presentViewController:picker animated:YES completion:^{}];
    }else{
        //如果没有提示用户
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tip" message:@"Your device don't have camera" delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
//        [alert show];
    }
}

-(void)openPicLibrary{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.superVC presentViewController:picker animated:YES completion:^{
        }];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *editImage = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.superVC dismissViewControllerAnimated:YES completion:^{
        [self.delegate keyboardSendPicture:editImage];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.superVC dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    //[self.TextViewInput becomeFirstResponder];
    [self.delegate keyBoardBecomeFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self sendMessage];
        [textView resignFirstResponder];
        textView.text = nil;
        return NO;
    } else if(text == nil || text.length == 0){
        NSMutableString *s = [NSMutableString stringWithString:self.TextViewInput.text];
        NSRange ranr = [s rangeOfString:@"]" options:NSBackwardsSearch];
        if(ranr.location + ranr.length == s.length){
            NSRange ranl = [s rangeOfString:@"[" options:NSBackwardsSearch];
            [s deleteCharactersInRange:NSMakeRange(ranl.location, ranr.location - ranl.location + 1)];
            self.TextViewInput.text = s;
        }else{
            return YES;
            unsigned long lengh = s.length;
            if (lengh >= 1) {
                [s deleteCharactersInRange:NSMakeRange(lengh - 1, 1)];
            }
            self.TextViewInput.text = s;
        }
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView {
    if ([self.TextViewInput.text isEqualToString:@""]) {
        self.placeholderLabel.text = self.textplace;
    } else {
        self.placeholderLabel.text = @"";
    }
}


#pragma mark - 录音touch事件
- (void)beginRecordVoice:(UIButton *)button
{
    [MP3 startRecord];
    playTime = 0;
    playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countVoiceTime) userInfo:nil repeats:YES];
    [EZProgressHUD show];
}

- (void)endRecordVoice:(UIButton *)button
{
    if (playTimer) {
        [MP3 stopRecord];
        [playTimer invalidate];
        playTimer = nil;
    }
}

- (void)cancelRecordVoice:(UIButton *)button
{
    if (playTimer) {
        [MP3 cancelRecord];
        [playTimer invalidate];
        playTimer = nil;
    }
    [EZProgressHUD dismissWithError:@"Cancel"];
}

- (void)RemindDragExit:(UIButton *)button
{
    [EZProgressHUD changeSubTitle:@"Release to cancel"];
}

- (void)RemindDragEnter:(UIButton *)button
{
    [EZProgressHUD changeSubTitle:@"Slide up to cancel"];
}


- (void)countVoiceTime
{
    playTime ++;
    if (playTime>=60) {
        [self endRecordVoice:nil];
    }
}
#pragma mark - Mp3RecorderDelegate
//回调录音资料
- (void)endConvertWithData:(NSData *)voiceData
{
    [self.delegate keyboardSendVoice:voiceData time:playTime+1];
    [EZProgressHUD dismissWithSuccess:@"Success"];//应该放在录音完成时//////////////////////

    //缓冲消失时间 (最好有block回调消失完成)
    self.btnVoiceRecord.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.btnVoiceRecord.enabled = YES;
    });
}

- (void)failRecord
{
    [EZProgressHUD dismissWithSuccess:@"Too short"];
    
    //缓冲消失时间 (最好有block回调消失完成)
    self.btnVoiceRecord.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.btnVoiceRecord.enabled = YES;
    });
}


#pragma mark - EmojiDelegate
- (void)emojiBtnKey:(NSString *)btnKey value:(NSString *)value
{
    NSRange range = [self.TextViewInput selectedRange];
    if ([btnKey isEqualToString:@"delete"]) {
        NSMutableString *s = [NSMutableString stringWithString:self.TextViewInput.text];
        NSRange ranr = [s rangeOfString:@"]" options:NSBackwardsSearch];
        if(ranr.location + ranr.length == s.length){
            NSRange ranl = [s rangeOfString:@"[" options:NSBackwardsSearch];
            [s deleteCharactersInRange:NSMakeRange(ranl.location, ranr.location - ranl.location + 1)];
            self.TextViewInput.text = s;
        }else{
            unsigned long lengh = s.length;
            if (lengh >= 1) {
                [s deleteCharactersInRange:NSMakeRange(lengh - 1, 1)];
            }
            self.TextViewInput.text = s;
        }
    }else{
        self.TextViewInput.text = [NSMutableString stringWithFormat:@"%@%@%@",
                               [self.TextViewInput.text substringWithRange:NSMakeRange(0, range.location)],
                               value,
                               [self.TextViewInput.text substringFromIndex:range.location]];
        self.TextViewInput.selectedRange = NSMakeRange(range.location + value.length, 0);
//        [self textViewDidChange:self.TextViewInput];
    }
    [self textViewDidChange:self.TextViewInput];

}
- (void)emojiAutoBtnkey:(NSString *)btnKey value:(NSString *)value
{
    NSRange range = [self.TextViewInput selectedRange];
    if ([btnKey isEqualToString:@"delete"]) {
        NSMutableString *s = [NSMutableString stringWithString:self.TextViewInput.text];
        NSRange ranr = [s rangeOfString:@"]" options:NSBackwardsSearch];
        if(ranr.location + ranr.length == s.length){
            NSRange ranl = [s rangeOfString:@"[" options:NSBackwardsSearch];
            [s deleteCharactersInRange:NSMakeRange(ranl.location, ranr.location - ranl.location + 1)];
            self.TextViewInput.text = s;
        }else{
            unsigned long lengh = s.length;
            if (lengh >= 1) {
                [s deleteCharactersInRange:NSMakeRange(lengh - 1, 1)];
            }
            self.TextViewInput.text = s;
        }
    }else{
        self.TextViewInput.text = [NSMutableString stringWithFormat:@"%@%@%@",
                                   [self.TextViewInput.text substringWithRange:NSMakeRange(0, range.location)],
                                   value,
                                   [self.TextViewInput.text substringFromIndex:range.location]];
        self.TextViewInput.selectedRange = NSMakeRange(range.location + value.length, 0);
        //        [self textViewDidChange:self.TextViewInput];
    }
    
}


@end
