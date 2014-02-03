//
//  FRPGalleryViewController.m
//  FunctionalReactivePixels
//
//  Created by Christopher Martin on 2/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "FRPGalleryViewController.h"
#import "FRPGalleryFlowLayout.h"
#import "FRPPhotoImporter.h"
#import "FRPCell.h"

@interface FRPGalleryViewController ()
@property (nonatomic, strong) NSArray *photosArray;
@end

@implementation FRPGalleryViewController

- (id)init {
    FRPGalleryFlowLayout *layout = [[FRPGalleryFlowLayout alloc] init];
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        //stuff here
    }
    return self;
}

-(void)loadPopularPhotos{
    [[FRPPhotoImporter importPhotos] subscribeNext:^(id x) {
        self.photosArray = x;
    } error:^(NSError *error) {
        NSLog(@"Couldn't fetch photos from 500px: %@", error);
    }];
}

static NSString *CellIdentifier = @"Cell";

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"Popular on 500px";
    
    [self.collectionView registerClass:[FRPCell class] forCellWithReuseIdentifier:CellIdentifier];
    
    @weakify(self);
    
    [RACObserve(self, photosArray) subscribeNext:^(id x) {
        @strongify(self);
        [self.collectionView reloadData];
    }];
    
    [self loadPopularPhotos];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photosArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FRPCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell setPhotoModel:self.photosArray[indexPath.row]];
    
    return cell;
}

@end
