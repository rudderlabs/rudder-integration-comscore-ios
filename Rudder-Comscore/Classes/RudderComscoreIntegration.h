//
//  RudderComscoreIntegration.h
//  Rudder-Comscore
//
//  Created by desusai7 on 10/16/2023.
//  Copyright (c) 2023 Rudderstack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Rudder/Rudder.h>
#if defined(__has_include) && __has_include(<ComScore/ComScore.h>)
#import <ComScore/ComScore.h>
#else
#import "ComScore.h"
#endif

NS_ASSUME_NONNULL_BEGIN


@interface RudderComscoreIntegration : NSObject<RSIntegration>

- (instancetype)initWithConfig:(NSDictionary *)config withAnalytics:(RSClient *)client rudderConfig:(nonnull RSConfig *)rudderConfig ;

@end

NS_ASSUME_NONNULL_END
