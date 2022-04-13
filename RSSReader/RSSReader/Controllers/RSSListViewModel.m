//
//  RSSListViewModel.m
//  RSSReader
//
//  Created by Nadezhda Zenkova on 31.01.2022.
//

#import "RSSListViewModel.h"
#import "DetailsViewModel.h"
#import "WebViewViewModel.h"

@interface RSSListViewModel ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSMutableArray <RSSEntry *> *topicsList;
@property (nonatomic, copy) NSError *networkError;
@property (nonatomic, retain) RSSFeedService *service;
@property (nonatomic, copy) DetailsViewModel *detailsViewModel;

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
    return self;
}

-(NSInteger)numberOfRows {
    return [self.topicsList count] > 0 ? [self.topicsList count]: 0;
}

-(NSString *)titleForFeed {
    return self.title;
}

-(RSSEntry *)topicForIndex:(NSUInteger )index {
    return self.topicsList[index];
}

-(DetailsViewModel *)detailsForIndex:(NSUInteger )index {
    DetailsViewModel *details = [[DetailsViewModel alloc] initWithEntry:self.topicsList[index]];
    return details;
}

-(WebViewViewModel *)webViewForIndex:(NSUInteger )index {
    NSString *urlString = self.topicsList[index].link;
    WebViewViewModel *webViewModel = [[WebViewViewModel alloc] initWithUrl:urlString];
    return webViewModel;
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



- (void)updateData {
    __weak typeof(self) weakSelf = self;
    [self.viewDelegate didStartLoading];
    [self.service retrieveFeed:^(NSString *title, NSArray<RSSEntry *> *entries, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (entries) {
                weakSelf.topicsList = [entries copy];
                weakSelf.title = [title copy];
                weakSelf.networkError = nil;
                [weakSelf.viewDelegate didFinishLoading];
            } else {
                weakSelf.topicsList = nil;
                weakSelf.networkError = error;
                NSString *message = [weakSelf errorMessage:error];
                [weakSelf.viewDelegate didFailWithErrorMessage:message];
            }
        });
    }];
}

#pragma mark - Private Methods

- (NSString *)errorMessage: (NSError *)error {
    switch (error.code) {
        case 512:
        case 1 ... 94:
            return @"Data reading error";
            break;
        case 256:
            return @"Internet connection error";
            break;
        default:
            return @"Unknown error";
            break;
    }
}

@end
