
#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface Screen2ViewController : UIViewController{

    IBOutlet UIView *facebookButton;
    IBOutlet UITextField *pincode;
}

@property (nonatomic, retain) UIView *facebookButton;
@property (nonatomic, retain) UITextField *pincode;

-(IBAction) registerWithPinTap:(id)senderId;


@end
