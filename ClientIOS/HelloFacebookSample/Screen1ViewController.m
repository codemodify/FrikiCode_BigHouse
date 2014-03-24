
#import "Screen1ViewController.h"
#import "Screen2ViewController.h" 
#import "BigHouseAppDelegate.h"

@interface Screen1ViewController ()

@end

@implementation Screen1ViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) newMemeberTap:(id)senderId
{
    Screen2ViewController*
        viewController = [[Screen2ViewController alloc] initWithNibName:@"Screen2ViewController" bundle:nil];
        viewController.view.frame = self.view.frame;
        viewController.view.autoresizingMask = self.view.autoresizingMask;

    BigHouseAppDelegate *bigHouseAppDelegate = (BigHouseAppDelegate *)[[UIApplication sharedApplication] delegate];
    [bigHouseAppDelegate setRootController:viewController];
}

@end
