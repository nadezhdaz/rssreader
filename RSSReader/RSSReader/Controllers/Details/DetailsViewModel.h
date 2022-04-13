//
//  DetailsViewModel.h
//  RSSReader
//
//  Created by Nadezhda Zenkova on 11.04.2022.
//

#import <Foundation/Foundation.h>

@class RSSEntry;

NS_ASSUME_NONNULL_BEGIN

@protocol DetailsViewModelDelegate <NSObject>

- (void) didLoad;

@end

@interface DetailsViewModel : NSObject

@property (nonatomic, weak) NSObject<DetailsViewModelDelegate>* viewDelegate;

-(NSString *)title;
-(NSString *)description;
-(NSString *)date;

- (instancetype)initWithEntry:(RSSEntry *)entry;
- (void)callData;

@end

NS_ASSUME_NONNULL_END
