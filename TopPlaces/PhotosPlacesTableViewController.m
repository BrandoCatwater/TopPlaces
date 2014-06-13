//
//  PhotosPlacesTableViewController.m
//  TopPlaces
//
//  Created by Brandon Chatreau on 2014-06-13.
//  Copyright (c) 2014 Brandon Chatreau. All rights reserved.
//

#import "PhotosPlacesTableViewController.h"
#import "FlickrTopPlacesHelper.h"

@interface PhotosPlacesTableViewController ()

@end

@implementation PhotosPlacesTableViewController

#define MAX_PHOTO_RESULTS 50

- (IBAction)fetchPhotos
{
    [self.refreshControl beginRefreshing];
    [self.tableView setContentOffset:CGPointMake(0, -self.refreshControl.frame.size.height) animated:YES];
    
    [FlickrTopPlacesHelper loadPhotosInPlace:self.place
                         maxResults:MAX_PHOTO_RESULTS
                       onCompletion:^(NSArray *photos, NSError *error) {
                           if (!error) {
                               self.photos = photos;
                               [self.refreshControl endRefreshing];
                           } else {
                               NSLog(@"Error loading Photos of %@: %@", self.place, error);
                           }
                       }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchPhotos];
}

@end
