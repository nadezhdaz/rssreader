//
//  DetailsViewModel.m
//  RSSReader
//
//  Created by Nadezhda Zenkova on 11.04.2022.
//

#import "DetailsViewModel.h"
#import "RSSEntry.h"

@interface DetailsViewModel ()

@property (nonatomic, copy) RSSEntry *entry;

@end

@implementation DetailsViewModel

- (instancetype)initWithEntry:(RSSEntry *)entry {
    self = [super init];
    if (self) {
        _entry = entry;
    }
    return self;
}

-(NSString *)title {
    return self.entry.title;
}

-(NSString *)description {
    return self.entry.entryDescription;
}

-(NSString *)date {
    return self.entry.pubDate;
}

- (void)callData {
    if (self.viewDelegate) {
        [self.viewDelegate didLoad];
    }
    
}

@end
