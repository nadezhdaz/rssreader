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
    __weak typeof(self) weakSelf = self;
    [self.service retrieveFeed:^(NSArray<RSSEntry *> *entries, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (entries) {
                weakSelf.topicsList = [entries copy];
                weakSelf.networkError = nil;                
                [weakSelf.viewDelegate didFinishLoading];
                
            } else {
                weakSelf.topicsList = nil;
                weakSelf.networkError = error;
                [weakSelf.viewDelegate didFailWithError:error];
            }
        });
    }];
}

@end
