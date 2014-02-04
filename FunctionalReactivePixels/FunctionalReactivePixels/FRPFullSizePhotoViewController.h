//
//  FRPFullSizePhotoViewController.h
//  FunctionalReactivePixels
//
//  Created by Christopher Martin on 2/2/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FRPFullSizePhotoViewController;

@protocol FRPFullSizePhotoViewControllerDelegate <NSObject>

-(void)userDidScroll:(FRPFullSizePhotoViewController*)viewController toPhotoAtIndex:(NSInteger)index;

@end

@interface FRPFullSizePhotoViewController : UIViewController

-(instancetype)initWithPhotoModels:(NSArray*)photoModels currentPhotoIndex:(NSInteger)index;

@property (nonatomic, readonly) NSArray *photoModels;
@property (nonatomic, weak) id<FRPFullSizePhotoViewControllerDelegate> delegate;
@end
