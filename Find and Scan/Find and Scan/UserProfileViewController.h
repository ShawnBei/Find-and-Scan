//
//  UserProfileViewController.h
//  Find and Scan
//
//  Created by 贝宁 on 03/03/2018.
//  Copyright © 2018 贝宁. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface UserProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *userProfile;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) FIRDatabaseReference *ref;

@end
