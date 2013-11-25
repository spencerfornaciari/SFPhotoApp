//
//  SFLoginViewController.m
//  SFImageApp
//
//  Created by Spencer Fornaciari on 11/24/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import "SFLoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "SFViewController.h"

@interface SFLoginViewController ()

@end

@implementation SFLoginViewController

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
    
    //self.view.backgroundColor = [UIColor blueColor];
    
    FBLoginView *loginView = [[FBLoginView alloc] initWithPublishPermissions:@[@"publish_actions"]
                                                              defaultAudience:FBSessionDefaultAudienceFriends];
    
    loginView.delegate = self;
    // Align the button in the center horizontally
    loginView.frame = CGRectOffset(loginView.frame,
                                   (self.view.center.x - (loginView.frame.size.width / 2)),
                                   self.view.center.y);
    [self.view addSubview:loginView];
    [loginView sizeToFit];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object
    
    NSLog(@"%@", user);
    //self.labelFirstName.text = [NSString stringWithFormat:@"Hello %@!", user.first_name];
    // setting the profileID property of the FBProfilePictureView instance
    // causes the control to fetch and display the profile picture for the user
   // self.profilePic.profileID = user.id;
    //self.loggedInUser = user;
}

//-(IBAction)facebookLogin:(id)sender
//{
//    [FBSession openActiveSessionWithPublishPermissions: @[@"publish_actions"]
//                                       defaultAudience: FBSessionDefaultAudienceEveryone allowLoginUI: YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error)
//     {
//         [self sessionStateChanged: session state: status error: error];
//     }];
//}



//-(IBAction)openSession
//{
//    [FBSession openActiveSessionWithPublishPermissions: @[@"publish_actions"]
//                                       defaultAudience: FBSessionDefaultAudienceEveryone allowLoginUI: YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error)
//     {
//         [self sessionStateChanged: session state: status error: error];
//     }];
// 
//}

//- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
//    self.publishButton.hidden = NO;
//}


@end
