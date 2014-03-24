
#import <UIKit/UIKit.h>

@interface Screen4ViewController : UIViewController<UITableViewDataSource,UITabBarDelegate>
{
    IBOutlet UITabBar *userList;
    IBOutlet UIImageView *picture;
    IBOutlet UITableView *feed;
    
    NSArray* loadedUsers;
    NSDictionary* currentUser;
    
    NSTimer *timer;
}

//
@property (nonatomic, retain) NSArray* feedData;
@property (nonatomic, retain) NSTimer* timer;

//
@property (nonatomic, retain) UITabBar* userList;
@property (nonatomic, retain) UIImageView* picture;
-(IBAction) progressTap:(id)senderId;
-(IBAction) callTap:(id)senderId;
@property (nonatomic, retain) UITableView* feed;
-(IBAction) settingsTap:(id)senderId;

@end
