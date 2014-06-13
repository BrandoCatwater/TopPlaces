//
//  TopPlacesTableViewController.m
//  TopPlaces
//
//  Created by Brandon Chatreau on 2014-06-13.
//  Copyright (c) 2014 Brandon Chatreau. All rights reserved.
//

#import "TopPlacesTableViewController.h"
#import "FlickrTopPlacesHelper.h"

@interface TopPlacesTableViewController ()

@end

@implementation TopPlacesTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fetchPlaces
{
    [self.refreshControl beginRefreshing];
    [self.tableView setContentOffset:CGPointMake(0, -self.refreshControl.frame.size.height) animated:YES];
    [FlickrTopPlacesHelper loadTopPlacesOnCompletion:^(NSArray *places, NSError *error) {
        if (!error){
            self.places = places;
            [self.refreshControl endRefreshing];
        }else {
            NSLog(@"Error Loading TopPlaces %@", error);
        }
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchPlaces];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
