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

- (void)retrieveFeed:(void (^)(NSArray<RSSEntry *> *, NSError *)) completion {
    NSURL *url = [NSURL URLWithString:self.feedUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask *dataTask = [self.session
                                      dataTaskWithRequest: request
                                      completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        //Attempt to fix NSXMLParserErrorMessage=Extra content at the end of the document
        //NSString *dataString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
        //NSData *reEncodedData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
        
        [self.parser parseEntries:data fromUrl:url completion:completion];
        
    }];
    
    [dataTask resume];
}

- (void)dealloc {
    [_session release];
    _session = nil;
    [_parser release];
    _parser = nil;
    [_feedUrl release];
    _feedUrl = nil;
    
    [super dealloc];
}


@end
