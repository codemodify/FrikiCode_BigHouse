
#import <UIKit/UIKit.h>
//#import <FacebookSDK/FacebookSDK.h>

@interface BigHouseAppDelegate : UIResponder<UIApplicationDelegate>
{
    NSDictionary* userObject;
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) NSDictionary* userObject;

-(void)setRootController:(UIViewController*)uiViewController;



@end
