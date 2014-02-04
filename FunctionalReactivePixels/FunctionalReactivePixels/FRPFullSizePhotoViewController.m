//
//  FRPFullSizePhotoViewController.m
//  FunctionalReactivePixels
//
//  Created by Christopher Martin on 2/2/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "FRPFullSizePhotoViewController.h"
#import "FRPPhotoModel.h"
#import "FRPPhotoViewController.h"

@interface FRPFullSizePhotoViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (nonatomic, strong) NSArray *photoModels;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@end

@implementation FRPFullSizePhotoViewController

-(id)initWithPhotoModels:(NSArray *)photoModels currentPhotoIndex:(NSInteger)index{
    self = [super init];
    
    if (self) {
        self.photoModels = photoModels;
        
        self.title = [self.photoModels[index] photoName];
        
        self.pageViewController =
            [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                   navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                   options:@{UIPageViewControllerOptionInterPageSpacingKey: @(30)}];
        
        self.pageViewController.delegate = self;
        self.pageViewController.dataSource = self;
        
        [self addChildViewController:self.pageViewController];
        [self.pageViewController setViewControllers:@[[self photoViewControllerForIndex:index]]
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:NO
                                         completion:nil];
   }
    
    return self;
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished
  previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    self.title = [[self.pageViewController.viewControllers.firstObject photoModel] photoName];
    [self.delegate userDidScroll:self toPhotoAtIndex:[self.pageViewController.viewControllers.firstObject photoIndex]];
}

-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController
    viewControllerBeforeViewController:(FRPPhotoViewController *)viewController{
    return [self photoViewControllerForIndex:viewController.photoIndex - 1];
}

-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController
     viewControllerAfterViewController:(FRPPhotoViewController *)viewController{
    return [self photoViewControllerForIndex:viewController.photoIndex + 1];
}

-(FRPPhotoViewController*)photoViewControllerForIndex:(NSInteger)index{
    if (index >= 0 && index < self.photoModels.count) {
        FRPPhotoModel *model = self.photoModels[index];
        
        FRPPhotoViewController *photoViewController = [[FRPPhotoViewController alloc] initWithPhotoModel:model index:index];
        return photoViewController;
    }
    
    return nil;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.pageViewController.view.frame = self.view.bounds;
    [self.view addSubview:self.pageViewController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
