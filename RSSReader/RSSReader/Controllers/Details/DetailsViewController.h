//
//  DetailsViewController.h
//  RSSReader
//
//  Created by Nadezhda Zenkova on 11.04.2022.
//

#import <UIKit/UIKit.h>
#import "DetailsViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController <DetailsViewModelDelegate>

- (instancetype)initWithViewModel:(DetailsViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
