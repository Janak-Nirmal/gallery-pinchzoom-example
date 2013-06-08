//
//  NSImage+Resize.h
//  DigDag PM App
//
//  Created by K Rummler on 2/1/13.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)

// rotate UIImage to any angle
- (UIImage *)rotateOrientation;

// rotate and scale image from iphone camera
- (UIImage *)rotateAndScaleFromCameraWithMaxSize:(CGFloat)maxSize;

// scale this image to a given minimum width and height
- (UIImage *)scaleWithMinSize:(CGFloat)minSize;
- (UIImage *)scaleWithMinSize:(CGFloat)minSize quality:(CGInterpolationQuality)quality;

// scale this image to a given maximum width and height
- (UIImage *)scaleWithMaxSize:(CGFloat)maxSize;
- (UIImage *)scaleWithMaxSize:(CGFloat)maxSize quality:(CGInterpolationQuality)quality;

- (UIImage *)rotateAndScaleWithMaxHeight :(CGFloat)maxHeight quality:(CGInterpolationQuality)quality;

- (UIImage *)scaleWithMaxHeight:(CGFloat)maxHeight quality:(CGInterpolationQuality)quality;

- (float)widthWhenHeightIs:(CGFloat)maxHeight;

- (float)heightWhenWidthIs:(CGFloat)maxWidth;

- (CGSize) sizeWithMaxSize:(CGSize)size;
+ (CGSize) size:(CGSize)curSize withMaxSize:(CGSize)maxSize;

- (CGRect)convertCropRect:(CGRect)cropRect;
- (UIImage *)croppedImage:(CGRect)cropRect;

- (UIImage *)croppedSquare;

@end
