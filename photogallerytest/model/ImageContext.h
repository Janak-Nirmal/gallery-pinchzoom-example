//
//  ImageContext.h
//  photogallerytest
//
//  Created by K Rummler on 5/27/13.
//

#import <Foundation/Foundation.h>

@interface ImageContext : NSObject

@property (strong, nonatomic) NSString *thumbImageUrl;
@property (strong, nonatomic) NSString *fullImageUrl;
@property (nonatomic) CGSize dimensions;

- (id) initWithThumb:(NSString*)thumb fullSize:(NSString*)full dimensions:(CGSize)dimensions;

@end
