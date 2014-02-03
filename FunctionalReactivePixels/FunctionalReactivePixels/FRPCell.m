//
//  FRPCell.m
//  FunctionalReactivePixels
//
//  Created by Christopher Martin on 2/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "FRPCell.h"
#import "FRPPhotoModel.h"

@interface FRPCell ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, strong) RACDisposable *subscription;

@end

@implementation FRPCell

-(void)prepareForReuse{
    [super prepareForReuse];
    
    [self.subscription dispose], self.subscription = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor darkGrayColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
        
    }
    return self;
}

-(void)setPhotoModel:(FRPPhotoModel *)photoModel{
    self.subscription = [[[RACObserve(photoModel, thumbnailData) filter:^BOOL(id value) {
        return value != nil;
    }] map:^id(id value) {
        return [UIImage imageWithData:value];
    }] setKeyPath:@keypath(self.imageView, image) onObject:self.imageView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
