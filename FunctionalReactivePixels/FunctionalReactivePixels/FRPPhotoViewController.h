//
//  FRPPhotoViewController.h
//  FunctionalReactivePixels
//
//  Created by Christopher Martin on 2/2/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FRPPhotoModel;

@interface FRPPhotoViewController : UIViewController

-(instancetype)initWithPhotoModel:(FRPPhotoModel*)photoModel index:(NSInteger)index;

@property (nonatomic, readonly) NSInteger photoIndex;
@property (nonatomic, readonly) FRPPhotoModel *photoModel;

@end
