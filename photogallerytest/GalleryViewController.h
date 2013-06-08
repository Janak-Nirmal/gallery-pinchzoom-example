//
//  GalleryViewController.h
//  photogallerytest
//
//  Created by K Rummler on 5/29/13.
//

#import <UIKit/UIKit.h>

@interface GalleryViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *images;
@property (nonatomic) NSUInteger selectedImage;

- (id)initWithImages:(NSArray*)images selected:(NSUInteger)selectedImage;

@end
