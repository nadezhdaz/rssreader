//
//  RSSFeedXMLParser.m
//  RSSReader
//
//  Created by Nadezhda Zenkova on 01.02.2022.
//

#import "RSSFeedXMLParser.h"
#import "NSMutableString+PathComponents.h"
#import "NSError+RSSReaderErrors.h"

@interface RSSFeedXMLParser () <NSXMLParserDelegate>

@property (nonatomic, copy, nullable) RSSFeedCompletionBlock completion;
@property (nonatomic, retain) NSMutableDictionary *topicDictionary;
@property (nonatomic, retain) NSMutableString *parsingString;
@property (nonatomic, retain) NSMutableString *rssTitle;
@property (nonatomic, retain) NSMutableArray *topics;
@property (nonatomic, retain) NSMutableString *tagPath;

@end

@implementation RSSFeedXMLParser

- (void)parseWithData: (NSData *)data completion: (RSSFeedCompletionBlock) completion {
    self.completion = completion;
    if (!data) {
        self.completion(nil, nil, [NSError noDataError]);
    } else {
        NSXMLParser *parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
        parser.delegate = self;
        [parser parse];
    }    
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (self.completion) {
        self.completion(nil, nil, parseError);
    }
    
    [self resetParserState];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.topics = [NSMutableArray new];
    self.tagPath = [[NSMutableString alloc] initWithString:@"/"];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    if ([self.tagPath isEqualToString:@"/rss/channel"]) {
        if ([elementName isEqualToString:@"title"]) {
            self.parsingString = [NSMutableString new];
        }
    }
    
    if ([elementName isEqualToString:@"item"]) {
        self.topicDictionary = [NSMutableDictionary new];
    }
    
    if ([self.tagPath isEqualToString:@"/rss/channel/item"]) {
        if ([elementName isEqualToString:@"title"] ||
            [elementName isEqualToString:@"link"] ||
            [elementName isEqualToString:@"description"] ||
            [elementName isEqualToString:@"pubDate"]) {
            self.parsingString = [NSMutableString new];
        }
    }
    
    [self.tagPath appendPathComponent:elementName];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.parsingString appendString:string];    
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    if ([self.tagPath isEqualToString:@"/rss/channel/title"]) {
        self.rssTitle = [self.parsingString copy];
        self.parsingString = nil;
    }
    
    if (self.parsingString) {
        if ([self.tagPath isEqualToString:@"/rss/channel/item/title"] ||
            [self.tagPath isEqualToString:@"/rss/channel/item/link"] ||
            [self.tagPath isEqualToString:@"/rss/channel/item/description"] ||
            [self.tagPath isEqualToString:@"/rss/channel/item/pubDate"]) {
            [self.topicDictionary setObject:[self.parsingString copy] forKey:elementName];
            self.parsingString = nil;
        }
    }
    
    if ([elementName isEqualToString:@"item"]) {
        RSSEntry *entry = [[[RSSEntry alloc] initWithDictionary:self.topicDictionary] autorelease];
        [self.topics addObject:entry];
        [self.topicDictionary release];
    }
        [self.tagPath deleteLastPathComponent];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (self.completion) {
        self.completion(self.rssTitle, self.topics, nil);
    }
    [self resetParserState];
}

- (void)dealloc {
    [_completion release];
    [_topics release];
    [_topicDictionary release];
    [_parsingString release];
    [_tagPath release];
    [super dealloc];
}

#pragma mark - Private methods

- (void)resetParserState {
    self.completion = nil;
    self.topics = nil;
    self.topicDictionary = nil;
    self.parsingString = nil;
    self.tagPath = nil;
}

@end
