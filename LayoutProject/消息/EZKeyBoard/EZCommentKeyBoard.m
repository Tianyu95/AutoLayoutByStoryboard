//
//  EZCommentKeyBoard.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/3/21.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "EZCommentKeyBoard.h"
#import "UIView+FDCollapsibleConstraints.h"

@implementation EZCommentKeyBoard

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    [self createEmojiView];

    self.TextViewInput.layer.cornerRadius = 4;
    self.TextViewInput.layer.masksToBounds = YES;
    self.TextViewInput.delegate = self;
    self.TextViewInput.layer.borderWidth = 1;
    self.TextViewInput.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];


}

-(void)createEmojiView
{
    //emojiView
    self.emojiView = [[[NSBundle mainBundle] loadNibNamed:@"EZEmojiView" owner:self options:nil] lastObject];
    self.emojiView.delegate = self;
    [self.emojiView.sendBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
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

- (IBAction)imageViewTap:(id)sender {
    self.btnEmoji.selected = !self.btnEmoji.selected;
    self.TextViewInput.hidden = NO;
    self.placeholderLabel.hidden = self.TextViewInput.hidden;
    
    if (self.btnEmoji.selected) {
        [self.TextViewInput resignFirstResponder];
        self.TextViewInput.inputView = self.emojiView;///////biao qing
        [self.TextViewInput becomeFirstResponder];
    } else {
        [self.TextViewInput resignFirstResponder];
        self.TextViewInput.inputView = nil;
        [self.TextViewInput becomeFirstResponder];
    }
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
