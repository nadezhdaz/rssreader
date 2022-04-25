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
        _service = [RSSFeedService defaultInit: @"https://www.jpl.nasa.gov/feeds/news"];
    }
    return self;
}

- (instancetype)initWithUrl:(NSString *)urlString {
    self = [super init];
    if (self) {
        _topicsList = [NSMutableArray new];
        _service = [[RSSFeedService alloc] initWithUrl:urlString];
    }
    return self;
}

//- (void)setupServiceWithUrlString:(NSString *)urlString {
//    self.service = [[RSSFeedService alloc] initWithUrl:urlString];
//}

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
    //WebViewViewModel *webViewModel = [[WebViewViewModel alloc] initWithUrl:urlString];
    WebViewViewModel *webViewModel = [WebViewViewModel new];
    [webViewModel setupUrl:urlString];
    return webViewModel;
}


- (void)updateData {
    __weak typeof(self) weakSelf = self;
    [self.viewDelegate didStartLoading];
    [self.service retrieveFeed:^(NSString *title, NSArray<RSSEntry *> *entries, NSError *error) {
        if (entries) {
            weakSelf.topicsList = [entries mutableCopy];
            weakSelf.title = title;
            weakSelf.networkError = nil;
            [weakSelf.viewDelegate didFinishLoading];
        } else {
            weakSelf.topicsList = nil;
            weakSelf.networkError = error;
            NSString *message = [weakSelf errorMessage:error];
            [weakSelf.viewDelegate didFailWithErrorMessage:message];
        }
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
        case -34:
            return @"No data received";
        default:
            return @"Unknown error";
            break;
    }
}

- (void)dealloc {
    [_title release];
    [_topicsList release];
    [_networkError release];
    [_service release];
    
    [super dealloc];
}

@end
