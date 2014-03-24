

#import <UIKit/UIKit.h>

@interface Screen5ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>
{
    IBOutlet UIImageView *picture;
    IBOutlet UILabel *name;
    IBOutlet UITableView *questions;
    
    NSTimer *timer;
    NSString* lastMessageId;
}

//
@property (nonatomic, retain) NSArray* feedData;
@property (nonatomic, retain) NSTimer* timer;
@property (nonatomic, retain) NSString* lastMessageId;

//
@property (nonatomic, retain) UIImageView* picture;
@property (nonatomic, retain) UILabel* name;
-(IBAction) progressTap:(id)senderId;
@property (nonatomic, retain) UITableView* questions;

@end
