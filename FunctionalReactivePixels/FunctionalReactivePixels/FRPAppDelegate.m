//
//  FRPAppDelegate.m
//  FunctionalReactivePixels
//
//  Created by Christopher Martin on 2/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "FRPAppDelegate.h"
#import "FRPGalleryViewController.h"

//these default keys are from the book, and they dont' currently work
//you should probably get your own
NSString * const kFRPFiveHundredPixelsDefaultConsumerKey = @"DC2To2BS0ic1ChKDK15d44M42YHf9gbUJ";
NSString * const kFRPFiveHundredPixelsDefaultConsumerSecret = @"i8WL4chWoZ4kw9fh3jzHK7XzTer1y5tUNvsTFNnB";

@interface FRPAppDelegate ()
@property (nonatomic, strong) PXAPIHelper *apiHelper;

@property (nonatomic, strong) NSString *fiveHundredPixelsConsumerKey;
@property (nonatomic, strong) NSString *fiveHundredPixelsConsumerSecret;
@end


@implementation FRPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self loadApiKeys];
    self.apiHelper = [[PXAPIHelper alloc] initWithHost:nil
                                           consumerKey:self.fiveHundredPixelsConsumerKey
                                        consumerSecret:self.fiveHundredPixelsConsumerSecret];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    FRPGalleryViewController *root = [[FRPGalleryViewController alloc] init];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:root];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)loadApiKeys{
    //store our actual keys in this file, it's not included in git, so use defualts if we can't load it
    NSString *path = [[NSBundle mainBundle] pathForResource:@"api-keys" ofType:@"json"];
    
    if (path) {
        NSError *error = nil;
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *keys = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!error) {
            self.fiveHundredPixelsConsumerKey = keys[@"consumer_key"];
            self.fiveHundredPixelsConsumerSecret = keys[@"consumer_secret"];
        } else {
            NSLog(@"Couldn't load keys from json file: %@", error);
            self.fiveHundredPixelsConsumerKey = kFRPFiveHundredPixelsDefaultConsumerKey;
            self.fiveHundredPixelsConsumerSecret = kFRPFiveHundredPixelsDefaultConsumerSecret;
        }
    } else {
        self.fiveHundredPixelsConsumerKey = kFRPFiveHundredPixelsDefaultConsumerKey;
        self.fiveHundredPixelsConsumerSecret = kFRPFiveHundredPixelsDefaultConsumerSecret;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
