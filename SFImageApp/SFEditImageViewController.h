//
//  SFEditImageViewController.h
//  SFImageApp
//
//  Created by Spencer Fornaciari on 11/6/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SFEditImageDelegate <NSObject>


@end

@interface SFEditImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *editImage;
- (IBAction)filterImage:(id)sender;

- (IBAction)saveEdit:(id)sender;

@end
