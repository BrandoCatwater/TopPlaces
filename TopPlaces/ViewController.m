//
//  ViewController.m
//  TopPlaces
//
//  Created by Brandon Chatreau on 2014-06-12.
//  Copyright (c) 2014 Brandon Chatreau. All rights reserved.
//

#import "ViewController.h"
#import "FlickrTopPlacesHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [FlickrTopPlacesHelper loadTopPlacesOnCompletion:^(NSArray *photos, NSError *error) {
        NSLog(@"photos: %@\nerror: %@", photos, error);
    }];
	// Do any additional setup after loading the view, typically from a nib.
}


@end
