//
//  PhotosTableViewController.m
//  TopPlaces
//
//  Created by Brandon Chatreau on 2014-06-13.
//  Copyright (c) 2014 Brandon Chatreau. All rights reserved.
//

#import "PhotosTableViewController.h"
#import "FlickrTopPlacesHelper.h"
#import "ImageViewController.h"

@interface PhotosTableViewController ()

@end

@implementation PhotosTableViewController

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Photo Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    
    NSDictionary *photo = self.photos[indexPath.row];
    cell.textLabel.text = [FlickrTopPlacesHelper titleOfPhoto:photo];
    cell.detailTextLabel.text = [FlickrTopPlacesHelper subtitleOfPhoto:photo];
    
    return cell;
}

- (void)prepareImageVC:(ImageViewController *)vc forPhoto: (NSDictionary *)photo
{
    vc.imageURL = [FlickrTopPlacesHelper URLforPhoto:photo format:FlickrPhotoFormatLarge];
    vc.title = [FlickrTopPlacesHelper titleOfPhoto:photo];
    [FlickrTopPlacesHelper addPhoto:photo];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    if ([segue.identifier isEqualToString:@"Show Image"] && indexPath) {
        [self prepareImageVC:segue.destinationViewController forPhoto:self.photos[indexPath.row]];
    }
}


@end
