//
//  RSSFeedService.h
//  RSSReader
//
//  Created by Nadezhda Zenkova on 01.02.2022.
//

#import <Foundation/Foundation.h>
#import "RSSFeedXMLParser.h"

NS_ASSUME_NONNULL_BEGIN

@class RSSEntry;

@interface RSSFeedService : NSObject

typedef void (^RSSFeedCompletionBlock)(NSString * _Nullable title,  NSArray<RSSEntry *> * _Nullable , NSError *);


+ (instancetype)defaultInit:(NSString *)url;

- (void)retrieveFeed:(RSSFeedCompletionBlock) completion;

@end

NS_ASSUME_NONNULL_END
