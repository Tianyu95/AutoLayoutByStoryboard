//
//  XZoneViewCell.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/1.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "XZoneViewCell.h"
#import "XZoneMode.h"
#import "UIView+FDCollapsibleConstraints.h"
#import "MLEmojiLabel.h"
#import "XQuanTool.h"

@interface XZoneViewCell()<MLEmojiLabelDelegate>

/**  转发提示容器   */
@property (weak, nonatomic) IBOutlet UIView *forwardRemindConstraint;
/**  转发提示文字   */
@property (weak, nonatomic) IBOutlet UILabel *forwardRemindLabel;

/**  头像   */
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImage;
/**  姓名   */
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
/**  时间   */
@property (weak, nonatomic) IBOutlet UILabel *userTimeLabel;
/**  标签   */
@property (weak, nonatomic) IBOutlet UILabel *userMarkLabel;

/**  内容文本   */
@property (weak, nonatomic) IBOutlet MLEmojiLabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelTrailing;

/**  收起 或 全文   */
@property (weak, nonatomic) IBOutlet UILabel *packUpOrFullTextLabel;


@property (weak, nonatomic) IBOutlet UIView *imageBigConstaint;

/**  第一个图片容器   */
@property (weak, nonatomic) IBOutlet UIView *imageConstaintOne;
/**  第二个图片容器   */
@property (weak, nonatomic) IBOutlet UIView *imageConstaintTwo;
/**  第三个图片容器   */
@property (weak, nonatomic) IBOutlet UIView *imageConstaintThree;

/**  图片1到9   */
@property (weak, nonatomic) IBOutlet UIImageView *imageOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageThree;
@property (weak, nonatomic) IBOutlet UIImageView *imageFour;
@property (weak, nonatomic) IBOutlet UIImageView *imageFive;
@property (weak, nonatomic) IBOutlet UIImageView *imageSix;
@property (weak, nonatomic) IBOutlet UIImageView *imageSeven;
@property (weak, nonatomic) IBOutlet UIImageView *imageEight;
@property (weak, nonatomic) IBOutlet UIImageView *imageNine;

/**  赞、评论、转发、更多   */
@property (weak, nonatomic) IBOutlet UIButton *praiseButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;


/**  评论1到4   */
@property (weak, nonatomic) IBOutlet MLEmojiLabel *commentOneLabel;
@property (weak, nonatomic) IBOutlet MLEmojiLabel *commentTwoLabel;
@property (weak, nonatomic) IBOutlet MLEmojiLabel *commentThreeLabel;
@property (weak, nonatomic) IBOutlet MLEmojiLabel *commentFourLabel;

@end

@implementation XZoneViewCell

#pragma mark - 创建Cell
+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView{

    static NSString *identifer = @"XZoneViewCell";
    XZoneViewCell *zoneViewCell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if ( zoneViewCell == nil ) {
        
        zoneViewCell = [[[NSBundle mainBundle] loadNibNamed:@"XZoneViewCell" owner:nil options:nil] lastObject];
        
    }
    return zoneViewCell;
}

#pragma mark - 加载Xib会调用，在这里初始化
- (void)awakeFromNib{//在这里解决一些初始化问题
    
    // 0.cell点击没有颜色
    self.selectionStyle =UITableViewCellSelectionStyleNone;
    
    // 1.头像切成圆角形式
    self.userHeaderImage.layer.cornerRadius = 23;

    // 2.设置姓名、标签文字的颜色
    [self.userNameLabel setTextColor:[UIColor colorWithRed:69/255.0 green:85/255.0 blue:132/255.0 alpha:1]];
    [self.userMarkLabel setTextColor:[UIColor colorWithRed:69/255.0 green:85/255.0 blue:132/255.0 alpha:1]];
    
    // 3.设置文本内容文字字体大小
    self.contentLabel.font = [UIFont systemFontOfSize:contentLabelFont];
    self.contentLabel.emojiDelegate = self;
    self.contentLabel.lineBreakMode = NSLineBreakByCharWrapping;//非常重要的一个属性，开启才图文对齐
    self.contentLabel.textAlignment = NSTextAlignmentJustified;
    self.contentLabel.disableThreeCommon = NO;
    self.contentLabel.isNeedAtAndPoundSign = YES;
    [self.contentLabel setCustomEmojiRegex:@"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]"];
    [self.contentLabel setCustomEmojiPlistName:@"TTTexpression"];
    
    // 4.设置收起或全文
    self.packUpOrFullTextLabel.font = [UIFont systemFontOfSize:contentLabelFont];
    [self.packUpOrFullTextLabel setTextColor:[UIColor colorWithRed:69/255.0 green:75/255.0 blue:165/255.0 alpha:1]];
    self.packUpOrFullTextLabel.text = nil;
    self.packUpOrFullTextLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickPackUpOrFullTextLabel:)];
    [self.packUpOrFullTextLabel addGestureRecognizer:tapGesture];

    
    // 5.统一设置评论字体大小 + 代理
    self.commentOneLabel.font = [UIFont systemFontOfSize:14];
    self.commentOneLabel.emojiDelegate = self;
    self.commentOneLabel.disableThreeCommon = YES;
    [self.commentOneLabel setCustomEmojiRegex:@"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]"];
    [self.commentOneLabel setCustomEmojiPlistName:@"TTTexpression"];
    
    self.commentTwoLabel.font = [UIFont systemFontOfSize:14];
    self.commentTwoLabel.emojiDelegate = self;
    self.commentTwoLabel.disableThreeCommon = YES;
    [self.commentTwoLabel setCustomEmojiRegex:@"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]"];
    [self.commentTwoLabel setCustomEmojiPlistName:@"TTTexpression"];
    
    self.commentThreeLabel.font = [UIFont systemFontOfSize:14];
    self.commentThreeLabel.emojiDelegate = self;
    self.commentThreeLabel.disableThreeCommon = YES;
    [self.commentThreeLabel setCustomEmojiRegex:@"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]"];
    [self.commentThreeLabel setCustomEmojiPlistName:@"TTTexpression"];
    
    self.commentFourLabel.font = [UIFont systemFontOfSize:14];
    self.commentFourLabel.emojiDelegate = self;
    self.commentFourLabel.disableThreeCommon = YES;
    [self.commentFourLabel setCustomEmojiRegex:@"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]"];
    [self.commentFourLabel setCustomEmojiPlistName:@"TTTexpression"];
    
    
}

#pragma mark - 重写set方法
- (void)setZoneMode:(XZoneMode *)zoneMode{

    _zoneMode = zoneMode;
    
    // 1.设置转发提示信息约束 并 对其传入数据
    [self setForwardRemindLayoutAndPassData];

    // 2.设置用户信息约束 并 传入数据
    [self setUserIfoLayoutAndPassData];
    
    // 3.设置文本内容约束 并 传入数据
    [self setContentLabelLayoutAndPassData];
    
    // 4.设置图片容器信息约束 并 对图片传入数据
    [self setImageConstaintLayoutAndPassData];

    // 5.设置赞、评论、转发工具栏容器约束 并 传入数据
    [self setToolBarLayoutAndPassData];
    
    // 6.设置约束 并 传入数据
    [self setCommentLayoutAndPassData];

    
}

#pragma mark - 设置转发信息
/**  设置转发提示信息约束 并 传入数据   */
- (void)setForwardRemindLayoutAndPassData{

    if ( _zoneMode.forwardRemindText == nil || _zoneMode.forwardRemindText.length == 0) {
        // 如果不是转发，则收起转发容器
        self.forwardRemindConstraint.fd_autoCollapse = YES;
    }else{
        
        // 如果是转发，则附上转发文字
        self.forwardRemindLabel.text = _zoneMode.forwardRemindText;
    }
}

#pragma mark - 设置用户信息(头像时间部分)
/**  设置给用户信息约束 并 传入数据   */
- (void)setUserIfoLayoutAndPassData{

    // 如果头像存在着设置，不存在不用管，因为XIB已经设置好了站位图片
    if ( _zoneMode.userHeaderImageName!= nil && _zoneMode.userHeaderImageName.length!=0 ) {
        self.userHeaderImage.image = [UIImage imageNamed:_zoneMode.userHeaderImageName];//头像
    }
    self.userNameLabel.text = _zoneMode.userNameText;//名字
    self.userMarkLabel.text = _zoneMode.userMarkText;//标签
    self.userTimeLabel.text = _zoneMode.userTimeText;//时间
}

#pragma mark - 设置文本内容
/**  设置文本内容约束 并 传入数据   */
- (void)setContentLabelLayoutAndPassData{
    
    if ( _zoneMode.isShowFullText == NO ) {//这个属性为NO，说明:若超出文字,则不显示全部文字
        
        if ( _zoneMode.modifyContentText != nil ) {//如果这个存放修改数据的这个属性不为nil，说明是超出136文字的label

            // 那么设置这个label的内容为 修改后的残文
            [self.contentLabel setEmojiText:_zoneMode.modifyContentText];
            // 那么设置收起或全文的这个label内部文字为 全文
            self.packUpOrFullTextLabel.text = @"   全文";
            
        }
        
    }else{//这个属性为Yes，说明:若超出文字，则显示全文
        
        // 统一让所有的label接受原contentText文属性(即：无论文字数量多少，都按照原来的文字显示)
        [self.contentLabel setEmojiText:_zoneMode.contentText];
        
        if ( _zoneMode.modifyContentText != nil ) {//这个属性不为nil,说明当前这个label是文字超出136的label
            
            // 那么设置收起或全文的这个label内部文字为 收起
            self.packUpOrFullTextLabel.text = @"   收起";
        }
        
    }

}

/**  收起或全文点击事件   */
- (void)didClickPackUpOrFullTextLabel:(UILabel *)label{

    // 关键属性，当点击收起或全文时，代理传出去，会在控制器里调用reloadData方法进行数据刷新并且重新计算Cell高度。 那么会再次进入当前Cell中重写的模型set方法，而在这个set方法中，就是通过isShowFullText这个属性来判断——>当前大于136个字的文本应该展示全文还是残文 和 点击的label文字应该显示收起还是全文。 总是，思路如下：1.点击收起或全文label后，仅仅是通过代理方法，让控制器调用reloadDate方法重写给cell数据并计算cell高度(如果不用这样的方法，点击全文后收起label后直接改变文本内容，仅仅能改变文字，但是cell高度无法计算) 2.所以文本内容从全文和残文之间的转化 以及 收起或全文这个label内文字的改变并不是在点击后改变的，而是在重写的set模型方法中，提前写的好的，根据isShowFullText这个属性先做好判断，然后实现什么时候显示全文什么时候显示残文
    _zoneMode.isShowFullText = !_zoneMode.isShowFullText;
    
    // 代理方法，告诉控制器，点击了收起或全文label，应该刷新数据了(刷新数据，就能再次自动计算cell高度)
    if ( [self.delegate respondsToSelector:@selector(xZoneViewCellClickFullButton:)] ) {
        [self.delegate xZoneViewCellClickFullButton:self];
    }
}

/**  返回UILabel剪切后文本内容的的行数(没用上)   */
- (NSInteger)getLinesRowOfInLabel:(UILabel *)label contentText:(NSString *)contentText{
    
    NSString *text = contentText;
    
    CGFloat  labelWidth = [UIScreen mainScreen].bounds.size.width - self.contentLabelLeading.constant - self.contentLabelTrailing.constant;
    

    
    // 获取每一行高度
    CGFloat lineHeight = [XQuanTool getStringSize:@"程" font:self.contentLabel.font width:CGFLOAT_MAX].height;
    
    // 获取总高度
    CGFloat height = [XQuanTool getStringSize:text font:self.contentLabel.font width:labelWidth].height;
    
    // 行数
    NSInteger row = height / lineHeight;
    
    return row;
}

/**  返回UILabel文本内容的的行数(没用上)   */
- (NSInteger)getLinesRowOfInLabel:(UILabel *)label{
    
    NSString *text = [label text];
    UIFont   *font = [label font];
    CGFloat  labelWidth = [UIScreen mainScreen].bounds.size.width - self.contentLabelLeading.constant - self.contentLabelTrailing.constant;
    
    CTFontRef myFont = CTFontCreateWithName((CFStringRef)font.fontName,
                                            font.pointSize,
                                            NULL);
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,labelWidth,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    // 获取到行数
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    
    //5.返回行数
    return lines.count;
}

/**  返回UILabel中每一行的内容(没用上)  */
-(NSArray *)getLinesArrayOfStringInLabel:(UILabel *)label
{
    NSString *text = _zoneMode.contentText;
    UIFont   *font = [label font];
    CGFloat  labelWidth = [UIScreen mainScreen].bounds.size.width - self.contentLabelLeading.constant - self.contentLabelTrailing.constant - 16;
    
    CTFontRef myFont = CTFontCreateWithName((CFStringRef)font.fontName,
                                            font.pointSize,
                                            NULL);
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,labelWidth,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
   
    // 获取到行数
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);

    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    
    return (NSArray *)linesArray;
}



/**  设置图片容器信息约束 并 传入数据   */
- (void)setImageConstaintLayoutAndPassData{

    if ( _zoneMode.imageArray.count == 0 ) {//如果没有图片
        
        //（注意没有图片高度为0不是这里解决的，而是XIB设置图片高度<=宽度且1:1，此时如果没有图片，系统会自动把高度设置为0）
        // 这里把第二个小容器和第三个小容器之间那个5间隔约束去掉，再把第一个小容器和第三个小容器之间5个人间隔去掉(如果不去掉，即便图片高度和容器View高度已经为0了，但是此时距离底下的那个工具栏还有10个间隔存在，所以这里是解决这个问题的)
        self.imageConstaintOne.fd_collapsed = YES;
        self.imageConstaintTwo.fd_collapsed = YES;
        
    }else if ( _zoneMode.imageArray.count <= 3 ){//如果图片为1到3张
        
        self.imageConstaintOne.fd_collapsed = YES;
        self.imageConstaintTwo.fd_collapsed = YES;
        
        //  给每张图片传入数据
        int index = 0;
        for (NSString *imageName in _zoneMode.imageArray) {
            //遍历出第一个图片容器中对的所有UIImageView
            UIImageView *imageView = self.imageConstaintOne.subviews[index];
            //传入图片数据
            imageView.image = [UIImage imageNamed:imageName];
            index++;
        }
  
    }else if ( _zoneMode.imageArray.count <= 6 ){
        
        self.imageConstaintTwo.fd_collapsed = YES;
        
        //  给每张图片传入数据
        int indexOne = 0;
        int indexTwo = 0;
        for (NSString *imageName in _zoneMode.imageArray) {//如果图片为3到6张
            
            if ( indexOne < 3 ) {//给第一组容器的图片传入数据
                //遍历出第一个图片容器中对的所有UIImageView
                UIImageView *imageView = self.imageConstaintOne.subviews[indexOne];
                //传入图片数据
                imageView.image = [UIImage imageNamed:imageName];
                indexOne++;
                continue; //已经把此条数据传入了，不再往下寻找了
                
            }if ( indexTwo < (_zoneMode.imageArray.count - 3) ){//给第二组容器的图片传入数据
                //遍历出第二个图片容器中对的所有UIImageView
                UIImageView *imageView = self.imageConstaintTwo.subviews[indexTwo];
                //传入图片数据
                imageView.image = [UIImage imageNamed:imageName];
                indexTwo++;
            }
            
        }
        
    }else if ( _zoneMode.imageArray.count <= 9 ){
        
        
        //  给每张图片传入数据
        int indexOne = 0;
        int indexTwo = 0;
        int indexThree = 0;
        for (NSString *imageName in _zoneMode.imageArray) {//如果图片为7到9账
            
            if ( indexOne < 3 ) {//给第一组容器的图片传入数据
                //遍历出第一个图片容器中对的所有UIImageView
                UIImageView *imageView = self.imageConstaintOne.subviews[indexOne];
                //传入图片数据
                imageView.image = [UIImage imageNamed:imageName];
                indexOne++;
                continue; //已经把此条数据传入了，不再往下寻找了
                
            }if ( indexTwo < 3 ){//给第二组容器的图片传入数据
                //遍历出第二个图片容器中对的所有UIImageView
                UIImageView *imageView = self.imageConstaintTwo.subviews[indexTwo];
                //传入图片数据
                imageView.image = [UIImage imageNamed:imageName];
                indexTwo++;
                continue; //已经把此条数据传入了，不再往下寻找了
                
            }if ( indexThree < (_zoneMode.imageArray.count - 6) ){//给第三组容器的图片传入数据
                //遍历出第二个图片容器中对的所有UIImageView
                UIImageView *imageView = self.imageConstaintThree.subviews[indexThree];
                //传入图片数据
                imageView.image = [UIImage imageNamed:imageName];
                indexThree++;
            }
            
        }
    }
    
}

/**  设置赞、评论、转发工具栏容器约束 并 传入数据   */
- (void)setToolBarLayoutAndPassData{
}

/**  设置评论约束 并 传入数据   */
- (void)setCommentLayoutAndPassData{
    
    if ( _zoneMode.commentArray.count == 0 ) {
        
        // 如果没有评论，则让所有评论Label的text属性为nil，只有这样系统才能默认对XIB中的UILabel进行收起
        self.commentOneLabel.text = nil;
        self.commentTwoLabel.text = nil;
        self.commentThreeLabel.text = nil;
        self.commentFourLabel.text = nil;
        
    }else if ( _zoneMode.commentArray.count == 1 ){
        
        // 1.如果1条评论，则对一个评论Label传入数据
        XZoneCommentMode *zoneCommentOneMode = _zoneMode.commentArray[0];
        // 根据模型拼接评论内容 + 把拼接好的内容传入评论Label中 + 设置Label中的文字变色
        [self setCommentContentToCommentLabel:self.commentOneLabel zoneCommentMode:zoneCommentOneMode];
        
        // 2,设置其他评论Label=nil，此时系统可自动折叠
        self.commentTwoLabel.text = nil;
        self.commentThreeLabel.text = nil;
        self.commentFourLabel.text = nil;
        
    }else if ( _zoneMode.commentArray.count == 2 ){
        
        // 1.如果2条评论，则对前两个评论Label传入数据
        
        // 给第一条评论UILabel传入数据
        XZoneCommentMode *zoneCommentOneMode = _zoneMode.commentArray[0];
        // 根据模型拼接评论内容 + 把拼接好的内容传入评论Label中 + 设置Label中的文字变色
        [self setCommentContentToCommentLabel:self.commentOneLabel zoneCommentMode:zoneCommentOneMode];

        
        // 给第二条评论UILabel传入数据
        XZoneCommentMode *zoneCommentTwoMode = _zoneMode.commentArray[1];
        // 根据模型拼接评论内容 + 把拼接好的内容传入评论Label中 + 设置Label中的文字变色
        [self setCommentContentToCommentLabel:self.commentTwoLabel zoneCommentMode:zoneCommentTwoMode];
        
        // 2,设置其他评论Label=nil，此时系统可自动折叠
        self.commentThreeLabel.text = nil;
        self.commentFourLabel.text = nil;
        
    }else if ( _zoneMode.commentArray.count == 3 ){
        
        // 1.如果3条评论，则对前三个评论Label传入数据
        
        // 给第一条评论UILabel传入数据
        XZoneCommentMode *zoneCommentOneMode = _zoneMode.commentArray[0];
        // 根据模型拼接评论内容 + 把拼接好的内容传入评论Label中 + 设置Label中的文字变色
        [self setCommentContentToCommentLabel:self.commentOneLabel zoneCommentMode:zoneCommentOneMode];
        
        
        // 给第二条评论UILabel传入数据
        XZoneCommentMode *zoneCommentTwoMode = _zoneMode.commentArray[1];
        // 根据模型拼接评论内容 + 把拼接好的内容传入评论Label中 + 设置Label中的文字变色
        [self setCommentContentToCommentLabel:self.commentTwoLabel zoneCommentMode:zoneCommentTwoMode];
        
        // 给第三条评论UILabel传入数据
        XZoneCommentMode *zoneCommentThreeMode = _zoneMode.commentArray[2];
        // 根据模型拼接评论内容 + 把拼接好的内容传入评论Label中 + 设置Label中的文字变色
        [self setCommentContentToCommentLabel:self.commentThreeLabel zoneCommentMode:zoneCommentThreeMode];
        
        // 2,设置其他评论Label=nil，此时系统可自动折叠
        self.commentFourLabel.text = nil;
        
    }else{
        
        // 1.如果评论>3条，则对前三个评论Label传入数据
        
        // 拼接字符串并设置部分文字变色
        // 给第一条评论UILabel传入数据
        XZoneCommentMode *zoneCommentOneMode = _zoneMode.commentArray[0];
        // 根据模型拼接评论内容 + 把拼接好的内容传入评论Label中 + 设置Label中的文字变色
        [self setCommentContentToCommentLabel:self.commentOneLabel zoneCommentMode:zoneCommentOneMode];
        
        
        // 给第二条评论UILabel传入数据
        XZoneCommentMode *zoneCommentTwoMode = _zoneMode.commentArray[1];
        // 根据模型拼接评论内容 + 把拼接好的内容传入评论Label中 + 设置Label中的文字变色
        [self setCommentContentToCommentLabel:self.commentTwoLabel zoneCommentMode:zoneCommentTwoMode];
        
        // 给第三条评论UILabel传入数据
        XZoneCommentMode *zoneCommentThreeMode = _zoneMode.commentArray[2];
        // 根据模型拼接评论内容 + 把拼接好的内容传入评论Label中 + 设置Label中的文字变色
        [self setCommentContentToCommentLabel:self.commentThreeLabel zoneCommentMode:zoneCommentThreeMode];
        
        
        // 2.对第四个Label设置“点击查看更多评论”
        self.commentFourLabel.text = @"点击查看更多评论";
        [self.commentFourLabel setEmojiText:@"点击查看更多评论"];
        [self.commentFourLabel addLinkToTransitInformation:nil withRange:[self.commentFourLabel.text rangeOfString:@"点击查看更多评论"]];

    }

    
}


#pragma mark - 根据传入的评论里面内容拼接评论内容 + 把内容传入评论Label中 + 设置部分文字变色和点击
- (void)setCommentContentToCommentLabel:(MLEmojiLabel *)commentLabel zoneCommentMode:(XZoneCommentMode *)zoneCommentMode{

    NSString *commentString = nil;
    if ( zoneCommentMode.targetidname == nil || zoneCommentMode.targetidname.length == 0) {
        
        // 如果没有回复目标,那么这样拼接评论字符串
         commentString = [NSString stringWithFormat:@"%@:%@",zoneCommentMode.criticidname,zoneCommentMode.content];
        
        // 把拼接好的评论内容 传给 评论Label
        [commentLabel setEmojiText:commentString];
        
        // 设置指定区域变色+可点击
        //(给指定的人名添加点击事件)
        [commentLabel addLinkToTransitInformation:nil withRange:[commentLabel.text rangeOfString:zoneCommentMode.criticidname]];

        
        
    }else{
        
        // 如果有回复目标,那么这样拼接评论字符串
        commentString = [NSString stringWithFormat:@"%@ 回复 %@:%@",zoneCommentMode.criticidname,zoneCommentMode.targetidname,zoneCommentMode.content];
        
        // 把拼接好的评论内容 传给 评论Label
        [commentLabel setEmojiText:commentString];
        
        // 设置指定区域变色+可点击
        //(给指定的人名添加点击事件)
        [commentLabel addLinkToTransitInformation:nil withRange:[commentLabel.text rangeOfString:zoneCommentMode.targetidname]];
        [commentLabel addLinkToTransitInformation:nil withRange:[commentLabel.text rangeOfString:zoneCommentMode.criticidname]];
    }
    
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

@end
