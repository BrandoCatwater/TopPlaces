//
//  FlickrTopPlacesHelper.h
//  TopPlaces
//
//  Created by Brandon Chatreau on 2014-06-12.
//  Copyright (c) 2014 Brandon Chatreau. All rights reserved.
//

#import "FlickrFetcher.h"

@interface FlickrTopPlacesHelper : FlickrFetcher

+ (NSString *)countryOfPlace:(NSDictionary *)place;
+ (NSString *)titleOfPlace:(NSDictionary *)place;
+ (NSString *)subtitleOfPlace:(NSDictionary *)place;
+ (NSArray *)sortPlaces:(NSArray *)places;
+ (NSDictionary *)placesByCountries:(NSArray *)places;
+ (NSArray *)countriesFromPlacesByCountry:(NSDictionary *)placesByCountry;



+ (void)loadTopPlacesOnCompletion:(void (^)(NSArray *photos, NSError *error))completionHandler;
@end
