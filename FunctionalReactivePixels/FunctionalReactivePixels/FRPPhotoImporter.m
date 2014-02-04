//
//  FRPPhotoImporter.m
//  FunctionalReactivePixels
//
//  Created by Christopher Martin on 2/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "FRPPhotoImporter.h"
#import "FRPPhotoModel.h"

@implementation FRPPhotoImporter
+(NSURLRequest*)populateUrlRequest{
    return [AppDelegate.apiHelper urlRequestForPhotoFeature:PXAPIHelperPhotoFeaturePopular
                                          resultsPerPage:100 page:0
                                              photoSizes:PXPhotoModelSizeThumbnail
                                               sortOrder:PXAPIHelperSortOrderRating
                                                  except:PXPhotoModelCategoryNude];
}

+(NSURLRequest*)photoUrlRequest:(FRPPhotoModel*)photoModel{
    return [AppDelegate.apiHelper urlRequestForPhotoID:photoModel.identifier.integerValue];
}

+(void)configurePhotoModel:(FRPPhotoModel*)photoModel withDictionary:(NSDictionary*)dictionary{
    photoModel.photoName = dictionary[@"name"];
    photoModel.identifier = dictionary[@"id"];
    photoModel.photographerName = dictionary[@"user"];
    photoModel.rating = dictionary[@"rating"];
    photoModel.thumbnailUrl = [self urlForImageSize:3 inArray:dictionary[@"images"]];
    
    if (dictionary[@"comments_count"]) {
        photoModel.fullsizedUrl = [self urlForImageSize:4 inArray:dictionary[@"images"]];
    }
}

+(NSString*)urlForImageSize:(NSInteger)size inArray:(NSArray*)array{
    return [[[[[array rac_sequence] filter:^BOOL(NSDictionary *value) {
        return [value[@"size"] integerValue] == size;
    }] map:^id(id value) {
        return value[@"url"];
    }] array] firstObject];
}

+(void)downloadThumbnailForPhotoModel:(FRPPhotoModel*)photoModel{
    [self download:photoModel.thumbnailUrl withCompletion:^(NSData *data){
        photoModel.thumbnailData = data;
    }];
}

+(void)downloadFullsizedImageForPhotoModel:(FRPPhotoModel*)photoModel{
    [self download:photoModel.fullsizedUrl withCompletion:^(NSData *data){
        photoModel.fullsizedData = data;
    }];
}

+(void)download:(NSString*)urlString withCompletion:(void(^)(NSData *data))completion{
    NSAssert(urlString, @"Url must not be nil");
    
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (completion) {
                                   completion(data);
                               }
                           }];
}

+(RACReplaySubject*)importPhotos{
    RACReplaySubject *subject = [RACReplaySubject subject];
    
    NSURLRequest *req = [self populateUrlRequest];
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            id results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            [subject sendNext:[[[results[@"photos"] rac_sequence] map:^id(NSDictionary *photoDictionary) {
                FRPPhotoModel *model = [FRPPhotoModel new];
                [self configurePhotoModel:model withDictionary:photoDictionary];
                [self downloadThumbnailForPhotoModel:model];
                return model;
            }] array]];
            [subject sendCompleted];
        } else {
            [subject sendError:connectionError];
        }
    }];
    
    return subject;
}

+(RACReplaySubject*)fetchPhotoDetails:(FRPPhotoModel*)photoModel{
    RACReplaySubject *subject = [RACReplaySubject subject];
    
    NSURLRequest *req = [self photoUrlRequest:photoModel];
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (data) {
                                   id results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil][@"photo"];
                                   [self configurePhotoModel:photoModel withDictionary:results];
                                   [self downloadFullsizedImageForPhotoModel:photoModel];
                                   
                                   [subject sendNext:photoModel];
                                   [subject sendCompleted];
                               } else {
                                   [subject sendError:connectionError];
                               }
                           }];
    
    return subject;
}

@end
