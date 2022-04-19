//
//  NSError+RSSReaderErrors.m
//  RSSReader
//
//  Created by Nadezhda Zenkova on 19.04.2022.
//

#import "NSError+RSSReaderErrors.h"

@implementation NSError (RSSReaderErrors)

+ (NSError *) noDataError {
    
    NSErrorDomain kRSSReaderErrorDomain = [[NSBundle mainBundle] bundleIdentifier];
    
    NSDictionary *userInfo = @{
        NSLocalizedDescriptionKey: NSLocalizedString(@"Data loading failed.", nil),
        NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"No data received.", nil),
        NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Please check RSS url address", nil)
    };
    return [NSError errorWithDomain:kRSSReaderErrorDomain
                                         code:-34
                                     userInfo:userInfo];
}

@end
