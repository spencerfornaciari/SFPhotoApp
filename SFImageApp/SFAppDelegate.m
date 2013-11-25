//
//  SFAppDelegate.m
//  SFImageApp
//
//  Created by Spencer Fornaciari on 11/5/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import "SFAppDelegate.h"
#import "SFViewController.h"

@implementation SFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    [FBLoginView class];
    
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        // To-do, show logged in view
    } else {
        // No, display the login page.
     //   [self showLoginView];
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([[url scheme] isEqualToString:@"sfia"]) {
        
       
        NSString *newURL = [NSString stringWithFormat:@"http://%@%@", [url host], [url path]];
        NSLog(@"%@", newURL);
        
        //NSURL *imageURL = [NSURL URLWithString:newURL];
        //NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        //self.importImage = [UIImage imageWithData:imageData];
        
    }
    
////    if ([[url scheme] isEqualToString:@"fb1432755893606404"])
//    return [FBAppCall handleOpenURL:url
//                  sourceApplication:sourceApplication
//                    fallbackHandler:^(FBAppCall *call) {
//                        NSLog(@"In fallback handler");
//                    }];
   return YES;
}

//- (void)showLoginView
//{
//    SFViewController *viewController = [[SFViewController alloc] init];
//    [self presentViewController:viewController animated:YES completion:nil];
//    //    UIViewController *topViewController = [self.navController topViewController];
//    //
//    //    SCLoginViewController* loginViewController =
//    //    [[SCLoginViewController alloc]initWithNibName:@"SCLoginViewController" bundle:nil];
//    //    [topViewController presentViewController:loginViewController animated:NO completion:nil];
//}

@end
