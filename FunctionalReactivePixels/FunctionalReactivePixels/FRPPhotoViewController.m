//
//  FRPPhotoViewController.m
//  FunctionalReactivePixels
//
//  Created by Christopher Martin on 2/2/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "FRPPhotoViewController.h"
#import "FRPPhotoModel.h"
#import "FRPPhotoImporter.h"
#import <SVProgressHUD.h>

@interface FRPPhotoViewController ()
@property (nonatomic, assign) NSInteger photoIndex;
@property (nonatomic, strong) FRPPhotoModel *photoModel;

@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation FRPPhotoViewController

-(instancetype)initWithPhotoModel:(FRPPhotoModel *)photoModel index:(NSInteger)index{
    self = [super init];
    if (self) {
        self.photoModel = photoModel;
        self.photoIndex = index;
    }
    
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    RAC(view, image) = [RACObserve(self.photoModel, fullsizedData) map:^id(id value) {
        return [UIImage imageWithData:value];
    }];
    
    view.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:view];
    self.imageView = view;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [SVProgressHUD show];
    
    [[FRPPhotoImporter fetchPhotoDetails:self.photoModel] subscribeError:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"Error"];
    } completed:^{
        [SVProgressHUD dismiss];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
