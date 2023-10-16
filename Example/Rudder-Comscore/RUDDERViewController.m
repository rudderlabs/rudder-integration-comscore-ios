//
//  RUDDERViewController.m
//  Rudder-Comscore
//
//  Created by desusai7 on 10/16/2023.
//  Copyright (c) 2023 Rudderstack. All rights reserved.
//

#import "RUDDERViewController.h"
#import <Rudder/Rudder.h>

@interface RUDDERViewController ()

@end

@implementation RUDDERViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)handleIdentify:(id)sender {
    [[RSClient sharedInstance] identify:@"test_user_id"
    traits:@{@"foo": @"bar",
            @"foo1": @"bar1",
            @"email": @"test@gmail.com",
            @"key_1" : @"value_1",
            @"key_2" : @"value_2"
    }
    ];

}
- (IBAction)handleTrack:(id)sender {
    [[RSClient sharedInstance] track:@"simple_track_with_props" properties:@{
        @"key_1" : @"value_1",
        @"key_2" : @"value_2"
    }];

}
- (IBAction)handleScreen:(id)sender {
    [[RSClient sharedInstance] screen:@"ViewController"];

}
- (IBAction)hanldeGroup:(id)sender {
    [[RSClient sharedInstance] group:@"sample_group_id"
      traits:@{@"foo": @"bar",
                @"foo1": @"bar1",
                @"email": @"ruchira@gmail.com"}
    ];

}

@end
