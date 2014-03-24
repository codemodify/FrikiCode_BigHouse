
#import "Screen2ViewController.h"
#import "Screen3ViewController.h"
#import "Screen5ViewController.h"

#import "BigHouseAppDelegate.h"
#import <CoreLocation/CoreLocation.h>
//#import "Base64.h"
#import "SBJson.h"


@interface Screen2ViewController () <FBLoginViewDelegate>

@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePic;
@property (strong, nonatomic) id<FBGraphUser> loggedInUser;

- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error;


@end

@implementation Screen2ViewController

@synthesize profilePic = _profilePic;
@synthesize loggedInUser = _loggedInUser;

@synthesize facebookButton, pincode;

#pragma mark - UIViewController

- (void)viewDidLoad {    
    [super viewDidLoad];
    
    // Facebook button
    FBLoginView *loginview = [[FBLoginView alloc] init];
    
    loginview.frame = CGRectMake( 0, 0, self.facebookButton.frame.size.width, self.facebookButton.frame.size.height); //CGRectOffset(loginview.frame, 5,5);
    loginview.delegate = self;
    
    [self.facebookButton addSubview:loginview];

    [loginview sizeToFit];
}

- (void)viewDidUnload {

    self.loggedInUser = nil;
    self.profilePic = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - FBLoginViewDelegate

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user
{
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object

    NSString* facebookId = [NSString stringWithFormat:@"%@", user.id];
    NSString* facebookName = [NSString stringWithFormat:@"%@", user.first_name];
    UIImage* facebookImage;
    NSString* facebookImageAsBase64;
    
    // setting the profileID property of the FBProfilePictureView instance
    // causes the control to fetch and display the profile picture for the user
    self.profilePic.profileID = user.id;
    self.loggedInUser = user;
    
    // copy the profile image
    for (NSObject *obj in [self.profilePic subviews]) {
        if ([obj isMemberOfClass:[UIImageView class]]) {
            UIImageView *objImg = (UIImageView *)obj;
            facebookImage = [UIImage imageWithCIImage:[objImg.image CIImage]];
            break;
        }
    }

    // to base 64
//    NSData* data = UIImageJPEGRepresentation(facebookImage, 1.0f);
//    [Base64 initialize];
    facebookImageAsBase64 = @"12345=";//[Base64 encode:data];
    
    // GLOBAL APP
    BigHouseAppDelegate *bigHouseAppDelegate = (BigHouseAppDelegate *)[[UIApplication sharedApplication] delegate];    
    
    // WEBSERVICE
    // UserService.svc/RegisterWithFaceBook/123123123123123;JaneDauther;ASDQWPOKDOIJUIUu86234b23j423423k42=
    NSString* webServiceUrl = [NSString stringWithFormat:@"%@%@;%@;%@",
                               @"http://a4642a88bb0f4542a631a92fc8d21d1d.cloudapp.net:8080/UserService.svc/RegisterWithFaceBook/",
                               facebookId,
                               facebookName,
                               facebookImageAsBase64];

    NSString* webServiceDataAsJson = [NSString stringWithContentsOfURL:[NSURL URLWithString:webServiceUrl] encoding:NSUTF8StringEncoding error:NULL];
    NSDictionary* webServiceData = [webServiceDataAsJson JSONValue];

    bigHouseAppDelegate.userObject = webServiceData;

    // go to next view
    Screen3ViewController*
        viewController = [[Screen3ViewController alloc] initWithNibName:@"Screen3ViewController" bundle:nil];
        viewController.view.frame = self.view.frame;
        viewController.view.autoresizingMask = self.view.autoresizingMask;
    
    [bigHouseAppDelegate setRootController:viewController];
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    BOOL canShareAnyhow = [FBNativeDialogs canPresentShareDialogWithSession:nil];

    self.profilePic.profileID = nil;            
    self.loggedInUser = nil;
}

#pragma mark -

// UIAlertView helper for post buttons
- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error {

    NSString *alertMsg;
    NSString *alertTitle;
    if (error) {
        alertMsg = error.localizedDescription;
        alertTitle = @"Error";
    } else {
        NSDictionary *resultDict = (NSDictionary *)result;
        alertMsg = [NSString stringWithFormat:@"Successfully posted '%@'.\nPost ID: %@", 
                    message, [resultDict valueForKey:@"id"]];
        alertTitle = @"Success";
    }

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertMsg
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}


-(IBAction) registerWithPinTap:(id)senderId{

    // GLOBAL APP
    BigHouseAppDelegate *bigHouseAppDelegate = (BigHouseAppDelegate *)[[UIApplication sharedApplication] delegate];

    // WEBSERVICE
    // UserService.svc/RegisterWithPin/1401
    NSString* webServiceUrl = [NSString stringWithFormat:@"%@%@",
                               @"http://a4642a88bb0f4542a631a92fc8d21d1d.cloudapp.net:8080/UserService.svc/RegisterWithPin/",
                               @"1401"];
    
    NSString* webServiceDataAsJson = [NSString stringWithContentsOfURL:[NSURL URLWithString:webServiceUrl] encoding:NSUTF8StringEncoding error:NULL];
    NSDictionary* webServiceData = [webServiceDataAsJson JSONValue];
    
    bigHouseAppDelegate.userObject = webServiceData;
    
    // go to next view
    Screen5ViewController*
    viewController = [[Screen5ViewController alloc] initWithNibName:@"Screen5ViewController" bundle:nil];
    viewController.view.frame = self.view.frame;
    viewController.view.autoresizingMask = self.view.autoresizingMask;
    
    [bigHouseAppDelegate setRootController:viewController];
}

@end
