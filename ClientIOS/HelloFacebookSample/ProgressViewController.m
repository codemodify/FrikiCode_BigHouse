
#import "ProgressViewController.h"
#import "SBJson.h"

@interface ProgressViewController ()

@end

@implementation ProgressViewController

@synthesize lineChartView;

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

    // charting
    [self.view setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    [self setTitle:@"Line Chart"];
    
    self.lineChartView = [[PCLineChartView alloc] initWithFrame:CGRectMake(10,10,[self.view bounds].size.width-20,[self.view bounds].size.height-20)];
    [self.lineChartView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    self.lineChartView.minValue = -40;
    self.lineChartView.maxValue = 100;
    [self.view addSubview:self.lineChartView];
    
//    NSString *sampleFile = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"sample_linechart_data.json"];
//    NSString *jsonString = [NSString stringWithContentsOfFile:sampleFile encoding:NSUTF8StringEncoding error:nil];
    
    //    NSString* webServiceUrl = @"http://a4642a88bb0f4542a631a92fc8d21d1d.cloudapp.net:8080/FamilyService.svc/GetPatientHistory/1";
    //    NSString* webServiceData = [NSString stringWithContentsOfURL:[NSURL URLWithString:webServiceUrl] encoding:NSUTF8StringEncoding error:NULL];
    //    self.data = [webServiceData JSONValue];

    
    
    
    // GLOBAL APP
    //BigHouseAppDelegate *bigHouseAppDelegate = (BigHouseAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // WEBSERVICE
    // CommunicationService.svc/GetProgressSample
    // CommunicationService.svc/GetUsers/45ca8921-a116-4a99-817d-36c6a64c2f52
    NSString* webServiceUrl = [NSString stringWithFormat:@"%@",
                               @"http://a4642a88bb0f4542a631a92fc8d21d1d.cloudapp.net:8080/CommunicationService.svc/GetProgressSample"];
    
    NSString* webServiceDataAsJson = [NSString stringWithContentsOfURL:[NSURL URLWithString:webServiceUrl] encoding:NSUTF8StringEncoding error:NULL];
    
    webServiceDataAsJson = [webServiceDataAsJson substringFromIndex:1];
    webServiceDataAsJson = [webServiceDataAsJson substringToIndex:[webServiceDataAsJson length]-1];
    
    webServiceDataAsJson = [webServiceDataAsJson stringByReplacingOccurrencesOfString: @"\\\"" withString:@"\""];

    NSDictionary *sampleInfo = [webServiceDataAsJson JSONValue];
    
    NSMutableArray *components = [NSMutableArray array];
    for (int i=0; i<[[sampleInfo objectForKey:@"data"] count]; i++)
    {
        NSDictionary *point = [[sampleInfo objectForKey:@"data"] objectAtIndex:i];
        PCLineChartViewComponent *component = [[PCLineChartViewComponent alloc] init];
        [component setTitle:[point objectForKey:@"title"]];
        [component setPoints:[point objectForKey:@"data"]];
        [component setShouldLabelValues:NO];
        
        if (i==0)
        {
            [component setColour:PCColorYellow];
        }
        else if (i==1)
        {
            [component setColour:PCColorGreen];
        }
        else if (i==2)
        {
            [component setColour:PCColorOrange];
        }
        else if (i==3)
        {
            [component setColour:PCColorRed];
        }
        else if (i==4)
        {
            [component setColour:PCColorBlue];
        }
        
        [components addObject:component];
    }
    [self.lineChartView setComponents:components];
    [self.lineChartView setXLabels:[sampleInfo objectForKey:@"x_labels"]];
    
    // add the back button for modal
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [backButton addTarget:self
                   action:@selector(backAction:)
         forControlEvents:UIControlEventTouchDown];
    
    [backButton setTitle:@" Progress"
                forState:UIControlStateNormal];
    backButton.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    
    self.navigationItem.titleView = backButton;
}
-(void) backAction:(id)sender
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
