//
//  SFViewController.m
//  SFImageApp
//
//  Created by Spencer Fornaciari on 11/5/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import "SFViewController.h"

@interface SFViewController () <SFEditImageViewControllerDelegate>

@end

@implementation SFViewController
{
    UIImage *_tempImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Initial setup of segment control
    if (self.imageView.image == nil)
    {
        self.filterSegmentedButtons.enabled = NO;
        self.filterSegmentedButtons.selectedSegmentIndex = 3;
    }
    
    self.filterSegmentedButtons.tintColor = [UIColor redColor];
    
    //Initial setup of the Magic Button
    self.createMagicButton.backgroundColor = [UIColor redColor];
    self.createMagicButton.layer.cornerRadius = 5.f;
    
   
    
} 

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Declare UIActionSheet

-(IBAction)showUIActionSheet:(id)sender
{
    //Create the UIAction sheet and display it
    UIActionSheet *imageOptions = [[UIActionSheet alloc] initWithTitle:@"Image Options"
                                                              delegate:self
                                                     cancelButtonTitle:@"Cancel"
                                                destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Album", @"Save Image", nil];

    
    [imageOptions showInView:self.view];

}

#pragma mark - Image Picker

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *pickedImage = [info objectForKey:UIImagePickerControllerEditedImage];

        [self applyFilterToImage:pickedImage];
    }];
}

-(void)applyFilterToImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 320)];
    [imageView setImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.imageView = imageView;
    self.originalImage = imageView.image;
    [self.view addSubview:imageView];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (self.imageView.image) {
        self.filterSegmentedButtons.enabled = YES;
    } else {
        self.filterSegmentedButtons.enabled = NO;

    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)image: (UIImage *)image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    if (error) {
        NSLog(@"Unable to save photo to camera roll");
    } else {
        NSLog(@"Saved Image To Camera Roll");
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    switch (buttonIndex)
    {
        case 0:
        {
            //Setup action sheet to use the camer
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                self.filterSegmentedButtons.enabled = YES;
                [self useCamera];
            }
            
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No camera available" message:@"Try photo album?" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                [alertView show];
            }
            
        }
        break;
        
        case 1:
        {
            //Setup action sheet to use the photo album
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
            {
                [self usePhotoLibrary];
                self.filterSegmentedButtons.enabled = YES;
            }
            
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Photo album not available" message:@"Can you allow access?" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                [alertView show];
            }
            
        }
        break;
            
        case 2:
        {
            //Setup action sheet to use the photo album
            if (self.imageView.image)
            {
                UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            }
            
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No photo selected" message:@"Please pick a photo" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                [alertView show];
            }
            
            
        }
            break;

    }
    
    
}

#pragma mark - Input functionality

//Camera input functionality
-(void)useCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:self];
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
     [picker setAllowsEditing:YES];
    
    //Add camera overlay
    SFOverlayView *overlay = [[SFOverlayView alloc] initWithFrame:CGRectMake(0, 0, 320, 450)];
    picker.cameraOverlayView = overlay;
    
    //Show picker
    [self presentViewController:picker animated:YES completion:^{
        NSLog(@"Showing Camera");
        
    }];
}

//Photo library input functionality
-(void)usePhotoLibrary
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:self];
    
    [picker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    [picker setAllowsEditing:YES];
    [self presentViewController:picker animated:YES completion:^{
        // NSLog(@"Showing camera!");
        
    }];
}

#pragma mark - Segmented Contronller Setup/Color Filter Implementation

-(IBAction)filterViewSegmentController:(id)sender
{
    _tempImage = self.originalImage;

    if (self.filterSegmentedButtons.selectedSegmentIndex == 0) {
        NSLog(@"Filter One");
        CIContext *context = [CIContext contextWithOptions:nil];
        CIImage *ciImage = [CIImage imageWithCGImage:_tempImage.CGImage];
        CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectTonal"];
        [filter setValue:ciImage forKey:kCIInputImageKey];
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGRect extent = [result extent];
        CGImageRef cgImage = [context createCGImage:result fromRect:extent];
        UIImage *filteredImage = [UIImage imageWithCGImage:cgImage];
        [self presentImage:filteredImage];
    }
    
    if (self.filterSegmentedButtons.selectedSegmentIndex == 1) {
        NSLog(@"Filter Two");
        CIContext *context = [CIContext contextWithOptions:nil];
        CIImage *ciImage = [CIImage imageWithCGImage:_tempImage.CGImage];
        CIFilter *filter = [CIFilter filterWithName:@"CIColorPosterize"];
        [filter setValue:ciImage forKey:kCIInputImageKey];
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGRect extent = [result extent];
        CGImageRef cgImage = [context createCGImage:result fromRect:extent];
        UIImage *filteredImage = [UIImage imageWithCGImage:cgImage];
        [self presentImage:filteredImage];
    }
    
    if (self.filterSegmentedButtons.selectedSegmentIndex == 2) {
        NSLog(@"Filter Three");
        CIContext *context = [CIContext contextWithOptions:nil];
        CIImage *ciImage = [CIImage imageWithCGImage:_tempImage.CGImage];
        CIFilter *filter = [CIFilter filterWithName:@"CIColorInvert"];
        [filter setValue:ciImage forKey:kCIInputImageKey];
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGRect extent = [result extent];
        CGImageRef cgImage = [context createCGImage:result fromRect:extent];
        UIImage *filteredImage = [UIImage imageWithCGImage:cgImage];
        [self presentImage:filteredImage];
    }
    
    if (self.filterSegmentedButtons.selectedSegmentIndex == 3) {
        self.imageView.image = self.originalImage;
        self.imageView.layer.cornerRadius = 0.f;
        self.imageView.layer.masksToBounds = NO;
        
    }
    
    
}

//Presenting test filtered images
-(void)presentImage:(UIImage *)filteredImage
{
    [self.imageView setImage:filteredImage];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.cornerRadius = 160.f;
    self.imageView.layer.masksToBounds = YES;
    [self.view addSubview:self.imageView];
    _tempImage = nil;
    
}

@end
