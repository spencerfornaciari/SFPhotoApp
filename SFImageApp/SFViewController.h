//
//  SFViewController.h
//  SFImageApp
//
//  Created by Spencer Fornaciari on 11/5/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SFEditImageViewController.h"
#import "SFOverlayView.h"

@interface SFViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, SFEditImageViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *originalImage;
@property (strong, nonatomic) IBOutlet UISegmentedControl *filterSegmentedButtons;
@property (strong, nonatomic) IBOutlet UIButton *createMagicButton;


- (IBAction)filterViewSegmentController:(id)sender;
- (IBAction)showUIActionSheet:(id)sender;

@end
