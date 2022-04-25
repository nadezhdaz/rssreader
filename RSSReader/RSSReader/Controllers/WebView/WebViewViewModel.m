//
//  WebViewViewModel.m
//  RSSReader
//
//  Created by Nadezhda Zenkova on 11.04.2022.
//

#import "WebViewViewModel.h"

@interface WebViewViewModel ()

@property (nonatomic, copy) NSString *urlString;

@end

@implementation WebViewViewModel

- (instancetype)initWithUrl:(NSString *)urlString {
    self = [super init];
    if (self) {
        _urlString = urlString;
    }
    return self;
}

-(NSURL *)url {
    return [NSURL URLWithString:self.urlString];
}

- (void)setupUrl:(NSString *)urlString {
    @synchronized (urlString) {
        self.urlString = urlString;
    }
}

- (void)dealloc {
    [_urlString release];
    
    [super dealloc];
}

@end
