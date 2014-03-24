
#import "Screen4ViewController.h"
#import "SBJSON.h"
#import "BigHouseAppDelegate.h"
#import "CallViewController.h"
#import "ProgressViewController.h"


@interface Screen4ViewController ()

@end

@implementation Screen4ViewController

@synthesize userList, picture, feed;
@synthesize feedData, timer;

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

    // GLOBAL APP
    BigHouseAppDelegate *bigHouseAppDelegate = (BigHouseAppDelegate *)[[UIApplication sharedApplication] delegate];

    // WEBSERVICE
    // CommunicationService.svc/GetUsers/45ca8921-a116-4a99-817d-36c6a64c2f52
    NSString* webServiceUrl = [NSString stringWithFormat:@"%@%@",
                               @"http://a4642a88bb0f4542a631a92fc8d21d1d.cloudapp.net:8080/CommunicationService.svc/GetUsers/",
                               [bigHouseAppDelegate.userObject objectForKey:@"Id"]];
    
    NSString* webServiceDataAsJson = [NSString stringWithContentsOfURL:[NSURL URLWithString:webServiceUrl] encoding:NSUTF8StringEncoding error:NULL];
    NSArray* webServiceData = [webServiceDataAsJson JSONValue];
    
    loadedUsers = webServiceData;
    int pos = 0;

    NSMutableArray *itemsArray = [[NSMutableArray alloc] init];
    for (NSDictionary* dic in loadedUsers) {

        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:[dic objectForKey:@"HelperName"] image:nil tag:pos];

        [itemsArray addObject:tabBarItem];
        
        pos++;
    }
    [self.userList setItems:itemsArray];
    
    //
    [self refreshFeed];
    self.feed.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    NSDictionary* dic = [loadedUsers objectAtIndex:item.tag];
    
    currentUser = dic;
    
    [self refreshFeed];
}

-(void)refreshFeed {

    // timer
    [timer invalidate];
    timer = nil;
    timer = [NSTimer scheduledTimerWithTimeInterval: 5
                                             target: self
                                           selector: @selector(YourFunctionYouWantToCall)
                                           userInfo: nil
                                            repeats: YES];
}
    
-(void)YourFunctionYouWantToCall {
    
//    [timer invalidate];
//    timer = nil;
    

    
    
    if( loadedUsers.count == 0 )
        return;
    
    if( currentUser == nil ){
        currentUser = [loadedUsers objectAtIndex:0];
    }
    
    // GLOBAL APP
    //BigHouseAppDelegate *bigHouseAppDelegate = (BigHouseAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // WEBSERVICE
    // CommunicationService.svc/GetUsers/45ca8921-a116-4a99-817d-36c6a64c2f52
    NSString* webServiceUrl = [NSString stringWithFormat:@"%@%@",
                               @"http://a4642a88bb0f4542a631a92fc8d21d1d.cloudapp.net:8080/CommunicationService.svc/GetFeedsForUser/",
                               [currentUser objectForKey:@"Id"]];
    
    NSString* webServiceDataAsJson = [NSString stringWithContentsOfURL:[NSURL URLWithString:webServiceUrl] encoding:NSUTF8StringEncoding error:NULL];
    
    self.feedData = [webServiceDataAsJson JSONValue];
    [self.feed reloadData];
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
    
    NSDictionary* dict = (NSDictionary*)[feedData objectAtIndex:[indexPath row]];
    
    cell.imageView.image = [UIImage imageNamed:@"virginia.jpg"];
    cell.textLabel.text = [dict objectForKey:@"Content"];
    cell.detailTextLabel.text = [dict objectForKey:@"Question"];
    
    return cell;
}

#pragma mark -

-(IBAction) progressTap:(id)senderId{
    
    ProgressViewController* viewController = [[ProgressViewController alloc] init];
    viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:viewController];
    
    [self presentModalViewController:navController animated:YES];
}

-(IBAction) callTap:(id)senderId{
    
    CallViewController* viewController = [[CallViewController alloc] init];
    viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:viewController];
    
    [self presentModalViewController:navController animated:YES];
}

-(IBAction) settingsTap:(id)senderId{
    
}

@end
