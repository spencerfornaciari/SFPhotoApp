//
//  SFViewController.h
//  SFImageApp
//
//  Created by Spencer Fornaciari on 11/5/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFAppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "SFEditImageViewController.h"
#import "SFOverlayView.h"
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface SFViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, SFEditImageViewControllerDelegate, MFMailComposeViewControllerDelegate>


@property (strong, nonatomic) UIImage *originalImage;
@property (nonatomic) id delegate;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *filterSegmentedButtons;
@property (strong, nonatomic) IBOutlet UIButton *createMagicButton;


- (IBAction)logoutButtonWasPressed;
- (IBAction)filterViewSegmentController:(id)sender;
- (IBAction)showUIActionSheet:(id)sender;
- (IBAction)shareImage:(UIBarButtonItem *)sender;


@end
