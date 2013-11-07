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


- (IBAction)showUIActionSheet:(id)sender;

@end
