#import "ViewController.h"

@interface ViewController (){

    NSString *emailInput;
    NSString *passwordInput;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set the firebase reference
    self.ref = [[FIRDatabase database] reference];
    
    // To load data from database everytime data is added
    /*[[[_ref child:@"users"] child:@"user1"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        
        NSString *getFromDatabase = snapshot.value[@"name"];
        NSLog(@"%@", getFromDatabase);
        _usernameText.text = getFromDatabase;
        
        getFromDatabase = snapshot.key;
        NSLog(@"%@", getFromDatabase);
    }];*/
    
    
    /*[[_ref child:@"users"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        NSString *getFromDatabase = snapshot.value[@"username"];
        NSLog(@"%@", getFromDatabase);
    }];*/
    
    // generate current time
    /*NSDateFormatter *dataString=[[NSDateFormatter alloc] init];
    [dataString setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSLog(@"%@",[dataString stringFromDate:[NSDate date]]);*/
    
    _emailText.delegate = self;
    _passwordText.delegate = self;
    
    // set the outlook of two buttons
    _logInButton.layer.borderWidth = 3;
    _logInButton.layer.borderColor = [[UIColor whiteColor]CGColor];
    _signUpButton.layer.borderWidth = 3;
    _signUpButton.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    //make log in user profile image round
    _logInImageView.layer.cornerRadius = 60;
    _logInImageView.clipsToBounds = YES;
    _logInImageView.layer.borderWidth = 2.0;
    _logInImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//dismiss keyboard
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



// click on log in button
- (IBAction)logInButtonAction:(UIButton *)sender {
    emailInput = _emailText.text;
    passwordInput = _passwordText.text;
    
    // check is the email and password are filled
    if (![emailInput isEqual:@""] && ![passwordInput isEqual:@""]){
        
        [[FIRAuth auth] signInWithEmail:emailInput password:passwordInput completion:^(FIRUser *user, NSError *error) {
            id u = user;
            
            // if user exists
            if(u){
                // check position
                NSString *userID = [FIRAuth auth].currentUser.uid;
                [[[_ref child:@"users"] child:userID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                    
                    if([snapshot.value[@"Position"] isEqualToString:@"Student"]){
                        [self performSegueWithIdentifier:@"logInToMainPage" sender:self];
                    }
                    else{
                        [self performSegueWithIdentifier:@"logInGoToProfessorPage" sender:self];
                    }
                }];
                
            }
            
            //if user does not exist
            else{
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Log In Fail" message:@"Please check your email and password" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Back" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {}];
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
         }];
    }
    
    else {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Log In Fail" message:@"Please enter your email or password" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Back" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


@end













