//
//  RudderComscoreIntegration.m
//  Rudder-Comscore
//
//  Created by desusai7 on 10/16/2023.
//  Copyright (c) 2023 Rudderstack. All rights reserved.
//

#import "RudderComscoreIntegration.h"
#import "RudderComscoreFactory.h"
#import "RSLogger.h"

NSString* const NAME = @"name";
NSString* const ID = @"id";
NSString* const USER_ID = @"userId";
@implementation RudderComscoreIntegration


- (instancetype)initWithConfig:(NSDictionary *)config withAnalytics:(nonnull RSClient *)client rudderConfig:(nonnull RSConfig *)rudderConfig {
}


- (void)dump:(nonnull RSMessage *)message {
    if([message.type isEqualToString:@"identify"]) {
    } else if([message.type isEqualToString:@"track"]) {
    } else if([message.type isEqualToString:@"screen"]) {
    }
    else {
        [RSLogger logWarn:@"RudderComscoreIntegration: Message type not supported"];
    }
}

- (void)flush {
    
}

- (void)reset {
}


@end
