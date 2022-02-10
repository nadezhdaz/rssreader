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

- (void)parsefromUrl:(NSURL *)url completion:(void(^)(NSArray<RSSEntry *> *, NSError *))completion;
- (void)parseWithParameters: (NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
