//
//  RPViewController.m
//  RACPlayground
//
//  Created by Christopher Martin on 1/31/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "RPViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RPViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation RPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.textField.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"New value: %@", x);
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
