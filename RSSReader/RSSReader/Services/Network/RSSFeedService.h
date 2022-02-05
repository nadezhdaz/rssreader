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

- (instancetype)initWithUrl:(NSString *) url;

- (void)retrieveFeed:(void(^)(NSArray<RSSEntry *> *, NSError *))completion;

@end

NS_ASSUME_NONNULL_END
