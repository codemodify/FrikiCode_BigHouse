//
//  CallViewController.m
//  BigHouse
//
//  Created by Nicolae Carabut on 12/2/12.
//
//

#import "CallViewController.h"

@interface CallViewController ()

@end

@implementation CallViewController

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

    // add the back button for modal
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [backButton addTarget:self
                   action:@selector(backAction:)
         forControlEvents:UIControlEventTouchDown];
    
    [backButton setTitle:@" Communicate"
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
