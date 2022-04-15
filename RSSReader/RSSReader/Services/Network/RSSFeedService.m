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

- (instancetype)initWithUrl:(NSString *) url {
    self = [super init];
    if (self) {
        _parser = [RSSFeedXMLParser new];
        _feedUrl = url;
    }
    return self;
}

- (NSURLSession *)session {
    if (!_session) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return _session;
}

- (void)retrieveFeed:(RSSFeedCompletionBlock) completion {
    __weak typeof(self) weakSelf = self;
    NSError *error = nil;
    NSURL *url = [NSURL URLWithString:self.feedUrl];
    
    NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error];
    
    if (error) {
        completion(nil, nil, error);
        return;
    }
    
    if ([self.parser respondsToSelector:@selector(parseWithData:completion:)]) {
        NSThread *thread = [[[NSThread alloc] initWithBlock:^{
            [weakSelf.parser parseWithData:data completion:completion];
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
