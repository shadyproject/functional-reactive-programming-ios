//
//  FRPGalleryFlowLayout.m
//  FunctionalReactivePixels
//
//  Created by Christopher Martin on 2/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "FRPGalleryFlowLayout.h"

@implementation FRPGalleryFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(145, 145);
        self.minimumInteritemSpacing = 10;
        self.minimumLineSpacing = 10;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    
    return self;
}

@end
