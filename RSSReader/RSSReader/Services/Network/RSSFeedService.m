//
//  RSSFeedService.m
//  RSSReader
//
//  Created by Nadezhda Zenkova on 01.02.2022.
//

#import "RSSFeedService.h"

@interface RSSFeedService ()

@property (nonatomic, retain) NSURLSession *session;
@property (nonatomic, retain) RSSFeedXMLParser * parser;
@property (nonatomic, retain) NSString * feedUrl;

@end

@implementation RSSFeedService

- (instancetype)initWithUrl:(NSString *) url parser:(RSSFeedXMLParser *)parser {
    self = [super init];
    if (self) {
        _parser = parser;
        _feedUrl = url;
    }
    return self;
}

+ (instancetype)defaultInit:(NSString *)url {
    RSSFeedXMLParser *parser = [RSSFeedXMLParser new];
    return [[RSSFeedService alloc] initWithUrl:url parser:parser];
}

- (NSURLSession *)session {
    if (!_session) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return _session;
}

- (void)retrieveFeed:(RSSFeedCompletionBlock) completion {
    NSURL *url = [NSURL URLWithString:self.feedUrl];
    
    [self loadFeedFromUrl:url completion:completion];
}

- (void)loadFeedFromUrl:(NSURL *)url completion:(RSSFeedCompletionBlock) completion {
    __weak typeof(self) weakSelf = self;
    
    if ([self.parser respondsToSelector:@selector(parseWithData:completion:)]) {
        NSThread *thread = [[[NSThread alloc] initWithBlock:^{
            NSError *error = nil;
            NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error];
            
            if (data) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.parser parseWithData:data completion:completion];
                });
            } else if (error) {
                completion(nil, nil, error);
                return;
            }
            
        }] autorelease];
        [thread start];
    }
}

- (void)dealloc {
    [_session release];
    [_parser release];
    [_feedUrl release];
    
    [super dealloc];
}


@end
