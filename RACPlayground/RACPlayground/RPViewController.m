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
@property (weak, nonatomic) IBOutlet UIButton *createButton;

@end

@implementation RPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RACSignal *validEmailSignal = [self.textField.rac_textSignal map:^id(id value) {
        return @([value rangeOfString:@"@"].location != NSNotFound);
    }];
    
    self.createButton.rac_command = [[RACCommand alloc]
                                     initWithEnabled:validEmailSignal
                                     signalBlock:^RACSignal *(id input) {
        NSLog(@"Button was pressed");
        return [RACSignal empty];
    }];
  
    RAC(self.textField, textColor) = [validEmailSignal map:^id(id value) {
        if ([value boolValue]) {
            return [UIColor greenColor];
        } else {
            return [UIColor redColor];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
