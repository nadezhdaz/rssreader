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

- (void)parseWithParameters: (NSDictionary *)dictionary;
- (void)parseWithData: (NSData *)data completion: (void (^)(NSArray<RSSEntry *> *, NSError *)) completion;

@end

NS_ASSUME_NONNULL_END
