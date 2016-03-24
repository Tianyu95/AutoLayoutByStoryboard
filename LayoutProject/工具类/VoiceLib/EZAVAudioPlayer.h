//
//  EZAVAudioPlayer.h
//  BloodSugarForDoc
//
//  Created by shake on 14-9-1.
//  Copyright (c) 2014年 shake. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>


@protocol EZAVAudioPlayerDelegate <NSObject>

- (void)EZAVAudioPlayerBeiginLoadVoice;
- (void)EZAVAudioPlayerBeiginPlay;
- (void)EZAVAudioPlayerDidFinishPlay;

@end

@interface EZAVAudioPlayer : NSObject
@property (nonatomic ,strong)  AVAudioPlayer *player;
@property (nonatomic, assign)id <EZAVAudioPlayerDelegate>delegate;
+ (EZAVAudioPlayer *)sharedInstance;

-(void)playSongWithUrl:(NSString *)songUrl;
-(void)playSongWithData:(NSData *)songData;

- (void)stopSound;
@end
