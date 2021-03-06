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
    UIImageView *_tempImageview;
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
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 61, 320, 320)];
        [self.imageView setContentMode: UIViewContentModeScaleAspectFill];
        [self.view addSubview:self.imageView];
    }
    
    self.filterSegmentedButtons.tintColor = [UIColor redColor];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(handleOpenCustomURL) name: @"HandleOpenCustomURLNotificationName" object: nil];
}

- (void)handleOpenCustomURL
{
    SFAppDelegate *appDelegate = (SFAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSData *data = [NSData dataWithContentsOfURL:appDelegate.customURL];
    UIImage *incomingImage = [UIImage imageWithData:data];
    
    [self applyFilterToImage:incomingImage];
    
    NSLog(@"Singleton's URL: %@", appDelegate.customURL);
}

-(void)viewWillAppear:(BOOL)animated
{

}

-(void)viewDidAppear:(BOOL)animated
{
        if (FBSession.activeSession.isOpen == YES)
        {
            NSLog(@"You are logged in");
        } else if (FBSession.activeSession.isOpen ==  NO){
    //        //SFLoginViewController *loginViewController = [[SFLoginViewController alloc] init];
    //        //[self presentViewController:loginViewController animated:YES completion:nil];
            [self performSegueWithIdentifier:@"login" sender:self];
    //
        }
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
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 61, 320, 320)];
//    [imageView setImage:image];
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.imageView setImage:image];
    self.originalImage = self.imageView.image;

    
    //self.imageView = imageView;
   // [self.view addSubview:imageView];
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
            ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
            NSLog(@"%d", status);
            if (status == ALAuthorizationStatusDenied)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Photo album not available" message:@"Can you allow access?" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                [alertView show];
            }
            
            else 
            {
                [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
                [self usePhotoLibrary];
                self.filterSegmentedButtons.enabled = YES;

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
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No photo selected" message:@"Please pick a photo" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
//                [alertView show];
                [self noPhotoSelected];
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

#pragma mark - Social Sharing

-(IBAction)shareImage:(UIBarButtonItem *)sender
{
    SLComposeViewController *shareViewController;
    MFMailComposeViewController *mailViewController;
    
    if (self.imageView.image) {
    switch (sender.tag) {
        case 0:{
//            shareViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
//            [shareViewController setInitialText:@"Fun with cats"];
//            [shareViewController addImage: self.imageView.image];
//            [shareViewController addURL:[NSURL URLWithString:@"http://facebook.com/mydemoapp"]];
//            [self presentViewController:shareViewController animated:YES completion:nil];
            
            [FBRequestConnection startForUploadPhoto:self.imageView.image completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                
                if (!error)
                {
                    NSLog(@"Successfully updated status");
                    [self photoPostSuccess];
                }
                else
                {
                    NSLog(@"Error: %@", error.localizedDescription);
                }
                
            }];
            
            
        }
            break;
            
        case 1:{
            shareViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [shareViewController setInitialText:@"Fun with cats"];
            [shareViewController addImage: self.imageView.image];
            [shareViewController addURL:[NSURL URLWithString:@"http://facebook.com/mydemoapp"]];
            [self presentViewController:shareViewController animated:YES completion:nil];
        }
            break;
            
        case 2:{
            mailViewController = [[MFMailComposeViewController alloc] init];
            mailViewController.mailComposeDelegate = self;
            [mailViewController setSubject:@"Fun with cats"];
            
            //Adding the photo to the email
            NSData *sendImage = UIImageJPEGRepresentation(self.imageView.image, 0.0);
            [mailViewController addAttachmentData:sendImage mimeType:@"image/jpeg" fileName:@"SFImageAppImage.jpg"];
            
            [mailViewController setMessageBody:@"Your message goes here." isHTML:NO];
            [self presentViewController:mailViewController animated:YES completion:nil];
        }
            break;
            
    }
    } else {
        [self noPhotoSelected];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Photo not selected warning

-(void)noPhotoSelected
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No photo selected" message:@"Please pick a photo" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark - Facebook support methods

-(void)logoutButtonWasPressed
{
    [FBSession.activeSession closeAndClearTokenInformation];
    //self.navigationItem.rightBarButtonItem.enabled = NO;
    [self performSegueWithIdentifier:@"login" sender:self];
}

-(void)photoPostSuccess
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Your image has been posted" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
    [alertView show];
}


@end
