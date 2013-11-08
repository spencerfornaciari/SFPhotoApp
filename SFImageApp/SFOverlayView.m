//
//  SFOverlayView.m
//  SFImageApp
//
//  Created by Spencer Fornaciari on 11/6/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import "SFOverlayView.h"

@implementation SFOverlayView
{
    UISegmentedControl *_filters;
    UIView *_imageFrame;
}


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //clear the background color of the overlay
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        
        //load an image to show in the overlay
        
        NSArray *segmentedOptions = [NSArray arrayWithObjects:@"Red", @"Blue", @"Green", nil];
        _filters = [[UISegmentedControl alloc] initWithItems:segmentedOptions];
        _filters.frame = CGRectMake(20, 430, 280, 28);
        _filters.selectedSegmentIndex = 0;
        _filters.tintColor = [UIColor redColor];
        [_filters addTarget:self
                    action:@selector(pickFilter:)
          forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:_filters];
//
        
//        UIImage *searcher = [UIImage imageNamed:@"crosshair.png"];
        

//        UIImageView *searcherView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, 320, 320)];
//        [self addSubview:searcherView];
          //searcherView.backgroundColor = [UIColor clearColor];
        
        //Create a label for the camera HUD
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 63 , 320, 40)];
        label.text = @"Camera HUD";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        
        //Create a frame border for the input
        _imageFrame = [[UIView alloc] initWithFrame:CGRectMake(0, 98, 320, 320)];
        _imageFrame.layer.borderColor=[UIColor redColor].CGColor;
        _imageFrame.layer.borderWidth=3.f;
        [self addSubview:_imageFrame];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(IBAction)pickFilter:(id)sender
{
        
        if (_filters.selectedSegmentIndex == 0) {
            _imageFrame.layer.borderColor=[UIColor redColor].CGColor;
        }
        
        if (_filters.selectedSegmentIndex == 1) {
            _imageFrame.layer.borderColor=[UIColor blueColor].CGColor;
        }
        
        if (_filters.selectedSegmentIndex == 2) {
            _imageFrame.layer.borderColor=[UIColor greenColor].CGColor;
        }

}

@end
