//
//  SFEditImageViewController.m
//  SFImageApp
//
//  Created by Spencer Fornaciari on 11/6/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import "SFEditImageViewController.h"

@interface SFEditImageViewController ()

@end

@implementation SFEditImageViewController

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
    
    if (self.basicImage)
    {
        [self.editImage setImage:self.basicImage];
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)filterImage:(id)sender {
}

- (IBAction)saveEdit:(id)sender {
}
@end
