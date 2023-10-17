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
@implementation RudderComscoreIntegration


- (instancetype)initWithConfig:(NSDictionary *)config withAnalytics:(nonnull RSClient *)client rudderConfig:(nonnull RSConfig *)rudderConfig {
    if (self = [super init]) {
        
        NSString* publisherId = [config objectForKey:@"publisherId"];
        if(publisherId == nil || [publisherId length] == 0) {
            [RSLogger logError:@"RudderComscoreIntegration: Publisher Id is invalid, cannot initialize Comscore SDK"];
            return self;
        }
        
        SCORPublisherConfiguration* publisherConfiguration = [SCORPublisherConfiguration publisherConfigurationWithBuilderBlock:^(SCORPublisherConfigurationBuilder *builder) {
            builder.publisherId = publisherId;
            builder.secureTransmissionEnabled = YES;
        }];
        [[SCORAnalytics configuration] addClientWithConfiguration:publisherConfiguration];
        
        NSString* appName = [config objectForKey:@"appName"];
        if(appName != nil && [appName length] > 0) {
            [SCORAnalytics configuration].applicationName = appName;
        }
        
        [self setLogLevel:rudderConfig];
        [self setUsagePropertiesAutoUpdateDetails:config];
        [SCORAnalytics start];
        [RSLogger logInfo:@"RudderComscoreIntegration: Comscore SDK is initialized"];
        
    }
    return self;
}

- (void) setLogLevel:(RSConfig *) rudderConfig {
    SCORLogLevel logLevel;
    switch(rudderConfig.logLevel) {
        case 5:
            logLevel = SCORLogLevelVerbose;
            break;
        case 4:
        case 3:
            logLevel = SCORLogLevelDebug;
            break;
        case 2:
            logLevel = SCORLogLevelWarning;
            break;
        case 1:
            logLevel = SCORLogLevelError;
            break;
        default:
            logLevel = SCORLogLevelNone;
    }
    [SCORAnalytics setLogLevel:logLevel];
}

- (void) setUsagePropertiesAutoUpdateDetails:(NSDictionary *) config {
    int autoUpdateInterval = [[config objectForKey:@"autoUpdateInterval"] intValue] == nil ? 60 : [[config objectForKey:@"autoUpdateInterval"] intValue];
    [SCORAnalytics configuration].usagePropertiesAutoUpdateInterval = autoUpdateInterval;
    
    BOOL autoUpdateForegroundOnly = [[config objectForKey:@"foregroundOnly"] boolValue];
    BOOL autoUpdateForegroundAndBackground = [[config objectForKey:@"foregroundAndBackground"] boolValue];
    
    if(autoUpdateForegroundAndBackground) {
        [SCORAnalytics configuration].usagePropertiesAutoUpdateMode = SCORUsagePropertiesAutoUpdateModeForegroundAndBackground;
    } else if (autoUpdateForegroundOnly) {
        [SCORAnalytics configuration].usagePropertiesAutoUpdateMode = SCORUsagePropertiesAutoUpdateModeForegroundOnly;
    } else {
        [SCORAnalytics configuration].usagePropertiesAutoUpdateMode = SCORUsagePropertiesAutoUpdateModeDisabled;
    }
}

- (void)dump:(nonnull RSMessage *)message {
    if([message.type isEqualToString:@"identify"]) {
        NSMutableDictionary* traits = [message.context.traits mutableCopy];
        [traits removeObjectForKey: ID];
        [[SCORAnalytics configuration] addPersistentLabels:[self convertAllValuesToString:traits]];
        [SCORAnalytics notifyHiddenEvent];
    } else if([message.type isEqualToString:@"track"]) {
        NSString* eventName = message.event;
        if (eventName == nil || [eventName length] == 0) {
            [RSLogger logDebug:@"RudderComscoreIntegration: Since the event name is not present, the track event sent to Comscore has been dropped."];
            return;
        }
        NSMutableDictionary *labelsDictionary = [@{NAME:eventName} mutableCopy];
        if (message.properties != nil) {
            [labelsDictionary addEntriesFromDictionary:[self convertAllValuesToString:message.properties]];
        }
        [SCORAnalytics notifyHiddenEventWithLabels:labelsDictionary];
    } else if([message.type isEqualToString:@"screen"]) {
        NSString* screenName = message.event;
        if (screenName == nil || [screenName length] == 0) {
            [RSLogger logDebug:@"RudderComscoreIntegration: Since the screen name is not present, the screen event sent to Comscore has been dropped."];
            return;
        }
        NSMutableDictionary *labelsDictionary = [@{NAME:screenName} mutableCopy];
        if (message.properties != nil) {
            [labelsDictionary addEntriesFromDictionary:[self convertAllValuesToString:message.properties]];
        }
        [SCORAnalytics notifyViewEventWithLabels:labelsDictionary];
    }
    else {
        [RSLogger logWarn:@"RudderComscoreIntegration: Message type not supported"];
    }
}

- (void)flush {
    [RSLogger logWarn: @"RudderComscoreIntegration: Flush is not supported"];
}

- (void)reset {
    [[SCORAnalytics configuration] removeAllPersistentLabels];
}

- (NSDictionary *)convertAllValuesToString:(NSDictionary *)originalDictionary {
    NSMutableDictionary *convertedDictionary = [[NSMutableDictionary alloc] initWithCapacity:originalDictionary.count];
    NSEnumerator *originalEnumerator = [originalDictionary keyEnumerator];
    NSString *key;
    id value;
    Class NSStringClass = [NSString class];
    
    while ((key = [originalEnumerator nextObject])) {
        value = originalDictionary[key];
        
        if ([value isKindOfClass:NSStringClass]) {
            convertedDictionary[key] = value;
        } else {
            convertedDictionary[key] = [NSString stringWithFormat:@"%@", value];
        }
    }
    
    return convertedDictionary;
}

@end
