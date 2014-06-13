//
//  FlickrTopPlacesHelper.m
//  TopPlaces
//
//  Created by Brandon Chatreau on 2014-06-12.
//  Copyright (c) 2014 Brandon Chatreau. All rights reserved.
//

#import "FlickrTopPlacesHelper.h"

@implementation FlickrTopPlacesHelper

+ (void)loadTopPlacesOnCompletion:(void (^)(NSArray *places, NSError *error))completionHandler
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

+ (void)loadPhotosInPlace:(NSDictionary *)place maxResults:(NSUInteger)results onCompletion:(void (^)(NSArray *photos, NSError *error))completionHandler
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:[FlickrTopPlacesHelper URLforPhotosInPlace:[place valueForKeyPath:FLICKR_PLACE_ID] maxResults:results] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSArray *photos;
        if (!error){
            photos = [[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:location] options:0 error:&error]valueForKeyPath:FLICKR_RESULTS_PHOTOS];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(photos, error);
        });
    }];
    [task resume];
}

+ (NSString *)countryOfPlace:(NSDictionary *)place
{
    return [[[place valueForKeyPath:FLICKR_PLACE_NAME]componentsSeparatedByString:@", "]lastObject];
}

+ (NSString *)titleOfPlace:(NSDictionary *)place
{
    return [[[place valueForKeyPath:FLICKR_PLACE_NAME]componentsSeparatedByString:@", "]firstObject];
}

+ (NSString *)subtitleOfPlace:(NSDictionary *)place
{
    NSArray *nameParts = [[place valueForKeyPath:FLICKR_PLACE_NAME]componentsSeparatedByString:@", "];
    NSRange range;
    range.location = 1;
    range.length = [nameParts count] - 2;
    return [[nameParts subarrayWithRange:range]componentsJoinedByString:@", "];
}

+ (NSArray *)sortPlaces:(NSArray *)places
{
    return [places sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *name1 = [obj1 valueForKeyPath:FLICKR_PLACE_NAME];
        NSString *name2 = [obj2 valueForKeyPath:FLICKR_PLACE_NAME];
        return [name1 localizedCompare:name2];
    }];
}

+ (NSDictionary *)placesByCountries:(NSArray *)places
{
    NSMutableDictionary *placesByCountry = [NSMutableDictionary dictionary];
    for (NSDictionary *place in places)
    {
        NSString *country = [FlickrTopPlacesHelper countryOfPlace:place];
        NSMutableArray *placesOfCountry = placesByCountry[country];
        if (!placesOfCountry) {
            placesOfCountry = [NSMutableArray array];
            placesByCountry[country] = placesOfCountry;
        }
        [placesOfCountry addObject:place];
    }
    return placesByCountry;
}

+ (NSArray *)countriesFromPlacesByCountry:(NSDictionary *)placesByCountry
{
    NSArray *countries = [placesByCountry allKeys];
    countries = [countries sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [ obj1 compare:obj2 options:NSCaseInsensitiveSearch];
    }];
    return countries;
}



@end
