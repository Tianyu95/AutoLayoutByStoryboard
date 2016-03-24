//
//  XZoneListC.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/1.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "XZoneListC.h"
#import "XZoneMode.h"
#import "XZoneViewCell.h"


@interface XZoneListC ()<XZoneViewCellDelegate>

@property (nonatomic,strong) NSMutableArray *zoonModeArrayM;

@end

@implementation XZoneListC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 数据模型
    [self creatZoneMode];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    // 设置tableview估算行高属性，只有这样才能解决xib中cell动态高度问题
    self.tableView.estimatedRowHeight = 20;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
//    [self.tableView addHeaderWithTarget:self action:@selector(aaa:)];
    
    
}
//- (void)aaa:(UITableView *)table{
//
//    NSLog(@"--");
//}

#pragma mark - 懒加载
- (NSMutableArray *)zoonModeArrayM{

    if ( _zoonModeArrayM == nil ) {
        _zoonModeArrayM = [NSMutableArray array];
    }
    return _zoonModeArrayM;
}

#pragma mark - 创建数据模型
- (void)creatZoneMode{

    // 评论模型
    XZoneCommentMode *commentMode11 = [[XZoneCommentMode alloc] init];
    commentMode11.criticidname = @"ChenTianyu";
    commentMode11.content = @"开始[跳绳]投资[微笑]";
    
    XZoneCommentMode *commentMode12 = [[XZoneCommentMode alloc] init];
    commentMode12.criticidname = @"拉普拉斯";
    commentMode12.content = @"数据[足球]计算[勾引]";
    
    XZoneMode *zoneMode1 = [[XZoneMode alloc] init];
    zoneMode1.forwardRemindText = @"旭东转发了";
    zoneMode1.userHeaderImageName = @"headTest1";
    zoneMode1.userNameText = @"IT尖端";
    zoneMode1.userTimeText = @"20分钟前";
    zoneMode1.userMarkText = @"无线事业部";
    zoneMode1.contentText = @"这里的内容不算@进步 一般多的[微笑]";
    zoneMode1.imageArray = @[@"1",@"2"];
    zoneMode1.commentArray = @[commentMode11,commentMode12];
    
    
    // 评论模型
    XZoneCommentMode *commentMode21 = [[XZoneCommentMode alloc] init];
    commentMode21.criticidname = @"ChenTianyu";
    commentMode21.content = @"开始投资[微笑]";
    
    
    XZoneMode *zoneMode2 = [[XZoneMode alloc] init];
    zoneMode2.userHeaderImageName = @"headTest2";
    zoneMode2.userNameText = @"傅里叶";
    zoneMode2.userTimeText = @"10分钟前";
    zoneMode2.userMarkText = @"无线事业部";
    zoneMode2.contentText = @"这里的内容不算挺13847006532多的挺多的dudl@qq.com挺多的挺多的挺多的挺多的挺多的挺多的挺[微笑]多的[委屈]挺[刀]多的[足球]挺[咖啡]多的[啤酒]挺多的挺多的挺多的you挺多的挺多的挺多的挺多的挺多的s挺多的挺多的挺多的挺多的挺多的https://github.com/molon/MLEmojiLabel挺多的挺多的挺多的挺多的挺多的挺多的挺多的挺多的挺多的挺多的挺多的挺多的挺多的挺多的挺多的挺多的挺多的挺多的挺多的";
    zoneMode2.commentArray = @[commentMode21];
    
    
    // 评论模型
    XZoneCommentMode *commentMode31 = [[XZoneCommentMode alloc] init];
    commentMode31.criticidname = @"ChenTianyu";
    commentMode31.content = @"开始[啤酒][咖啡]投资";
    
    XZoneCommentMode *commentMode32 = [[XZoneCommentMode alloc] init];
    commentMode32.criticidname = @"拉普拉斯";
    commentMode32.targetidname = @"ChenTianyu";
    commentMode32.content = @"数据计算[足球]";
    
    XZoneMode *zoneMode3 = [[XZoneMode alloc] init];
    zoneMode3.forwardRemindText = @"泰勒转发了";
    zoneMode3.userNameText = @"ChenTianyu";
    zoneMode3.userTimeText = @"1小时前";
    zoneMode3.userMarkText = @"无线事业部";
    zoneMode3.contentText = @"这里的[刀][跳跳]内容不算一般多的";
    zoneMode3.commentArray = @[commentMode31,commentMode32];
    
    // 评论模型
    XZoneCommentMode *commentMode41 = [[XZoneCommentMode alloc] init];
    commentMode41.criticidname = @"ChenTianyu";
    commentMode41.content = @"开始投资";
    
    XZoneCommentMode *commentMode42 = [[XZoneCommentMode alloc] init];
    commentMode42.criticidname = @"拉普拉斯";
    commentMode42.content = @"数据计算";
    
    XZoneMode *zoneMode4 = [[XZoneMode alloc] init];
    zoneMode4.userHeaderImageName = @"headTest4";
    zoneMode4.userNameText = @"拉格朗日";
    zoneMode4.userTimeText = @"1分钟前";
    zoneMode4.userMarkText = @"无线事业部";
    zoneMode4.contentText = @"这里的内容不算一般多的";
    zoneMode4.imageArray = @[@"1",@"2",@"3",@"4"];
    zoneMode4.commentArray = @[commentMode41,commentMode42];
    
    // 评论模型
    XZoneCommentMode *commentMode51 = [[XZoneCommentMode alloc] init];
    commentMode51.criticidname = @"ChenTianyu";
    commentMode51.content = @"开始投资";
    
    XZoneCommentMode *commentMode52 = [[XZoneCommentMode alloc] init];
    commentMode52.criticidname = @"拉普拉斯";
    commentMode52.content = @"数据计算";
    
    XZoneCommentMode *commentMode53 = [[XZoneCommentMode alloc] init];
    commentMode53.criticidname = @"洛必达";
    commentMode53.targetidname = @"ChenTianyu";
    commentMode53.content = @"多次求导可借鉴问问题";
    
    XZoneCommentMode *commentMode54 = [[XZoneCommentMode alloc] init];
    commentMode54.criticidname = @"拉格朗日";
    commentMode54.targetidname = @"ChenTianyu";
    commentMode54.content = @"中值定定力二重积分";
    
    XZoneMode *zoneMode5 = [[XZoneMode alloc] init];
    zoneMode5.userNameText = @"洛必达";
    zoneMode5.userTimeText = @"10分钟前";
    zoneMode5.userMarkText = @"无线事业部";
    zoneMode5.contentText = @"这里说吧说吧可以sdfssdf的内容13847092123不算一般有点久久多有一地啊点多有意思吧有点多就是有点多谁说的有点多有点多有点多有点13847092123多有点多有点多有点多有点多有点多有点多有点多有点多有点多有点多有y点多有点s多有点13847092123多有点多有点多有点多有点多有点多多加点就行了呗";
    zoneMode5.imageArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    zoneMode5.commentArray = @[commentMode51,commentMode52,commentMode53,commentMode54];
    
    // 评论模型
    XZoneCommentMode *commentMode61 = [[XZoneCommentMode alloc] init];
    commentMode61.criticidname = @"ChenTianyu";
    commentMode61.content = @"开始投资";
    
    XZoneCommentMode *commentMode62 = [[XZoneCommentMode alloc] init];
    commentMode62.criticidname = @"拉普拉斯";
    commentMode62.content = @"数据计算";
    
    XZoneCommentMode *commentMode63 = [[XZoneCommentMode alloc] init];
    commentMode63.criticidname = @"泰勒";
    commentMode63.targetidname = @"ChenTianyu";
    commentMode63.content = @"泰勒中值定理泰勒公式";
    
    XZoneCommentMode *commentMode64 = [[XZoneCommentMode alloc] init];
    commentMode64.criticidname = @"微积分";
    commentMode64.content = @"有意思么";
    
    XZoneCommentMode *commentMode65 = [[XZoneCommentMode alloc] init];
    commentMode65.criticidname = @"傅里叶";
    commentMode65.content = @"傅里叶变化拉普拉斯变化";
    
    XZoneMode *zoneMode6 = [[XZoneMode alloc] init];
    zoneMode6.forwardRemindText = @"旭东转发了";
    zoneMode6.userHeaderImageName = @"headTest1";
    zoneMode6.userNameText = @"IT尖端";
    zoneMode6.userTimeText = @"20分钟前";
    zoneMode6.userMarkText = @"无线事业部";
    zoneMode6.contentText = @"这里的内容不算一里的内容不算一sadfs里的内容不算一lkjsdlfjihwk里的内容不算一lasdfhiuglkjl里的内容不算一lahsdkfhugewkahkjh里的内容不算一wkekjabdjfkjh里的内容不算一akjsdhflksajdoi里的内容不算一lkajdoifhabe里的内容不算一lakjdoiufhwekh里的内容不算一alkjdfoaihel里的内容不算一alkjdoifhawelj般多的";
    zoneMode6.commentArray = @[commentMode61,commentMode62,commentMode63,commentMode64,commentMode65];
    
    XZoneMode *zoneMode7 = [[XZoneMode alloc] init];
    zoneMode7.forwardRemindText = @"旭东转发了";
    zoneMode7.userHeaderImageName = @"headTest1";
    zoneMode7.userNameText = @"IT尖端";
    zoneMode7.userTimeText = @"20分钟前";
    zoneMode7.userMarkText = @"无线事业部";
    zoneMode7.contentText = @"这里的内容不算一里的内容不算一sadfs里的内容不算一lkjsdlfjihwk里的内容不算一lasdfhiuglkjl里的内容不算一lahsdkfhugewkahkjh里的内容不算一wkekjabdjfkjh里的内容不算一akjsdhflksajdoi里的内容不算一lkajdoifhabe里的内容不算一lakjdoiufhwekh里的内容不算一alkjdfoaihel里的内容不算一alkjdoifhawelj般多的";
    zoneMode7.imageArray = @[@"1",@"2"];
    
    XZoneMode *zoneMode8 = [[XZoneMode alloc] init];
    zoneMode8.forwardRemindText = @"旭东转发了";
    zoneMode8.userHeaderImageName = @"headTest1";
    zoneMode8.userNameText = @"IT尖端";
    zoneMode8.userTimeText = @"20分钟前";
    zoneMode8.userMarkText = @"无线事业部";
    zoneMode8.contentText = @"这里的内容不算一里的内容不算一sadfs里的内容不算一lkjsdlfjihwk里的内容不算一lasdfhiuglkjl里的内容不算一lahsdkfhugewkahkjh里的内容不算一wkekjabdjfkjh里的内容不算一akjsdhflksajdoi里的内容不算一lkajdoifhabe里的内容不算一lakjdoiufhwekh里的内容不算一alkjdfoaihel里的内容不算一alkjdoifhawelj般多的";
    zoneMode8.imageArray = @[@"1",@"2"];

    
    [self.zoonModeArrayM addObject:zoneMode1];
    [self.zoonModeArrayM addObject:zoneMode2];
    [self.zoonModeArrayM addObject:zoneMode3];
    [self.zoonModeArrayM addObject:zoneMode4];
    [self.zoonModeArrayM addObject:zoneMode5];
    [self.zoonModeArrayM addObject:zoneMode6];
    [self.zoonModeArrayM addObject:zoneMode7];
    [self.zoonModeArrayM addObject:zoneMode8];
    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.zoonModeArrayM.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // 创建Cell
    XZoneViewCell *zoonCell = [XZoneViewCell tableViewCellWithTableView:tableView];
    zoonCell.delegate = self;
    
    // 传入数据
    zoonCell.zoneMode = self.zoonModeArrayM[indexPath.row];
    
    // 返回Cell
    return zoonCell;
}

#pragma mark - XZoneViewCellDelegate
/**  这个代理方法是，点击Cell中的 收起或全文 时会触发的   */
- (void)xZoneViewCellClickFullButton:(XZoneViewCell *)zoneViewCell{

    // 刷新数据 并 自动计算Cell高度
    [self.tableView reloadData];
   
    // 获取当前刷新的Cell
    NSIndexPath *indexPath = [self.tableView indexPathForCell:zoneViewCell];
    
    // 保证Cell刷新后滚动到当前行
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    
}

@end
