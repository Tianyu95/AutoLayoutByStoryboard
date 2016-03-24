//
//  XEmojiAutoView.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/26.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "XEmojiAutoView.h"
#import "EZEmojiHelper.h"
#import "NSObject+Property.h"

#define XEMOJIVIEWHIGHT 216

@implementation XEmojiAutoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, XEMOJIVIEWHIGHT)];
    if (self) {
//        facemap = [XQuanHelper shareInstance].emojiMap;
        self.backgroundColor = [UIColor whiteColor];
        [self emojiForVertical];
    }
    return self;
}


- (void)awakeFromNib {
    
    if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortrait
        || [[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortraitUpsideDown) {
        //竖屏
        NSLog(@"createEmojiView竖屏");
        [self emojiForVertical];
    } else {
        //横屏
        NSLog(@"createEmojiView横屏");
    }
}

//    for (int i = 0; i < [EZEmojiHelper shareInstance].emojiMap.count; i++) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.clipsToBounds = YES;
//        btn.property = [NSString stringWithFormat:@"Expression_%d", i + 1];
//        
//        btn.backgroundColor = [UIColor blackColor];
//        
//        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"Expression_%@.png",btn.property]] forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.viewFir addSubview:btn];
//        NSLog(@"btn = %@",NSStringFromCGRect(btn.frame));
//        if((i + 1) %  20== 1){
//            break;
//        }
//    }

-(void)emojiForVertical
{
    CGFloat sendbtnh = 35;
    NSMutableArray *arr = [NSMutableArray array];
    UIView *childv = nil;
    
    for (int i = 0; i < [EZEmojiHelper shareInstance].emojiMap.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.clipsToBounds = YES;
        if((i + 1) %  20== 1){
            childv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), XEMOJIVIEWHIGHT - sendbtnh - 20)];
            UIButton *dbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [dbtn setImage:[UIImage imageNamed:@"DeleteEmoticonBtn"] forState:UIControlStateNormal];
            dbtn.frame = [self getItemRect:-1];
            dbtn.property = @"delete";
            [dbtn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
            [childv addSubview:dbtn];
            [arr addObject:childv];
        }
//        if (i + 1 < 10) {
//            btn.property = [NSString stringWithFormat:@"Expression_%d", i + 1];
//        }else if(i + 1 < 100 && i + 1 >= 10){
//            btn.property = [NSString stringWithFormat:@"Expression_%d", i + 1];
//        }else if (i + 1 >= 100){
//            btn.property = [NSString stringWithFormat:@"Expression_%d", i + 1];
//        }
        btn.property = [NSString stringWithFormat:@"Expression_%d", i + 1];


        
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",btn.property]] forState:UIControlStateNormal];
        btn.frame = [self getItemRect:i];
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        [childv addSubview:btn];
    }
    
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), XEMOJIVIEWHIGHT - sendbtnh - 20)];
    sv.showsHorizontalScrollIndicator = NO;
    sv.pagingEnabled = YES;
    sv.delegate = self;
    sv.contentSize = CGSizeMake(CGRectGetWidth(sv.frame) * arr.count, CGRectGetHeight(sv.frame));
    [self addSubview:sv];
    CGRect rt = sv.frame;
    for (UIView *v in arr) {
        if (v) {
            v.frame = rt;
            [sv addSubview:v];
            rt = CGRectOffset(rt, CGRectGetWidth(rt), 0);
        }
    }
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sv.frame), CGRectGetWidth(self.frame), 20)];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:(215/255.0) green:(215/255.0) blue:(215/255.0) alpha:1];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:(46/255.0) green:(204/255.0) blue:(113/255.0) alpha:1];
    pageControl.currentPage = 0;
    pageControl.numberOfPages = arr.count;
    [self addSubview:pageControl];
    
    UIButton *send = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 3 / 4, CGRectGetMaxY(pageControl.frame), CGRectGetWidth(self.frame) / 4, sendbtnh)];
    [send setTitle:@"发送" forState:UIControlStateNormal];
    [send setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [send setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [send setBackgroundColor:[UIColor redColor]];
//    [send addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:send];
}


-(CGRect)getItemRect:(NSInteger)index
{
    NSInteger row = (index % 20) / 7;
    NSInteger column = (index % 20) % 7;
    CGRect rect = CGRectZero;
    CGFloat offset = 12;
    CGFloat facebtnw = (CGRectGetWidth(self.frame) - offset * 8) / 7;
    if(index == -1){
        rect = CGRectMake((offset + (facebtnw + offset) * 6), offset + ((facebtnw + offset) * 2), facebtnw, facebtnw);//delete btn
    }else{
        rect = CGRectMake((offset + (facebtnw + offset) *column), offset + ((facebtnw + offset) * row), facebtnw, facebtnw);// face btn
    }
    return rect;
}



// 滑动结束的事件监听
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // switch the indicator when more than 50% of the previous/next page is visible
//    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
//    NSUInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//    pageControl.currentPage = page;
//    NSLog(@"当前页面 = %lu",(unsigned long)page);
    // a possible optimization would be to unload the views+controllers which are no longer visible
    pageControl.currentPage = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
}


-(void)btnclick:(UIButton *)sender
{
    NSLog(@"%@",sender.property);
    NSString *tapStrimg = sender.property;
    if (![sender.property isEqualToString:@"delete"]) {
        tapStrimg = [NSString stringWithFormat:@"%@@2x.png",sender.property];
    }

    NSString *text = [[EZEmojiHelper shareInstance].emojiMapStr_img objectForKey:tapStrimg];
    [self.delegate emojiAutoBtnkey:sender.property value:text];
}

@end
