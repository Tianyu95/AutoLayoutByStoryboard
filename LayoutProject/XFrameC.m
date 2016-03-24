//
//  XFrameC.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/1.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "XFrameC.h"

@interface XFrameC ()

@end

@implementation XFrameC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadElements];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loadElements
{
    NSArray *storyboards = @[@"XZone", @"XDomain", @"XMessage", @"XPrivate"];
    NSArray *navigations = @[@"XZoneNavigation", @"XDomainNavigation", @"XMessageNavigation", @"XPrivateNavigation"];
    NSMutableArray *items = [NSMutableArray array];
    
    for (int i = 0; i < storyboards.count; i++) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboards[i] bundle:nil];
        UINavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:navigations[i]];
        [items addObject:nav];
    }

    self.viewControllers = items;
    self.customizableViewControllers = items;
    self.selectedIndex = 0;
}

@end
