//
//  XMainC.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/1/27.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "XMainC.h"
#import "XLoginC.h"
#import "AppDelegate.h"

@interface XMainC ()

@end

@implementation XMainC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"XLogin" bundle:nil];
//    XLoginC *page = [storyboard instantiateViewControllerWithIdentifier:@"XLoginIdentifier"];
//    
//    [self addChildViewController:page];
    
     //[self performSegueWithIdentifier:@"mainSegue" sender:self];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"XLogin" bundle:nil];
    UINavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"XLoginNavigation"];
    [[[UIApplication sharedApplication] delegate] window].rootViewController = nav;
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

@end

