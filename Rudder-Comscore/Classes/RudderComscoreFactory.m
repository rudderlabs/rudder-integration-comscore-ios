//
//  RudderComscoreFactory.m 
//  Rudder-Comscore
//
//  Created by desusai7 on 10/16/2023.
//  Copyright (c) 2023 Rudderstack. All rights reserved.
//

#import "RudderComscoreFactory.h"

@implementation RudderComscoreFactory

static RudderComscoreFactory *sharedInstance;

NSString *const RSComscoreKey = @"Comscore";

+ (instancetype)instance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (nonnull NSString *)key {
    return RSComscoreKey;
}

- (id <RSIntegration>) initiate: (NSDictionary*) config client:(RSClient*) client rudderConfig:(nonnull RSConfig *)rudderConfig{
    self.integration = [[RudderComscoreIntegration alloc] initWithConfig:config withAnalytics:client rudderConfig: rudderConfig];
    return self.integration;
}

@end
