//
//  ImageContext.m
//  photogallerytest
//
//  Created by K Rummler on 5/27/13.
//

#import "ImageContext.h"

@implementation ImageContext

- (id) initWithThumb:(NSString*)thumb fullSize:(NSString*)full dimensions:(CGSize)dimensions
{
    self = [super init];
    
    if(self){
        self.thumbImageUrl = thumb;
        self.fullImageUrl = full;
        self.dimensions = dimensions;
    }
    return self;
}

@end
