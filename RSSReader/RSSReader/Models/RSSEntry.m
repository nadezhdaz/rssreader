//
//  RSSEntry.m
//  RSSReader
//
//  Created by Nadezhda Zenkova on 01.02.2022.
//

#import "RSSEntry.h"

@implementation RSSEntry

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _title = dictionary[@"title"];
        _link = dictionary[@"link"];
        _entryDescription = dictionary[@"description"];
        _pubDate = dictionary[@"pubDate"];
    }
    return self;
}

- (void)dealloc {
    [_title release];
    _title = nil;
    [_link release];
    _link = nil;
    [_entryDescription release];
    _entryDescription = nil;
    [_pubDate release];
    _pubDate = nil;
    
    [super dealloc];
}

@end
