//
//  ViewController.m
//  photogallerytest
//
//  Created by K Rummler on 5/26/13.
//

#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#import "ViewController.h"

#import "ImageCell.h"

#import "ImageContext.h"

#import "UIImage+Resize.h"

#import "GalleryViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) GalleryViewController* gallery;

@property (nonatomic) NSUInteger selectedImage;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageContext *context = [self.images objectAtIndex:indexPath.row];
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    
    [cell.imageView setImage:[UIImage imageNamed:context.thumbImageUrl]];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedImage = indexPath.row;
    self.gallery = [[GalleryViewController alloc] initWithImages:self.images selected:self.selectedImage];
    [self presentViewController:self.gallery animated:YES completion:nil];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

- (NSArray *)images
{
    if(_images)
        return _images;
    
    NSMutableArray *images = [NSMutableArray array];
    
    [images addObject:[[ImageContext alloc]
                       initWithThumb:@"1_s.jpg"
                       fullSize:@"1_b.jpg"
                       dimensions:CGSizeMake(1024,768)]];
    
    [images addObject:[[ImageContext alloc]
                       initWithThumb:@"2_s.jpg"
                       fullSize:@"2_b.jpg"
                       dimensions:CGSizeMake(768, 1024)]];
    
    [images addObject:[[ImageContext alloc]
                       initWithThumb:@"3_s.jpg"
                       fullSize:@"3_b.jpg"
                       dimensions:CGSizeMake(1024,768)]];
    
    [images addObject:[[ImageContext alloc]
                       initWithThumb:@"4_s.jpg"
                       fullSize:@"4_b.jpg"
                       dimensions:CGSizeMake(1024,768)]];
    
    _images = images;
    return _images;
}

@end
