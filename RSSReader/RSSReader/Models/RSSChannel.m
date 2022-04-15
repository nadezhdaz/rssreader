//
//  RSSChannel.m
//  RSSReader
//
//  Created by Nadezhda Zenkova on 01.02.2022.
//

#import "RSSChannel.h"

@implementation RSSChannel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _title = dictionary[@"title"];
        _link = dictionary[@"link"];
        _channelDescription = dictionary[@"description"];
    }
    return self;
}

- (void)dealloc {
    [_title release];
    [_link release];
    [_channelDescription release];
    
    [super dealloc];
}

@end
