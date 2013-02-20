//
//  LaunchGuideViewController.m
//  Task Sequencer
//
//  Created by Peter on 13-01-18.
//
//

#import "LaunchGuideViewController.h"

static NSUInteger const NumberOfPages = 3;
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
                       nil];
    
    self.nameArray = [[NSArray alloc] initWithObjects:
                    @"Welcome to xxxxxxx",
                    @"xxxx xxxx xxxxx",
                    @"xxxx xxxxx xxxxx",
                    nil];
    
    self.detailArray = [[NSArray alloc] initWithObjects:
                      @"fadsfjdsf;jsflj fasdklfjsadfjd sfsadfjdslkfj adsfljsdaf sadfljs.",
                      @"eernefsdajfo  rewrfnsadoi nwieqn ajfnq fasdf qjasnf qnsdiofjsanf qfnwfijdfas nfq fqjdn.",
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
    if (currentPage<NumberOfPages-1) {
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
        if (currentPage==NumberOfPages-1 && self.startButton.hidden == YES) {
            
            CATransition *animation = [CATransition animation];
            animation.duration = 0.25;
            animation.type = kCATransitionPush;
            animation.subtype = kCATransitionFromRight;
            [self.startButton.layer addAnimation:animation forKey:@"imageTransition"];
            [self.startButton setHidden:NO];
        }
        if (currentPage==NumberOfPages-1) {
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
        if (currentPage!=NumberOfPages-1) {
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
