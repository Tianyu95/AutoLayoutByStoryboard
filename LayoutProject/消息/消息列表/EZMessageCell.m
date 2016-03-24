//
//  EZMessageCell.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/4.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "EZMessageCell.h"

@implementation EZMessageCell

- (void)awakeFromNib {
    // Initialization code
    
    self.userPic.clipsToBounds = YES;
    self.userPic.layer.cornerRadius = CGRectGetWidth(self.userPic.frame) / 2;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMessagedata:(EZChatMessageModel *)messagedata {
    
    self.nameLabel.text = messagedata.chat_name;
    if (messagedata.content.length >0) {
        self.contentLabel.text = messagedata.content;
    } else if (messagedata.image_id.length >0) {
        self.contentLabel.text = @"send a photo";
    } else if (messagedata.voice_id) {
        self.contentLabel.text = @"send a voice";
    }
}
@end
