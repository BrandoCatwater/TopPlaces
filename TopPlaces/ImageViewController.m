//
//  ImageViewController.m
//  TopPlaces
//
//  Created by Brandon Chatreau on 2014-06-17.
//  Copyright (c) 2014 Brandon Chatreau. All rights reserved.
//

#import "ImageViewController.h"
#import "FlickrTopPlacesHelper.h"

@interface ImageViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;

@end

@implementation ImageViewController

- (void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    _scrollView.minimumZoomScale = 0.2;
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.delegate = self;
    
}

- (UIImageView *)imageView
{
    if (!_imageView){
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
    // Do any additional setup after loading the view.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (UIImage *)image
{
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image
{
    self.scrollView.zoomScale = 1.0;
    self.imageView.image = image;
    [self.imageView sizeToFit];
    self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
    [self.activityView stopAnimating];
    
}

- (void)fetchImage
{
    self.image = nil;
    if (!self.imageURL) return;
    
    [self.activityView startAnimating];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:self.imageURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (!error){
            if ([response.URL isEqual:self.imageURL]) {
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.image = image;
                });
            }
        }
    }];
    [task resume];
    
}

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [self fetchImage];
}





@end
