//
//  UserProfileViewController.m
//  Find and Scan
//
//  Created by 贝宁 on 03/03/2018.
//  Copyright © 2018 贝宁. All rights reserved.
//

#import "UserProfileViewController.h"

@interface UserProfileViewController (){
    NSMutableArray *records;
}
@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // make user profile round
    _userProfile.layer.cornerRadius = 27;
    _userProfile.clipsToBounds = YES;
    
    // set the firebase reference
    self.ref = [[FIRDatabase database] reference];
    
    records = [NSMutableArray arrayWithArray:@[@"Check your attendance records below!"]];
    
    // read records from database
    NSString *userID = [FIRAuth auth].currentUser.uid;
    
    [[[_ref child:@"records"] child:userID] observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSString *readFromDatabase = snapshot.value;
        if(readFromDatabase){
            [records addObject:readFromDatabase];
            [self.tableView reloadData];
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return records.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID =@"cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = records[indexPath.row];
    
    return cell;
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
