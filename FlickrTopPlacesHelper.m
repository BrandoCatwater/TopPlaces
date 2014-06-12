//
//  FlickrTopPlacesHelper.m
//  TopPlaces
//
//  Created by Brandon Chatreau on 2014-06-12.
//  Copyright (c) 2014 Brandon Chatreau. All rights reserved.
//

#import "FlickrTopPlacesHelper.h"

@implementation FlickrTopPlacesHelper

+ (void)loadTopPlacesOnCompletion:(void (^)(NSArray *photos, NSError *error))completionHandler
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:[FlickrTopPlacesHelper URLforTopPlaces]
                                              completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                  NSArray *places;
                                                  if (!error) {
                                                      places = [[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:location] options:0 error:&error] valueForKeyPath:FLICKR_RESULTS_PLACES];
                                                  }
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      completionHandler(places,error);
                                                  });
                                              }];
    [task resume];
}

@end
