//
//  RSSListViewModel.m
//  RSSReader
//
//  Created by Nadezhda Zenkova on 31.01.2022.
//

#import "RSSListViewModel.h"

@interface RSSListViewModel ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSMutableArray *topicsList;
@property (nonatomic, copy) NSError *networkError;
@property (nonatomic, retain) RSSFeedService * service;

@end

@implementation RSSListViewModel

@synthesize viewDelegate;

#pragma mark - Public Methods

- (instancetype)init {
    self = [super init];
    if (self) {
        _topicsList = [NSMutableArray new];
        _service = [[RSSFeedService alloc] initWithUrl:@"https://www.jpl.nasa.gov/feeds/news"];
    }
    [self callFeedService];
    return self;
}

-(NSInteger)numberOfRows {
    return [self.topicsList count] > 0 ? [self.topicsList count]: 0;
}

-(NSString *)titleForFeed {    
    return [self.title autorelease];
}

-(RSSEntry *)topicAtIndex:(NSUInteger )index {
    return self.topicsList[index];
}

- (void)dealloc {
    [_title release];
    _title = nil;
    [_topicsList release];
    _topicsList = nil;
    [_networkError release];
    _networkError = nil;
    [_service release];
    _service = nil;
    
    [super dealloc];
}

#pragma mark - Private Methods

- (void)callFeedService {
    [self.service retrieveFeed:^(NSArray<RSSEntry *> *entries, NSError *error) {
            if (entries) {
                self.topicsList = [entries copy];
                self.networkError = nil;
                if ([self.viewDelegate respondsToSelector:@selector(didFinishLoading)]) {
                    [self.viewDelegate performSelectorOnMainThread:@selector(didFinishLoading) withObject:nil waitUntilDone:false];
                }
            } else {
                self.topicsList = nil;
                self.networkError = error;
                if ([self.viewDelegate respondsToSelector:@selector(didFailWithError:)]) {
                    [self.viewDelegate performSelectorOnMainThread:@selector(didFailWithError:) withObject:error waitUntilDone:[NSThread isMainThread]];
                }
            }
        }];
}

@end
