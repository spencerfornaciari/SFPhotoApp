//
//  SFViewController.m
//  SFImageApp
//
//  Created by Spencer Fornaciari on 11/5/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import "SFViewController.h"

@interface SFViewController () 

@end

@implementation SFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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
                                                destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Album", nil];
    
    [imageOptions showInView:self.view];

}

#pragma mark - Image Picker

//-(IBAction)getImage:(id)sender
//{
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    [picker setDelegate:self];
//    
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
//    }
//    else
//    {
//        [picker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
//    }
//    
//    [picker setAllowsEditing:YES];
//    [self presentViewController:picker animated:YES completion:^{
//        NSLog(@"Showing camera!");
//    }];
//    
//}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    SFEditImageViewController *editImageController = [[SFEditImageViewController alloc] init];
//    
//    [self presentViewController:editImageController animated:YES completion:nil];
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *pickedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
        [self applyFilterToImage:pickedImage];
    }];
}

-(void)applyFilterToImage:(UIImage *)image
{
    // filter the image
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIImage *ciImage = [CIImage imageWithCGImage:image.CGImage];
    
    //CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectInstant"];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIColorInvert"];

    [filter setValue:ciImage forKey:kCIInputImageKey];
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    CGRect extent = [result extent];
    
    CGImageRef cgImage = [context createCGImage:result fromRect:extent];
    
    UIImage *filteredImage = [UIImage imageWithCGImage:cgImage];
    
    // show the image to the user
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    [imageView setImage:filteredImage];
    [self.view addSubview:imageView];
    
    // save the image to the photos album
    UIImageWriteToSavedPhotosAlbum(filteredImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
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
                [self useCamera];
            }
            
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No camera available" message:@"Try photo album?" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                [alertView show];
                
                //ERROR - it heads right to photo album if there is no camera
            }
            
        }
        break;
        
        case 1:
        {
            //Setup action sheet to use the photo album
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
            {
                [self usePhotoLibrary];
            }
            
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Photo album not available" message:@"Can you allow access?" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                [alertView show];
                
                //ERROR - it heads right to photo album if there is no camera
            }
            
            
        }
        break;
    }
    
    
}

-(void)useCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:self];
    
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
//    UIView* overlayView = [[UIView alloc] initWithFrame:picker.view.frame];
//    // letting png transparency be
//    overlayView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yourimagename.png"]];
//    [overlayView.layer setOpaque:NO];
//    overlayView.opaque = NO;
    
    picker.showsCameraControls = YES;
    //picker.cameraOverlayView = overlayView;
    
    [picker setAllowsEditing:YES];
    [self presentViewController:picker animated:YES completion:^{
        // NSLog(@"Showing camera!");
        
    }];
}

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

@end
