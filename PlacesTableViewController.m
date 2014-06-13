//
//  PlacesTableViewController.m
//  TopPlaces
//
//  Created by Brandon Chatreau on 2014-06-13.
//  Copyright (c) 2014 Brandon Chatreau. All rights reserved.
//

#import "PlacesTableViewController.h"
#import "FlickrTopPlacesHelper.h"
#import "PhotosPlacesTableViewController.h"

@interface PlacesTableViewController ()
@property  (nonatomic, strong) NSDictionary *placesByCountry;
@property (nonatomic, strong) NSArray *countries;



@end

@implementation PlacesTableViewController

- (void)setPlaces:(NSArray *)places
{
    if (_places == places) return;
    
    _places = [FlickrTopPlacesHelper sortPlaces:places];
    
    self.placesByCountry = [FlickrTopPlacesHelper placesByCountries:_places];
    self.countries = [FlickrTopPlacesHelper countriesFromPlacesByCountry:self.placesByCountry];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.countries count];
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    return self.countries[section];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.placesByCountry[self.countries[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Place Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    
    NSDictionary *place = self.placesByCountry[self.countries[indexPath.section]][indexPath.row];
    cell.textLabel.text = [FlickrTopPlacesHelper titleOfPlace:place];
    cell.detailTextLabel.text = [FlickrTopPlacesHelper subtitleOfPlace:place];
    
    return cell;
}

- (void)preparePhotosTVC:(PhotosPlacesTableViewController *)tvc
                forPlace:(NSDictionary *)place
{
    tvc.place = place;
    tvc.title = [FlickrTopPlacesHelper titleOfPlace:place];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    if ([segue.identifier isEqualToString:@"Show Place"] && indexPath) {
        [self preparePhotosTVC:segue.destinationViewController
                      forPlace:self.placesByCountry[self.countries[indexPath.section]][indexPath.row]];
    }
}


@end
