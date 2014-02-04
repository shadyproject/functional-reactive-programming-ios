//
//  FRPPhotoImporter.h
//  FunctionalReactivePixels
//
//  Created by Christopher Martin on 2/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FRPPhotoModel;

@interface FRPPhotoImporter : NSObject
+ (RACSignal*)importPhotos;
+(RACSignal*)fetchPhotoDetails:(FRPPhotoModel*)photoModel;
@end
