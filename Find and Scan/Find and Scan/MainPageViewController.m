
#import "MainPageViewController.h"

@interface MainPageViewController ()

@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set the firebase reference
    self.ref = [[FIRDatabase database] reference];
    
    //make user profile image round
    _mainPageUserProfile.layer.cornerRadius = 27;
    _mainPageUserProfile.clipsToBounds = YES;
    
    //make find btn round
    _findFacilitesBtn.layer.cornerRadius = 80;
    _findFacilitesBtn.clipsToBounds = YES;
    _findFacilitesBtn.layer.borderWidth = 1.5;
    _findFacilitesBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    //make scan btn round
    _attendClassBtn.layer.cornerRadius = 80;
    _attendClassBtn.clipsToBounds = YES;
    _attendClassBtn.layer.borderWidth = 1.5;
    _attendClassBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    // set name label
    NSString *userID = [FIRAuth auth].currentUser.uid;
    [[[_ref child:@"users"] child:userID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSString *username = snapshot.value[@"Name"];
        _nameLable.text = username;
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// log out
- (IBAction)logOutBtn:(UIButton *)sender {
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (status) {
        NSLog(@"Signed out");
        [self performSegueWithIdentifier:@"goToLogInPage" sender:self];
    }
}

- (IBAction)findFacilitiesBtnAction:(UIButton *)sender {
}

- (IBAction)attendClassBtnAction:(UIButton *)sender {
    if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
        static QRCodeReaderViewController *vc = nil;
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
            vc                   = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
            vc.modalPresentationStyle = UIModalPresentationFormSheet;
        });
        vc.delegate = self;
        
        [vc setCompletionWithBlock:^(NSString *resultAsString) {
            
            // display to console
            NSLog(@"Completion with result: %@", resultAsString);
        }];
        
        [self presentViewController:vc animated:YES completion:NULL];
    }
    else {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Reader not supported by the current device" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [reader stopScanning];
    
    // generate current time
    double currentTime = 1000 * [[NSDate date] timeIntervalSince1970];
    int codeTime = result.intValue;
    
    NSDateFormatter *dataString=[[NSDateFormatter alloc] init];
    [dataString setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *newDate = [dataString stringFromDate:[NSDate date]];
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        // compare current time to the QR code
        // if equals
        if ((currentTime - codeTime < 3000) || (currentTime - codeTime > -3000)) {
            NSString *newResult = [NSString stringWithFormat:@"%@ %@,%@", newDate, [result substringFromIndex:14] , @" Success"];
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Attend Success" message:newResult preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {}];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            // save user attendance record to database
            NSString *userID = [FIRAuth auth].currentUser.uid;
            [[[[_ref child:@"records"] child:userID] childByAutoId] setValue:newResult];
        }
        
        // if not equal
        else{
            NSString *newResult = [NSString stringWithFormat:@"%@ %@,%@", newDate, [result substringFromIndex:14], @" Fail"];
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Attend Fail" message:newResult preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {}];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            // save to database
            NSString *userID = [FIRAuth auth].currentUser.uid;
            [[[[_ref child:@"records"] child:userID] childByAutoId] setValue:newResult];
        }
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
