
#import "Screen5ViewController.h"
#import "ProgressViewController.h"
#import "BigHouseAppDelegate.h"
#import "SBJson.h"

@interface Screen5ViewController ()

@end

@implementation Screen5ViewController

@synthesize feedData, name, picture, questions, timer, lastMessageId;

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
    
    // timer
    [timer invalidate];
    timer = nil;
    timer = [NSTimer scheduledTimerWithTimeInterval: 5.0
                                             target: self
                                           selector: @selector(YourFunctionYouWantToCall)
                                           userInfo: nil
                                            repeats: YES];
    
    self.questions.dataSource = self;
    self.questions.delegate = self;
    
    // GLOBAL APP
    BigHouseAppDelegate *bigHouseAppDelegate = (BigHouseAppDelegate *)[[UIApplication sharedApplication] delegate];

    self.picture.image = [UIImage imageNamed:@"virginia.jpg"];
    self.name.text = [bigHouseAppDelegate.userObject objectForKey:@"HelperName"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshFeed {
    
    // GLOBAL APP
    BigHouseAppDelegate *bigHouseAppDelegate = (BigHouseAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // WEBSERVICE
    // CommunicationService.svc/GetMessagesForUser/45ca8921-a116-4a99-817d-36c6a64c2f52;86207dc0-b3c8-4d96-8546-49c258d5b638
    
    NSString* webServiceUrl = [NSString stringWithFormat:@"%@%@;%@",
                               @"http://a4642a88bb0f4542a631a92fc8d21d1d.cloudapp.net:8080/CommunicationService.svc/GetMessagesForUser/",
                               [bigHouseAppDelegate.userObject objectForKey:@"ParentId"],
                               [bigHouseAppDelegate.userObject objectForKey:@"Id"]];
    
    NSString* webServiceDataAsJson = [NSString stringWithContentsOfURL:[NSURL URLWithString:webServiceUrl] encoding:NSUTF8StringEncoding error:NULL];
    
    self.feedData = [webServiceDataAsJson JSONValue];
    [self.questions reloadData];
}

-(void)YourFunctionYouWantToCall {
    
//    [timer invalidate];
//    timer = nil;
    
    [self refreshFeed];
}

#pragma mark - Table view delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [feedData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    NSDictionary* dict1 = (NSDictionary*)[feedData objectAtIndex:[indexPath row]];
    NSDictionary* dict2 = [dict1 objectForKey:@"Message"];
    
    cell.imageView.image = [UIImage imageNamed:@"nicu.jpg"];
    cell.textLabel.text = [dict2 objectForKey:@"Content"];
    //cell.detailTextLabel.text = [dict objectForKey:@"Question"];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary* dict1 = (NSDictionary*)[feedData objectAtIndex:[indexPath row]];
    NSDictionary* dict2 = [dict1 objectForKey:@"Message"];
    
    NSNumber* messageType = [dict2 objectForKey:@"Type"];
    
    self.lastMessageId = [dict2 objectForKey:@"Id"];
    
    if ( [messageType intValue] == 1 ){
        UIActionSheet*
            popupQuery = [[UIActionSheet alloc] initWithTitle:@""
                                                     delegate:self
                                            cancelButtonTitle:nil
                                       destructiveButtonTitle:@"Yes"
                                            otherButtonTitles:@"No", @"So So", nil];
            popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
            [popupQuery showInView:self.view];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
    NSString* answer;
    
    if (buttonIndex == 0) {
        answer = @"Yes";
	} else if (buttonIndex == 1) {
        answer = @"No";
	} else if (buttonIndex == 2) {
        answer = @"So So";
	}
    
    // GLOBAL APP
    BigHouseAppDelegate *bigHouseAppDelegate = (BigHouseAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // WEBSERVICE
    // CommunicationService.svc/RegisterAnswerForUser/86207dc0-b3c8-4d96-8546-49c258d5b638;a3ebd50c-35ec-4f2c-a00f-9151d2fff8a3;Yes
    
    NSString* webServiceUrl = [NSString stringWithFormat:@"%@%@;%@;%@",
                               @"http://a4642a88bb0f4542a631a92fc8d21d1d.cloudapp.net:8080/CommunicationService.svc/RegisterAnswerForUser/",
                               [bigHouseAppDelegate.userObject objectForKey:@"Id"],
                               lastMessageId,
                               answer];
    
    NSString* webServiceDataAsJson = [NSString stringWithContentsOfURL:[NSURL URLWithString:webServiceUrl] encoding:NSUTF8StringEncoding error:NULL];
    
//    self.feedData = [webServiceDataAsJson JSONValue];
//    [self.questions reloadData];
}

#pragma mark -


-(IBAction) progressTap:(id)senderId {

    ProgressViewController* viewController = [[ProgressViewController alloc] init];
    viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:viewController];
    
    [self presentModalViewController:navController animated:YES];
}

@end
