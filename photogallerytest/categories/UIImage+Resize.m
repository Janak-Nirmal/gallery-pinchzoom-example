//
//  NSImage+Resize.m
//  DigDag PM App
//
//  Created by K Rummler on 2/1/13.
//

#import "UIImage+Resize.h"

static inline CGFloat degreesToRadians(CGFloat degrees)
{
	return M_PI * (degrees / 180.0);
}

static inline CGSize swapWidthAndHeight(CGSize size)
{
	CGFloat swap = size.width;
    
	size.width = size.height;
	size.height = swap;
    
	return size;
}

@implementation UIImage (Resize)

- (UIImage *)rotateOrientation
{
	UIGraphicsBeginImageContext(self.size);
	UIImageOrientation orientation = self.imageOrientation;
    
	CGContextRef context = (UIGraphicsGetCurrentContext());
    
	if (orientation == UIImageOrientationRight) {
		CGContextRotateCTM(context, 90 / 180 * M_PI);
	} else if (orientation == UIImageOrientationLeft) {
		CGContextRotateCTM(context, -90 / 180 * M_PI);
	} else if (orientation == UIImageOrientationDown) {
		// NOTHING
	} else if (orientation == UIImageOrientationUp) {
		CGContextRotateCTM(context, 90 / 180 * M_PI);
	}
    
	[self drawAtPoint:CGPointMake(0, 0)];
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return img;
}

- (UIImage *)rotateAndScaleFromCameraWithMaxSize:(CGFloat)maxSize
{
	UIImage *imag;
    
	imag = [self rotateOrientation];
	imag = [imag scaleWithMaxSize:maxSize];
    
	return imag;
}

- (UIImage *)   rotateAndScaleWithMaxHeight :(CGFloat)maxHeight
quality                                         :(CGInterpolationQuality)quality
{
	UIImage *imag;
    
	imag = [self rotateOrientation];
	imag = [imag scaleWithMaxHeight:maxHeight quality:quality];
    
	return imag;
}

- (UIImage *)scaleWithMinSize:(CGFloat)maxSize
{
	return [self scaleWithMinSize:maxSize quality:kCGInterpolationHigh];
}

- (UIImage *)scaleWithMaxSize:(CGFloat)maxSize
{
	return [self scaleWithMaxSize:maxSize quality:kCGInterpolationHigh];
}

- (CGFloat)heightWhenWidthIs:(CGFloat)maxWidth
{
	CGRect orig = CGRectZero;
	CGFloat rtio = 0.0;
    
	orig.size = self.size;
	rtio = orig.size.width / orig.size.height;
    
	return maxWidth / rtio;
}

- (CGFloat)widthWhenHeightIs:(CGFloat)maxHeight
{
	CGRect orig = CGRectZero;
	CGFloat rtio = 0.0;
    
	orig.size = self.size;
	rtio = orig.size.width / orig.size.height;
    
	return maxHeight * rtio;
}

- (UIImage *) scaleWithMaxHeight:(CGFloat)maxHeight quality:(CGInterpolationQuality)quality
{
	if (self.size.height <= maxHeight) {
		return self;
	}
    
	CGRect bnds = CGRectZero;
	bnds.size = self.size;
    
	bnds.size.width = [self widthWhenHeightIs:maxHeight];
	bnds.size.height = maxHeight;
    
	return [self resizeToSize:bnds quality:quality];
}

- (UIImage *) scaleWithMinSize:(CGFloat)minSize quality:(CGInterpolationQuality)quality
{
	if ((self.size.width <= minSize) && (self.size.height <= minSize)) {
		return self;
	}
    
	CGRect bnds = CGRectZero;
	bnds.size = [self sizeWithMinSize:minSize];
    
	return [self resizeToSize:bnds quality:quality];
}


- (UIImage *) scaleWithMaxSize:(CGFloat)maxSize quality:(CGInterpolationQuality)quality
{
	if ((self.size.width <= maxSize) && (self.size.height <= maxSize)) {
		return self;
	}
    
	CGRect bnds = CGRectZero;
	bnds.size = [self sizeWithMaxSize:CGSizeMake(maxSize, maxSize)];
    
	return [self resizeToSize:bnds quality:quality];
}

- (CGSize) sizeWithMinSize:(CGFloat)maxSize
{
	CGSize size = CGSizeZero;
	CGFloat rtio = self.size.width / self.size.height;
    
	if (rtio < 1.0) {
		size.width = maxSize;
		size.height = maxSize / rtio;
	} else {
		size.width = maxSize * rtio;
		size.height = maxSize;
	}
    
	return size;
}

- (CGSize) sizeWithMaxSize:(CGSize)maxSize
{
	return [[self class] size:self.size withMaxSize:maxSize];
}

+ (CGSize) size:(CGSize)curSize withMaxSize:(CGSize)maxSize
{
    CGSize size = CGSizeZero;
	CGFloat currentRatio = curSize.width / curSize.height;
    CGFloat requestedRatio = maxSize.width / maxSize.height;
    
	if (currentRatio < requestedRatio) {
		size.width = maxSize.width;
		size.height = maxSize.height / currentRatio;
	} else {
		size.width = maxSize.width;
		size.height = maxSize.width / currentRatio;
	}
    
	return size;
}

- (UIImage *)resizeToSize:(CGRect)bnds quality:(CGInterpolationQuality)quality
{
	UIImage *copy = nil;
	CGContextRef ctxt = nil;
	CGFloat scal = 1.0;
	CGRect orig = CGRectZero;
    
	orig.size = self.size;
    
	UIGraphicsBeginImageContext(bnds.size);
	ctxt = UIGraphicsGetCurrentContext();
    
	scal = bnds.size.width / orig.size.width;
	CGContextSetInterpolationQuality(ctxt, quality);
	CGContextScaleCTM(ctxt, scal, -scal);
	CGContextTranslateCTM(ctxt, 0.0, -orig.size.height);
	CGContextDrawImage(ctxt, orig, self.CGImage);
    
	copy = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	return copy;
}

- (CGRect)convertCropRect:(CGRect)cropRect
{
	UIImage *originalImage = self;
    
	CGSize size = originalImage.size;
	CGFloat x = cropRect.origin.x;
	CGFloat y = cropRect.origin.y;
	CGFloat width = cropRect.size.width;
	CGFloat height = cropRect.size.height;
	UIImageOrientation imageOrientation = originalImage.imageOrientation;
    
	if ((imageOrientation == UIImageOrientationRight) || (imageOrientation == UIImageOrientationRightMirrored)) {
		cropRect.origin.x = y;
		cropRect.origin.y = size.width - cropRect.size.width - x;
		cropRect.size.width = height;
		cropRect.size.height = width;
	} else if ((imageOrientation == UIImageOrientationLeft) || (imageOrientation == UIImageOrientationLeftMirrored)) {
		cropRect.origin.x = size.height - cropRect.size.height - y;
		cropRect.origin.y = x;
		cropRect.size.width = height;
		cropRect.size.height = width;
	} else if ((imageOrientation == UIImageOrientationDown) || (imageOrientation == UIImageOrientationDownMirrored)) {
		cropRect.origin.x = size.width - cropRect.size.width - x;
		cropRect.origin.y = size.height - cropRect.size.height - y;
	}
    
	return cropRect;
}

- (UIImage *)croppedSquare
{
	if(self.isSquare)
	{
		return self;
	}
	else if(self.isLandscape)
	{
		CGFloat newLength = self.size.height;
		CGFloat offsetWidth = (self.size.width - self.size.height) /2;
		CGRect rect = CGRectMake(offsetWidth, 0, newLength, newLength);
		return [self croppedImage:rect];
	}
	else
	{ //portrait
		CGFloat newLength = self.size.width;
		CGFloat offsetWidth = (self.size.height - self.size.width) /2;
		CGRect rect = CGRectMake(0, offsetWidth, newLength, newLength);
		return [self croppedImage:rect];
	}
}

- (UIImage *)croppedImage:(CGRect)cropRect
{
	CGImageRef croppedCGImage = CGImageCreateWithImageInRect(self.CGImage, cropRect);
	UIImage *croppedImage = [UIImage imageWithCGImage:croppedCGImage scale:1.0f orientation:self.imageOrientation];
    
	CGImageRelease(croppedCGImage);
    
	return croppedImage;
}

- (BOOL) isLandscape
{
	return self.size.width > self.size.height;
}

- (BOOL) isPortrait
{
	return self.size.width < self.size.height;
}

- (BOOL) isSquare
{
	return self.size.width == self.size.height;
}

@end
