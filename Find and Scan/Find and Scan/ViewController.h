#import <UIKit/UIKit.h>
@import Firebase;

@interface ViewController : UIViewController <UITextFieldDelegate>

- (IBAction)logInButtonAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UIImageView *logInImageView;

@property (strong, nonatomic) FIRDatabaseReference *ref;

@end
