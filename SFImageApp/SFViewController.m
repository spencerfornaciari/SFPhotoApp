//
//  SFViewController.m
//  SFImageApp
//
//  Created by Spencer Fornaciari on 11/5/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import "SFViewController.h"

//transform values for full screen support
#define CAMERA_TRANSFORM_X 1
#define CAMERA_TRANSFORM_Y 1

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
    
    if (self.imageView.image == nil)
    {
        self.filterSegmentedButtons.enabled = NO;
        self.filterSegmentedButtons.selectedSegmentIndex = 3;
    }
    
    self.createMagicButton.backgroundColor = [UIColor redColor];
    
    self.filterSegmentedButtons.tintColor = [UIColor redColor];
    
} 

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    //NSArray *segmentedOptions = [NSArray arrayWithObjects:@"Plain", @"Filter 1", @"Filter 2", @"Filter 3", nil];

//    UISegmentedControl *filters =[[UISegmentedControl alloc] initWithItems:segmentedOptions];
//    filters.frame = CGRectMake(20, 480, 280, 28);
//    filters.selectedSegmentIndex = 1;
//    filters.tintColor = [UIColor blackColor];
//    [filters addTarget:self
//                action:@selector(pickFilter:)
//      forControlEvents:UIControlEventValueChanged];
//    
//    [self.view addSubview:filters];
    
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
//    SFEditImageViewController *editImageController = [[SFEditImageViewController alloc] initWithNibName:@"SFEditImageViewController" bundle:nil];
//    editImageController.delegate = self;
//    
//    UIImage *pickedImage = [info objectForKey:UIImagePickerControllerEditedImage];
//    
//    editImageController.basicImage = pickedImage;
//    
//    [self presentViewController:editImageController animated:YES completion:nil];
//    
//    
//
//    UIImage *pickedImage = [info objectForKey:UIImagePickerControllerEditedImage];
//    self.imageView.image = pickedImage;
    
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *pickedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        [self applyFilterToImage:pickedImage];
    }];
}

-(void)applyFilterToImage:(UIImage *)image
{

//    CIContext *context = [CIContext contextWithOptions:nil];
//    
//    CIImage *ciImage = [CIImage imageWithCGImage:image.CGImage];
//    
//    CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectTonal"];
//    
//    [filter setValue:ciImage forKey:kCIInputImageKey];
//    
//    CIImage *result = [filter valueForKey:kCIOutputImageKey];
//    
//    CGRect extent = [result extent];
//    
//    CGImageRef cgImage = [context createCGImage:result fromRect:extent];
//    
//    UIImage *filteredImage = [UIImage imageWithCGImage:cgImage];
    
//    // filter the image
//    CIContext *context = [CIContext contextWithOptions:nil];
//    
//    CIImage *ciImage = [CIImage imageWithCGImage:image.CGImage];
//    
//    CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectTonal"];
//    
//    [filter setValue:ciImage forKey:kCIInputImageKey];
//    
//    CIImage *result = [filter valueForKey:kCIOutputImageKey];
//   
//    CGRect extent = [result extent];
//    
//    CGImageRef cgImage = [context createCGImage:result fromRect:extent];
//    
//    UIImage *filteredImage = [UIImage imageWithCGImage:cgImage];
    
//    // show the image to the user
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 320)];
//    [imageView setImage:filteredImage];
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    imageView.layer.cornerRadius = 160.f;
//    imageView.layer.masksToBounds = YES;
//    [self.view addSubview:imageView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 320)];
    [imageView setImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
   // imageView.layer.cornerRadius = 160.f;
    //imageView.layer.masksToBounds = YES;
    
    
    self.imageView = imageView;
    NSLog(@"Temp ImageView: %@", imageView);
    NSLog(@"Property ImageView: %@", self.imageView);

    self.originalImage = imageView.image;
    //[self.imageView setImage:imageView.image];
    [self.view addSubview:imageView];
    
    
    //[self presentImage:filteredImage];
    
    // save the image to the photos album
    //UIImageWriteToSavedPhotosAlbum(filteredImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    self.filterSegmentedButtons.enabled = NO;
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
                self.filterSegmentedButtons.enabled = YES;
                //[self.filterSegmentedButtons addTarget:self
                //                                action:@selector(pickFilter:)
                //                      forControlEvents:UIControlEventValueChanged];

            }
            
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Photo album not available" message:@"Can you allow access?" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                [alertView show];
                
                //ERROR - it heads right to photo album if there is no camera
            }
            
            
        }
        break;
            
        case 2:
        {
            //Setup action sheet to use the photo album
            if (self.imageView.image)
            {
                UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//                UIImageWriteToSavedPhotosAlbum(filteredImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            }
            
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No photo selected" message:@"Please pick a photo" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
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
     [picker setAllowsEditing:YES];
    
    UIView *overlay = [[UIView alloc] initWithFrame:picker.view.frame];
    //overlay.backgroundColor = [UIColor orangeColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 63 , 320, 40)];
    label.text = @"Camera HUD";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    UIView *imageFrame = [[UIView alloc] initWithFrame:CGRectMake(0, 98, 320, 320)];
    
    imageFrame.layer.borderColor=[UIColor redColor].CGColor;
    imageFrame.layer.borderWidth=3.f;
    [overlay addSubview:imageFrame];
    //        [button setTitle:@"Scan Now" forState:UIControlStateNormal];
    //        button.frame = CGRectMake(0, 430, 320, 40);
    [overlay addSubview:label];
    
    //SFOverlayView *overlay = [[SFOverlayView alloc] initWithFrame:picker.view.frame];
 
    picker.showsCameraControls = YES;
    picker.navigationBarHidden = YES;
    picker.toolbarHidden = YES;
    picker.cameraOverlayView = overlay;
    
    //show picker
    //[self presentViewController:picker animated:YES completion:nil];
    [self presentViewController:picker animated:YES completion:^{
        NSLog(@"Showing Camera");
        
        
    }];
}

-(void)wontCamera
{
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    [picker setDelegate:self];
//    
//    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
//    picker.showsCameraControls = YES;
//    //picker.cameraOverlayView = overlayView;
//    
//    [picker setAllowsEditing:YES];
//    [self presentViewController:picker animated:YES completion:^{
//        // NSLog(@"Showing camera!"); }];
    
//    UIView* overlayView = [[UIView alloc] initWithFrame:picker.view.frame];
//    // letting png transparency be
//    overlayView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yourimagename.png"]];
//    [overlayView.layer setOpaque:NO];
//    overlayView.opaque = NO;
    
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    [picker setDelegate:self];
//    
//    [picker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
//    
//    [picker setAllowsEditing:YES];
//    [self presentViewController:picker animated:YES completion:^{
//        // NSLog(@"Showing camera!");
//        
//    }];

    
    //Create a new image picker instance
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:self];
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [picker setAllowsEditing:YES];
    
    //Create camera overlay
    SFOverlayView *overlay = [[SFOverlayView alloc]
                              initWithFrame:self.view.frame];
    
//    UIView *imagePickerView = picker.view;
//    CGRect cameraViewFrame = CGRectMake(0, 100, 320, 320);
//    imagePickerView.frame = cameraViewFrame;
//    [self.view addSubview:imagePickerView];

    //set source to video!
    //picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //hide all controls
    picker.showsCameraControls = YES;
    picker.navigationBarHidden = YES;
    picker.toolbarHidden = YES;
    //make the video preview full size
    //picker.cameraViewTransform =
    //CGAffineTransformScale(picker.cameraViewTransform,
                        //   CAMERA_TRANSFORM_X,
                        //   CAMERA_TRANSFORM_Y);
    //set our custom overlay view
    picker.cameraOverlayView = overlay;
    
    //show picker
    //[self presentViewController:picker animated:YES completion:nil];
    [self presentViewController:picker animated:YES completion:^{
        NSLog(@"Showing Camera");
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

-(void)presentImage:(UIImage *)filteredImage
{
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 320)];
//    [imageView setImage:filteredImage];
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    imageView.layer.cornerRadius = 160.f;
//    imageView.layer.masksToBounds = YES;
//    [self.view addSubview:imageView];
    
    [self.imageView setImage:filteredImage];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.cornerRadius = 160.f;
    self.imageView.layer.masksToBounds = YES;
    [self.view addSubview:self.imageView];
    _tempImage = nil;

}

#pragma mark - Segmented Contronller Setup

-(IBAction)filterViewSegmentController:(id)sender
{
    //NSLog(@"Property ImageView: %@", self.imageView);
    _tempImage = self.originalImage;
    NSLog(@"_temp: %@", _tempImage);

    
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

@end
