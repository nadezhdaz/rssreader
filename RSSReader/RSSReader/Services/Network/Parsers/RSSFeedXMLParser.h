//
//  RSSFeedXMLParser.h
//  RSSReader
//
//  Created by Nadezhda Zenkova on 01.02.2022.
//

#import <Foundation/Foundation.h>
#import "RSSEntry.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSSFeedXMLParser : NSObject

typedef void (^RSSFeedCompletionBlock)(NSString * _Nullable title,  NSArray<RSSEntry *> * _Nullable , NSError *);

- (void)parseWithParameters: (NSDictionary *)dictionary;
- (void)parseWithData: (NSData *)data completion: (RSSFeedCompletionBlock) completion;

@end

NS_ASSUME_NONNULL_END
