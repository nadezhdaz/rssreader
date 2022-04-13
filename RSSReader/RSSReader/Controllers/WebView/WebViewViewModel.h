//
//  WebViewViewModel.h
//  RSSReader
//
//  Created by Nadezhda Zenkova on 11.04.2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WebViewModelDelegate <NSObject>

- (void) urlDidLoad;

@end

@interface WebViewViewModel : NSObject

@property (nonatomic, weak) NSObject<WebViewModelDelegate>* viewDelegate;

-(NSURL *)url;

- (instancetype)initWithUrl:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
