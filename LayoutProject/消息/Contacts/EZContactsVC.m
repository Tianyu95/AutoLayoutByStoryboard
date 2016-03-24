//
//  EZContactsVC.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/3/8.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "EZContactsVC.h"
#import "EZContactCell.h"
#import "EZContactRecord.h"

@interface EZContactsVC ()
{
    EZContactRecord *contactData;
    NSMutableArray *contactArray;

}
@end

@implementation EZContactsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    /*
    contactArray = [NSMutableArray arrayWithCapacity:0];
    contactData = [[EZContactRecord alloc] init];
    int result = [contactData initDatabase];
    if (result) {
        [contactData createContactTable];
    }
    [contactData addContact];
    contactArray = [contactData getContact];
    NSLog(@"contactArray = %@",contactArray);
    
    [contactData removeContactByUid:@"00006"];
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EZContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EZContactCell" forIndexPath:indexPath];
    // Configure the cell...
    if (cell == nil) {
        NSLog(@"niiiiil");
    }
    NSString *hstr = [NSString stringWithFormat:@"headTest%ld",indexPath.row + 1];

    cell.heardImage.image = [UIImage imageNamed:hstr];
    cell.nameLabel.text = [NSString stringWithFormat:@"index row %ld",indexPath.row];
    
    cell.heardImage.layer.cornerRadius = cell.heardImage.frame.size.width/2;
    cell.heardImage.clipsToBounds = YES;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
