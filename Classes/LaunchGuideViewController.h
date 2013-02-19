//
//  LaunchGuideViewController.h
//  Task Sequencer
//
//  Created by Peter on 13-01-18.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LaunchGuideViewController : UIViewController{
    UIImageView* guideImage;
    UIPageControl* pageControl;
    UIView* container;
    UIView* getStartedView;
    int currentPage;
    NSArray* guideImageArray;
    UIButton* startButton;
    UILabel* nameLabel;
    UILabel* detailLabel;
    NSArray* nameArray;
    NSArray* detailArray;
    UIButton* nextButton;
    UIButton* prevButton;
    CGRect imageFrame;
}
@property (nonatomic, strong) IBOutlet UIButton* nextButton;
@property (nonatomic, strong) IBOutlet UIButton* prevButton; 
@property (nonatomic, strong) IBOutlet UIButton* startButton;
@property (nonatomic, strong) IBOutlet UIImageView* guideImage;
@property (nonatomic, strong) IBOutlet UIPageControl* pageControl;
@property (nonatomic, strong) NSArray* guideImageArray;
@property (nonatomic, strong) IBOutlet UIView* container;
@property (nonatomic, strong) IBOutlet UIView* getStartedView;
@property (nonatomic, strong) IBOutlet UILabel* nameLabel;
@property (nonatomic, strong) IBOutlet UILabel* detailLabel;
@property (nonatomic, strong) NSArray* nameArray;
@property (nonatomic, strong) NSArray* detailArray;

-(IBAction)startPressed:(id)sender;
-(IBAction)next:(id)sender;
-(IBAction)prev:(id)sender;

@end
