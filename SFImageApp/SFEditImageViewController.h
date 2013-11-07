//
//  SFEditImageViewController.h
//  SFImageApp
//
//  Created by Spencer Fornaciari on 11/6/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SFEditImageViewControllerDelegate <NSObject>
-(void)noFunction;


@end

@interface SFEditImageViewController : UIViewController


@property (weak, nonatomic) id <SFEditImageViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *editImage;
@property (weak, nonatomic) UIImage *basicImage;

- (IBAction)filterImage:(id)sender;

- (IBAction)saveEdit:(id)sender;

@end
