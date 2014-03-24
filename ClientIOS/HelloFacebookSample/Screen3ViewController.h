
#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

@interface Screen3ViewController : UIViewController<ABPeoplePickerNavigationControllerDelegate, UITableViewDataSource>
{
    NSString* facebookName;
    UIImage* facebookImage;
    
    IBOutlet UIImageView *pic;
    IBOutlet UILabel* name;
    
    IBOutlet UITableView* usersTableView;
    
    NSMutableArray* _users;
    NSMutableArray* _phones;
    NSMutableArray* _pictures;
}

@property (nonatomic, retain) NSString* facebookName;
@property (nonatomic, retain) UIImage* facebookImage;

@property (nonatomic, retain) UIImageView* pic;
@property (nonatomic, retain) UILabel* name;

@property (nonatomic, retain) UITableView* usersTableView;

-(IBAction) addLovedOnes:(id)senderId;
-(IBAction) sendInvites:(id)senderId;

@end
