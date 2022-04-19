//
//  NSError+RSSReaderErrors.h
//  RSSReader
//
//  Created by Nadezhda Zenkova on 19.04.2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSError (RSSReaderErrors)

+ (NSError *) noDataError;

@end

NS_ASSUME_NONNULL_END
