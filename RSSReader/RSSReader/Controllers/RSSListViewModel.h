//
//  RSSListViewModel.h
//  RSSReader
//
//  Created by Nadezhda Zenkova on 31.01.2022.
//

#import <Foundation/Foundation.h>
#import "RSSEntry.h"
#import "RSSFeedService.h"

@class DetailsViewModel;
@class WebViewViewModel;

@protocol RSSListViewModelDelegate <NSObject>

- (void) didStartLoading;
- (void) didFinishLoading;
- (void) didFailWithErrorMessage:(NSString *)message;

@end

@interface RSSListViewModel : NSObject

typedef void (^RSSFeedCompletionBlock)(NSString * title,  NSArray<RSSEntry *> *, NSError *);

@property (nonatomic, weak) NSObject<RSSListViewModelDelegate>* viewDelegate;

-(NSInteger) numberOfRows;
-(NSString *) titleForFeed;
-(RSSEntry *) topicForIndex:(NSUInteger )index;

-(DetailsViewModel *)detailsForIndex:(NSUInteger )index;
-(WebViewViewModel *)webViewForIndex:(NSUInteger )index;
- (void) updateData;

@end
