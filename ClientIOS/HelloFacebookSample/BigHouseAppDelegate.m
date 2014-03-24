
#import "BigHouseAppDelegate.h"

#import "Screen1ViewController.h"
//#import <FacebookSDK/FacebookSDK.h>

@implementation BigHouseAppDelegate

@synthesize window = _window;
@synthesize userObject;

// FBSample logic
// If we have a valid session at the time of openURL call, we handle Facebook transitions
// by passing the url argument to handleOpenURL; see the "Just Login" sample application for
// a more detailed discussion of handleOpenURL
//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation {
//    // attempt to extract a token from the url
//    return [FBSession.activeSession handleOpenURL:url]; 
//}

- (void)applicationWillTerminate:(UIApplication *)application {
    // FBSample logic
    // if the app is going away, we close the session object
//    [FBSession.activeSession close];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // BUG:
    // Nib files require the type to have been loaded before they can do the
    // wireup successfully.  
    // http://stackoverflow.com/questions/1725881/unknown-class-myclass-in-interface-builder-file-error-at-runtime
//    [FBProfilePictureView class];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UIViewController* viewController = [[Screen1ViewController alloc] initWithNibName:@"Screen1ViewController" bundle:nil];
    [self setRootController:viewController];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application	{
    // FBSample logic
    // We need to properly handle activation of the application with regards to SSO
    //  (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
//    [FBSession.activeSession handleDidBecomeActive];
}

-(void)setRootController:(UIViewController*)uiViewController{
    self.window.rootViewController = uiViewController;
}

@end
