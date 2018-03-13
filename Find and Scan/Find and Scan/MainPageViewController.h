//
//  MainPageViewController.h
//  Find and Scan
//
//  Created by 贝宁 on 23/02/2018.
//  Copyright © 2018 贝宁. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
#import "QRCodeReaderDelegate.h"
#import "QRCodeReaderViewController.h"
#import "QRCodeReader.h"


@interface MainPageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *mainPageUserProfile;
@property (weak, nonatomic) IBOutlet UIButton *findFacilitesBtn;
@property (weak, nonatomic) IBOutlet UIButton *attendClassBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@property (strong, nonatomic) FIRDatabaseReference *ref;

- (IBAction)logOutBtn:(UIButton *)sender;

- (IBAction)findFacilitiesBtnAction:(UIButton *)sender;
- (IBAction)attendClassBtnAction:(UIButton *)sender;
@end
