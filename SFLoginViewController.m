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

@interface SFLoginViewController ()  <FBLoginViewDelegate>

@property (strong, nonatomic) id<FBGraphUser> loggedInUser;

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
    loginView.frame = CGRectOffset(loginView.frame, 5, 25);
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
    NSLog(@"User ID: %@", user.id);
    NSLog(@"User ID: %@", user.first_name);
    NSLog(@"User ID: %@", user.last_name);

    
    
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object
    //self.labelFirstName.text = [NSString stringWithFormat:@"Hello %@!", user.first_name];
    // setting the profileID property of the FBProfilePictureView instance
    // causes the control to fetch and display the profile picture for the user
    //self.profilePic.profileID = user.id;
    //self.loggedInUser = user;
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    NSLog(@"%@", loginView);
    [self performSegueWithIdentifier:@"login" sender:self];
    //SFViewController *viewController = [[SFViewController alloc] init];
    //[self presentViewController:viewController animated:YES completion:nil];
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

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    // see https://developers.facebook.com/docs/reference/api/errors/ for general guidance on error handling for Facebook API
    // our policy here is to let the login view handle errors, but to log the results
    NSLog(@"FBLoginView encountered an error=%@", error);
}

//- (void) performPublishAction:(void (^)(void)) action {
//    // we defer request for permission to post to the moment of post, then we check for the permission
//    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
//        // if we don't already have the permission, then we request it now
//        [FBSession.activeSession requestNewPublishPermissions:@[@"publish_actions"]
//                                              defaultAudience:FBSessionDefaultAudienceFriends
//                                            completionHandler:^(FBSession *session, NSError *error) {
//                                                if (!error) {
//                                                    action();
//                                                } else if (error.fberrorCategory != FBErrorCategoryUserCancelled){
//                                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Permission denied"
//                                                                                                        message:@"Unable to get permission to post"
//                                                                                                       delegate:nil
//                                                                                              cancelButtonTitle:@"OK"
//                                                                                              otherButtonTitles:nil];
//                                                    [alertView show];
//                                                }
//                                            }];
//    } else {
//        action();
//    }
//    
//}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen: {
//            UIViewController *topViewController =
//            [self.navController topViewController];
//            if ([[topViewController modalViewController]
//                 isKindOfClass:[SCLoginViewController class]]) {
//                [topViewController dismissModalViewControllerAnimated:YES];
            NSLog(@"State is open");
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            // Once the user has logged in, we want them to
            // be looking at the root view.
            //[self.navController popToRootViewControllerAnimated:NO];
            
            [FBSession.activeSession closeAndClearTokenInformation];
            
            //[self showLoginView];
            break;
        default:
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }    
}

-(IBAction)facebookPost:(id)sender
{
    [FBRequestConnection startForPostStatusUpdate: @"I just updated my status" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        
        if (!error)
        {
            NSLog(@"Successfully updated status");
        }
        else
        {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        
    }];
}

@end
