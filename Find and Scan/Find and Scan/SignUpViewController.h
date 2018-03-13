

#import <UIKit/UIKit.h>
@import Firebase;

@interface SignUpViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UITextField *emailSignUp;
@property (weak, nonatomic) IBOutlet UITextField *passwordSignUp;
@property (weak, nonatomic) IBOutlet UITextField *nameSignUp;

@property (strong, nonatomic) FIRDatabaseReference *ref;

- (IBAction)signUpButtonAction:(UIButton *)sender;

@end
