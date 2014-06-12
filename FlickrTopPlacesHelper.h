//
//  FlickrTopPlacesHelper.h
//  TopPlaces
//
//  Created by Brandon Chatreau on 2014-06-12.
//  Copyright (c) 2014 Brandon Chatreau. All rights reserved.
//

#import "FlickrFetcher.h"

@interface FlickrTopPlacesHelper : FlickrFetcher
+ (void)loadTopPlacesOnCompletion:(void (^)(NSArray *photos, NSError *error))completionHandler;
@end
