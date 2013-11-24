//
//  SFAppDelegate.m
//  SFImageApp
//
//  Created by Spencer Fornaciari on 11/5/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import "SFAppDelegate.h"

@implementation SFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
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
        
        self.importImage = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
        

//        ToDoItem *item = [[ToDoItem alloc] init];
//        NSString *taskName = [url query];
//        if (!taskName || ![self isValidTaskString:taskName]) { // must have a task name
//            return NO;
//        }
//        taskName = [taskName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        
//        item.toDoTask = taskName;
//        NSString *dateString = [url fragment];
//        if (!dateString || [dateString isEqualToString:@"today"]) {
//            item.dateDue = [NSDate date];
//        } else {
//            if (r![self isValidDateString:dateString]) {
//                return NO;
//            }
//            // format: yyyymmddhhmm (24-hour clock)
//            NSString *curStr = [dateString substringWithRange:NSMakeRange(0, 4)];
//            NSInteger yeardigit = [curStr integerValue];
//            curStr = [dateString substringWithRange:NSMakeRange(4, 2)];
//            NSInteger monthdigit = [curStr integerValue];
//            curStr = [dateString substringWithRange:NSMakeRange(6, 2)];
//            NSInteger daydigit = [curStr integerValue];
//            curStr = [dateString substringWithRange:NSMakeRange(8, 2)];
//            NSInteger hourdigit = [curStr integerValue];
//            curStr = [dateString substringWithRange:NSMakeRange(10, 2)];
//            NSInteger minutedigit = [curStr integerValue];
//            
//            NSDateComponents *dateComps = [[NSDateComponents alloc] init];
//            [dateComps setYear:yeardigit];
//            [dateComps setMonth:monthdigit];
//            [dateComps setDay:daydigit];
//            [dateComps setHour:hourdigit];
//            [dateComps setMinute:minutedigit];
//            NSCalendar *calendar = [s[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//            NSDate *itemDate = [calendar dateFromComponents:dateComps];
//            if (!itemDate) {
//                return NO;
//            }
//            item.dateDue = itemDate;
//        }
//        
//        [(NSMutableArray *)self.list addObject:item];
//        return YES;
    }
    return NO;
}

@end
