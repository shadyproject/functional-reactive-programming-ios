//
//  FRPGalleryViewController.m
//  FunctionalReactivePixels
//
//  Created by Christopher Martin on 2/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "FRPGalleryViewController.h"
#import "FRPGalleryFlowLayout.h"

@interface FRPGalleryViewController ()

@end

@implementation FRPGalleryViewController

- (id)init {
    FRPGalleryFlowLayout *layout = [[FRPGalleryFlowLayout alloc] init];
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        //stuff here
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
