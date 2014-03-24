
#import "Screen3ViewController.h"
#import "Screen4ViewController.h"
#import "BigHouseAppDelegate.h"
//#import "Base64.h"

@interface Screen3ViewController ()

@end

@implementation Screen3ViewController

@synthesize facebookName, facebookImage;
@synthesize pic, name;
@synthesize usersTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _users = [[NSMutableArray alloc] init];
    _phones = [[NSMutableArray alloc] init];
    _pictures = [[NSMutableArray alloc] init];
    
    self.usersTableView.dataSource = self;
    
    // set ui elements
    BigHouseAppDelegate *bigHouseAppDelegate = (BigHouseAppDelegate *)[[UIApplication sharedApplication] delegate];

//    [Base64 initialize];
//    NSData* data = [Base64 decode:[bigHouseAppDelegate.userObject objectForKey:@"HelperPhoto"] ];
    
    self.pic.image = [UIImage imageNamed:@"nicu.jpg"]; //[UIImage imageWithData:data];
    self.name.text = [bigHouseAppDelegate.userObject objectForKey:@"HelperName"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) addLovedOnes:(id)senderId
{
    ABPeoplePickerNavigationController*
        picker = [[ABPeoplePickerNavigationController alloc] init];
        picker.peoplePickerDelegate = self;
    
    [self presentModalViewController:picker animated:YES];
}

#pragma mark - PhoneBook delegates

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    [self displayPerson:person];
    [self dismissModalViewControllerAnimated:YES];
    
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

-(void)displayPerson:(ABRecordRef)person
{
    NSString* name = nil;
    NSString* phone = nil;
    UIImage* picture = nil;
    
    //
    name = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    
    //
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        phone = (__bridge_transfer NSString*)
        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    } else {
        phone = @"[None]";
    }
    
    //
    CFDataRef imageData = ABPersonCopyImageData(person);
    picture = [UIImage imageWithData:(__bridge NSData *)imageData]; //       CGImageGetWidth((__bridge CGImageRef)hourHand.contents);
    CFRelease(imageData);
    
    [_users addObject:name];
    [_phones addObject:phone];
    [_pictures addObject:picture];
    
    [self.usersTableView reloadData];
}

#pragma mark -

#pragma mark - Table view delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    cell.textLabel.text = (NSString*)[_users objectAtIndex:[indexPath row]];
    
    return cell;
}

#pragma mark -


-(IBAction) sendInvites:(id)senderId
{
    // GLOBAL APP
    BigHouseAppDelegate *bigHouseAppDelegate = (BigHouseAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    for( int i=0; i < _users.count; i++ ) {
        
        NSString* userName = [_users objectAtIndex:i];
        NSString* userPhone = [_phones objectAtIndex:i];
        UIImage* userImage = [_pictures objectAtIndex:i];
        NSString* userImageAsBase64 = nil;
        
        // to base 64
//        NSData* data = UIImageJPEGRepresentation(userImage, 1.0f);
//        [Base64 initialize];
        userImageAsBase64 = @"1234=";//[Base64 encode:data];
        
        // WEBSERVICE
        // UserService.svc/PreparePin/{8D2E7099-A4E5-4A05-85AD-5E1A3A9093FE};1401;Jane;12345678qweasdzxc=
        NSString* webServiceUrl = [NSString stringWithFormat:@"%@%@;%@;%@;%@",
                                   @"http://a4642a88bb0f4542a631a92fc8d21d1d.cloudapp.net:8080/UserService.svc/PreparePin/",
                                   [bigHouseAppDelegate.userObject objectForKey:@"Id"],
                                   @"1401",
                                   userName,
                                   userImageAsBase64];
        
        NSString* webServiceDataAsJson = [NSString stringWithContentsOfURL:[NSURL URLWithString:webServiceUrl] encoding:NSUTF8StringEncoding error:NULL];
        //NSDictionary* webServiceData = [webServiceDataAsJson JSONValue];
    }
    
    // go to next view
    Screen4ViewController*
        viewController = [[Screen4ViewController alloc] initWithNibName:@"Screen4ViewController" bundle:nil];
        viewController.view.frame = self.view.frame;
        viewController.view.autoresizingMask = self.view.autoresizingMask;

    [bigHouseAppDelegate setRootController:viewController];
}

@end
