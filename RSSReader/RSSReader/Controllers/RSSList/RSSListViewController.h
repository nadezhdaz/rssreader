//
//  RSSListViewController.h
//  RSSReader
//
//  Created by Nadezhda Zenkova on 31.01.2022.
//

#import <UIKit/UIKit.h>
#import "RSSListViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSSListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RSSListViewModelDelegate>

- (void)setViewModel:(RSSListViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
