//
//  GalleryImageCell.m
//  photogallerytest
//
//  Created by K Rummler on 6/4/13.
//

#import "GalleryImageCell.h"

@interface GalleryImageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (nonatomic) CGFloat lastScale;

@end

@implementation GalleryImageCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
 
    }
    return self;
}

- (void)awakeFromNib{
    self.scrollView.minimumZoomScale=0.5;
    self.scrollView.maximumZoomScale=6.0;

    self.scrollView.delegate=self;

}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    NSLog(@"endzoom");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"enddrag");
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    NSLog(@"didzoom");
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    NSLog(@"beginzoom");
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.image;
}

- (void)setImageContext:(ImageContext *)imageContext
{
    _imageContext = imageContext;
    [self.image setImage:[UIImage imageNamed:imageContext.fullImageUrl]];
}

@end
