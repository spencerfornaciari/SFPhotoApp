//
//  SFOverlayView.m
//  SFImageApp
//
//  Created by Spencer Fornaciari on 11/6/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import "SFOverlayView.h"

@implementation SFOverlayView


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //clear the background color of the overlay
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        
        //load an image to show in the overlay
        
        NSArray *segmentedOptions = [NSArray arrayWithObjects:@"Plain", @"Filter 1", @"Filter 2", nil];
        UISegmentedControl *filters = [[UISegmentedControl alloc] initWithItems:segmentedOptions];
        filters.frame = CGRectMake(20, 430, 280, 28);
        filters.selectedSegmentIndex = 1;
        filters.tintColor = [UIColor whiteColor];
        [filters addTarget:self
                    action:@selector(pickFilter:)
          forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:filters];
        
        
//        UIImage *searcher = [UIImage imageNamed:@"crosshair.png"];
        

        UIImageView *searcherView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, 320, 320)];
        [self addSubview:searcherView];
          //searcherView.backgroundColor = [UIColor clearColor];
        

        
//
    //initWithImage:searcher];
//        searcherView.frame = CGRectMake(30, 100, 260, 200);
//        [self addSubview:searcherView];
        
        //add a simple button to the overview
        //with no functionality at the moment
//        UIButton *button = [UIButton
//                            buttonWithType:UIButtonTypeRoundedRect];
//        [button setTitle:@"Scan Now" forState:UIControlStateNormal];
//        button.frame = CGRectMake(0, 430, 320, 40);
//        [self addSubview:button];
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

-(void) pickFilter:(id)sender{
    UISegmentedControl *filterPicked = (UISegmentedControl *)sender;
   // label.text = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
    if (filterPicked.selectedSegmentIndex == 0)
    {
       // UIView *view = [self imagePreview];
        NSLog(@"Filter 1");
    }
    
    else if (filterPicked.selectedSegmentIndex == 1 ) {
        NSLog(@"Filter 2");
    }
    
    else if (filterPicked.selectedSegmentIndex == 2)
    {
        NSLog(@"Filter 3");
    }
}


@end
