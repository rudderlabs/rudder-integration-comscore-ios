//
//  RudderComscoreFactory.h 
//  Rudder-Comscore
//
//  Created by desusai7 on 10/16/2023.
//  Copyright (c) 2023 Rudderstack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Rudder/Rudder.h>
#import "RudderComscoreIntegration.h"
NS_ASSUME_NONNULL_BEGIN

@interface RudderComscoreFactory : NSObject<RSIntegrationFactory>

+ (instancetype) instance;

@property RudderComscoreIntegration * __nullable integration;

@end

NS_ASSUME_NONNULL_END
