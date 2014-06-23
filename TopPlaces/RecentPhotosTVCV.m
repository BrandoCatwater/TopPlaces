//
//  RecentPhotosTVCV.m
//  TopPlaces
//
//  Created by Brandon Chatreau on 2014-06-22.
//  Copyright (c) 2014 Brandon Chatreau. All rights reserved.
//

#import "RecentPhotosTVCV.h"
#import "FlickrTopPlacesHelper.h"

@interface RecentPhotosTVCV ()

@end

@implementation RecentPhotosTVCV

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.photos = [FlickrTopPlacesHelper allPhtos];
}

@end
