#import "SignUpViewController.h"

@interface SignUpViewController ()
{
    NSArray *positions;
    NSString *position;
    NSString *newEmail;
    NSString *newPassword;
    NSString *newName;
}
@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set the firebase reference
    self.ref = [[FIRDatabase database] reference];
    
    positions = @[@"Student", @"Professor"];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    // set the default position to student
    position = @"Student";
    
    _signUpButton.layer.borderWidth = 3;
    _signUpButton.layer.borderColor = [[UIColor whiteColor]CGColor];
    _backButton.layer.borderWidth = 3;
    _backButton.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    _emailSignUp.delegate = self;
    _passwordSignUp.delegate = self;
    _nameSignUp.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



// picker view setting, pass value to *position(NSString)
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return positions.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return positions[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    position = positions[row];
    NSLog(@"%@", position);
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


// click sign up button
- (IBAction)signUpButtonAction:(UIButton *)sender {
    
    newEmail = _emailSignUp.text;
    newPassword = _passwordSignUp.text;
    newName = _nameSignUp.text;
    
   // check if email and password are filled in
    if(![newEmail isEqualToString:@""] && ![newPassword isEqualToString:@""] && ![newName isEqualToString:@""]){
        [[FIRAuth auth] createUserWithEmail:newEmail password:newPassword completion:^(FIRUser * user, NSError * error) {
            id u = user;
            
            // check if the email exist
            // email has not been used
            if(u){
                
                // save name and position to database
                NSString *userID = [FIRAuth auth].currentUser.uid;
                [[[[_ref child:@"users"] child:userID] child:@"Name"] setValue:newName];
                [[[[_ref child:@"users"] child:userID] child:@"Position"] setValue:position];
                
                // check is student or professor
                if([position isEqualToString:@"Student"]){
                    
                    // pop up an alert message
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Register Success!" message:@"Welcome to Find and Scan" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
                        
                        // go to main page
                        [self performSegueWithIdentifier:@"goToMainPage" sender:self];
                    }];
                    [alert addAction:defaultAction];
                    [self presentViewController:alert animated:YES completion:nil];
                    
                }
                else{
                    // pop up an alert message
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Register Success!" message:@"Welcome to Find and Scan" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
                        
                        // go to main page
                        [self performSegueWithIdentifier:@"signUpGoToProfessorPage" sender:self];
                    }];
                    [alert addAction:defaultAction];
                    [self presentViewController:alert animated:YES completion:nil];
                }

                
                
            }
            
            // email has been registered
            else{
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Register Fail" message:@"This email has been used" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Back" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {}];
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    }
    
    // user not fill in both two fields
    else{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Register Fail" message:@"please ensure enter all the text boxes" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Back" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}







@end
