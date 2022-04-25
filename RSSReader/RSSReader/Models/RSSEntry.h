//
//  RSSEntry.h
//  RSSReader
//
//  Created by Nadezhda Zenkova on 01.02.2022.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RSSEntry : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *entryDescription;
@property (nonatomic, copy) NSDate *pubDate;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
