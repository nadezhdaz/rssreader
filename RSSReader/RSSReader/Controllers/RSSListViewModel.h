//
//  RSSListViewModel.h
//  RSSReader
//
//  Created by Nadezhda Zenkova on 31.01.2022.
//

#import <Foundation/Foundation.h>
#import "RSSEntry.h"
#import "RSSFeedService.h"

@class RSSListViewModel;

@protocol RSSListViewModelDelegate <NSObject>

- (void) didStartLoading;
- (void) didFinishLoading;
- (void) didFailWithError: (NSError *)error;

@end

@interface RSSListViewModel : NSObject

@property (nonatomic, weak) NSObject<RSSListViewModelDelegate>* viewDelegate;

-(NSInteger)numberOfRows;
-(NSString *)titleForFeed;
-(RSSEntry *)topicAtIndex:(NSUInteger )index;

@end
