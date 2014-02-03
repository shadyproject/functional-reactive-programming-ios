//
//  FRPAppDelegate.h
//  FunctionalReactivePixels
//
//  Created by Christopher Martin on 2/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FRPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, readonly) PXAPIHelper *apiHelper;

@property (nonatomic, readonly) NSString *fiveHundredPixelsConsumerKey;
@property (nonatomic, readonly) NSString *fiveHundredPixelsConsumerSecret;
@end
