//
//  NSDate+DateFormatter.m
//  RSSReader
//
//  Created by Nadezhda Zenkova on 25.04.2022.
//

#import "NSDate+DateFormatter.h"

@implementation NSDate (DateFormatter)

+ (NSDate *) getDateFromString:(NSString *)string {
    NSDateFormatter *formatter = [NSDateFormatter new];    
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    formatter.dateFormat = @"E, d MMM yyyy HH:mm:ss Z";
    return [formatter dateFromString:string];
}

+ (NSString *) getStringFromDate:(NSDate *)date {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MMM d, yyyy";
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    return [formatter stringFromDate:date];
}

@end
