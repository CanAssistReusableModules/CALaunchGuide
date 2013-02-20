# CALaunchGuide

## Project Setup

1. _Download and unzip the files._
2. _Copy the "Classes" and "images" folder to your project._
3. _Right click your project._
4. _Click "Add files to "your project" "._
5. _Select "Classes" and "images" folders._
6. _Select "Create groups for any added folders" and click "Add"._
7. _left lick your project->Build Phases->Link Binary With Libraries->Add "QuartzCore.framework"_


## Example Code

_Example

> LaunchGuideViewController *launchGuideViewController = [LaunchGuideViewController alloc] initWithNibName:@"LaunchGuideViewController" bundle:nil];

> [self.window.rootViewController presentModalViewController:launchGuideViewController animated:NO];

## Customization

_Inside LaunchGuideViewController.m_

> static NSUInteger const NumberOfPages = 6;

> static NSUInteger const PageCornerRadians = 5;

> static NSUInteger const IPadNameLabelFontSize = 25;

> static NSUInteger const IPadDetailLabelFontSize = 24;

> static NSUInteger const IPhoneNameLabelFontSize = 18;

> static NSUInteger const IPhoneDetailLabelFontSize = 16;

> -(void)viewDidLoad
> {	

> 	self.guideImageArray = [[NSArray alloc] initWithObjects: ];

> 	self.nameArray = [[NSArray alloc] initWithObjects: ];

> 	self.detailArray = [[NSArray alloc] initWithObjects: ];

> }

