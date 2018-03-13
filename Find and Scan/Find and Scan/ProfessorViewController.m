//
//  ProfessorViewController.m
//  Find and Scan
//
//  Created by 贝宁 on 06/03/2018.
//  Copyright © 2018 贝宁. All rights reserved.
//

#import "ProfessorViewController.h"

@interface ProfessorViewController ()

@end

@implementation ProfessorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)logOutbtn:(UIButton *)sender {
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (status) {
        NSLog(@"Signed out");
        [self performSegueWithIdentifier:@"goToLogInProfessor" sender:self];
    }
}

@end
