//
//  NSDate+DateFormatter.h
//  RSSReader
//
//  Created by Nadezhda Zenkova on 25.04.2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (DateFormatter)

+ (NSDate *) getDateFromString:(NSString *)string;
+ (NSString *) getStringFromDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
