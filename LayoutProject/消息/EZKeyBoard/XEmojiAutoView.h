//
//  XEmojiAutoView.h
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/26.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    emojiVertical = 0,
    emojiHorizontal
    
} XEmojiVHView;


@protocol XEmojiAutoViewDelegate <NSObject>

@required
-(void)emojiAutoBtnkey:(NSString *)btnkey value:(NSString *)value;
-(void)sendBtnClick;

@end

@interface XEmojiAutoView : UIView <UIScrollViewDelegate>
{
    UIPageControl *pageControl;
}
@property (nonatomic, assign) id<XEmojiAutoViewDelegate> delegate;

//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (assign, nonatomic) int pageBeforeRotation;
//@property (assign, nonatomic) int totalPages;


- (id)init;

@end
