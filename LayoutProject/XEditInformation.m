//
//  XEditInformation.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/1/27.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "XEditInformation.h"
#import "AppDelegate.h"

@interface XEditInformation ()

@end

@implementation XEditInformation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onRightEvent:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"XTabBar" bundle:nil];
    UINavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"XFrameNavigation"];
    [[[UIApplication sharedApplication] delegate] window].rootViewController = nav;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
