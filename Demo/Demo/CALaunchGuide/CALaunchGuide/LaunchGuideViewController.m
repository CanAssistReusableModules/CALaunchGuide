//
//  LaunchGuideViewController.m
//  Task Sequencer
//
//  Created by Peter on 13-01-18.
//
//

#import "LaunchGuideViewController.h"

static NSUInteger const NumberOfPages = 6;
static NSUInteger const PageCornerRadians = 5;

static NSUInteger const IPadNameLabelFontSize = 25;
static NSUInteger const IPadDetailLabelFontSize = 24;

static NSUInteger const IPhoneNameLabelFontSize = 18;
static NSUInteger const IPhoneDetailLabelFontSize = 16;


@interface LaunchGuideViewController ()

@end

@implementation LaunchGuideViewController
@synthesize pageControl;
@synthesize guideImage;
@synthesize guideImageArray;
@synthesize startButton;
@synthesize container;
@synthesize nameLabel;
@synthesize detailLabel;
@synthesize prevButton;
@synthesize nextButton;
@synthesize getStartedView;
@synthesize detailArray;
@synthesize nameArray;

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
    [self.pageControl setNumberOfPages:NumberOfPages];
    [self.pageControl setCurrentPage:0];
    [self.startButton setHidden:YES];
    currentPage = 0;
    [self.prevButton setHidden:YES];
    
    self.guideImageArray = [[NSArray alloc] initWithObjects:
                       [UIImage imageNamed:@"no1@2x.png"],
                       [UIImage imageNamed:@"no2@2x.png"],
                       [UIImage imageNamed:@"no3@2x.png"],
                       [UIImage imageNamed:@"no4@2x.png"],
                       [UIImage imageNamed:@"no5@2x.png"],
                        [UIImage imageNamed:@"no6@2x.png"],
                       nil];
    
    self.nameArray = [[NSArray alloc] initWithObjects:
                    @"Welcome to Task Manager",
                    @"Your personal tasks",
                    @"Setting reminders",
                    @"Alerting",
                    @"Completing tasks",
                    @"What to do from here?",
                    nil];
    
    self.detailArray = [[NSArray alloc] initWithObjects:
                      @"The Task Manager is designed to help you remember what you have to do every day, when you have to do it, and show you how to get it done. ",
                      @"You create your own tasks that describe what you need to do. Each task can be broken down into a series of steps, with a photo, description, or audio recording.",
                      @"Tasks can be scheduled to remind you to do them on certain days. The To-do list shows all the tasks that are scheduled for today and lets you add new schedules.",
                      @"You will get an alert when a task is scheduled to occur. Opening the notification will launch that task.",
                      @"When you are done a task, you can mark it as complete. The to-do list will show you whether you’ve completed the scheduled tasks.",
                      @"",
                      nil];
    
    self.container.layer.cornerRadius = PageCornerRadians;
    self.container.layer.masksToBounds = YES;

    self.guideImage.image = [self.guideImageArray objectAtIndex:currentPage];
    NSLog(@"current page = %d",currentPage);
    
    imageFrame = self.guideImage.frame;
    
    self.nameLabel.text = [self.nameArray objectAtIndex:currentPage];
    self.detailLabel.text = [self.detailArray objectAtIndex:currentPage];
    
    [self hideGetStartedView];
    [self setupFontForDevice];
    // -----------------------------
    // One finger, swipe left
    // -----------------------------
    UISwipeGestureRecognizer *oneFingerSwipeLeft =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextView)];
    [oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:oneFingerSwipeLeft];
    
    // -----------------------------
    // One finger, swipe right
    // -----------------------------
    UISwipeGestureRecognizer *oneFingerSwipeRight =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(prevView)];
    [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:oneFingerSwipeRight];
}

-(void)hideGetStartedView{
    [self.getStartedView setHidden:YES];
}

-(void)showGetStartedView{
    [self.getStartedView setHidden:NO];
}

-(void)setupFontForDevice{
     if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
         [self.nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:IPadNameLabelFontSize]];
         [self.detailLabel  setFont:[UIFont fontWithName:@"Helvetica" size:IPadDetailLabelFontSize]];
     }
     else{
         [self.nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:IPhoneNameLabelFontSize]];
         [self.detailLabel  setFont:[UIFont fontWithName:@"Helvetica" size:IPhoneDetailLabelFontSize]];
     }
}

-(void)nextView{
    if (currentPage<5) {
        [self.prevButton setHidden:NO];
        CATransition *animation = [CATransition animation];
        animation.duration = 0.25;
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromRight;
        [container.layer addAnimation:animation forKey:@"imageTransition"];

        NSLog(@"%d image in guide image array",[self.guideImageArray count]);
        currentPage = currentPage+1;
        NSLog(@"current page = %d",currentPage);
        [self.pageControl setCurrentPage:currentPage];
        self.guideImage.image = [self.guideImageArray objectAtIndex:currentPage];
        self.nameLabel.text = [self.nameArray objectAtIndex:currentPage];
        self.detailLabel.text = [self.detailArray objectAtIndex:currentPage];
        if (currentPage==5 && self.startButton.hidden == YES) {
            
            CATransition *animation = [CATransition animation];
            animation.duration = 0.25;
            animation.type = kCATransitionPush;
            animation.subtype = kCATransitionFromRight;
            [self.startButton.layer addAnimation:animation forKey:@"imageTransition"];
            [self.startButton setHidden:NO];
        }
        if (currentPage==5) {
            [self showGetStartedView];
        }
    }
    else{
        NSLog(@"dismiss modal view");
        [self dismissModalViewControllerAnimated:YES];
    }
}

-(void)prevView{
    if (currentPage>0) {
    CATransition *animation = [CATransition animation];
    animation.duration = 0.25;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [container.layer addAnimation:animation forKey:@"imageTransition"];
    NSLog(@"%d image in guide image array",[self.guideImageArray count]);
    currentPage = currentPage-1;
    [self.pageControl setCurrentPage:currentPage];
    NSLog(@"current page = %d",currentPage);
    self.guideImage.image = [self.guideImageArray objectAtIndex:currentPage];
    self.nameLabel.text = [self.nameArray objectAtIndex:currentPage];
    self.detailLabel.text = [self.detailArray objectAtIndex:currentPage];
        if (currentPage==0) {
            [self.prevButton setHidden:YES];
        }
        if (currentPage!=5) {
            [self hideGetStartedView];
        }
    }
}

-(IBAction)next:(id)sender{
    [self nextView];
}

-(IBAction)prev:(id)sender{    
    [self prevView];
}


-(IBAction)startPressed:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
