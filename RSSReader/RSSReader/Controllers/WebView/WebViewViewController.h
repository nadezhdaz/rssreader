//
//  WebViewViewController.h
//  RSSReader
//
//  Created by Nadezhda Zenkova on 11.04.2022.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "WebViewViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebViewViewController : UIViewController <WKNavigationDelegate>

- (instancetype)initWithViewModel:(WebViewViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
