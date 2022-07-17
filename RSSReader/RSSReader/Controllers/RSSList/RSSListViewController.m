//
//  RSSListViewController.m
//  RSSReader
//
//  Created by Nadezhda Zenkova on 31.01.2022.
//

#import "RSSListViewController.h"
#import "DetailsViewController.h"
#import "WebViewViewController.h"
#import "UIAlertController+Utilities.h"
#import "UIApplication+NetworkActivity.h"

//@class DetailsViewController;

@interface RSSListViewController ()

@property (nonatomic, weak) UITableView *listTableView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) RSSListViewModel *viewModel;
@property (nonatomic, retain) DetailsViewController *detailsViewController;
@property (nonatomic, retain) WebViewViewController *webViewViewController;

@end

@implementation RSSListViewController

-(DetailsViewController *)detailsViewController {
    if (!_detailsViewController) {
        _detailsViewController = [DetailsViewController new];
    }
    return _detailsViewController;
}

-(WebViewViewController *)webViewViewController {
    if (!_webViewViewController) {
        _webViewViewController = [WebViewViewController new];
    }
    return _webViewViewController;
}

- (void)setViewModel:(RSSListViewModel *)viewModel {
    _viewModel = viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel.viewDelegate = self;
    [self.viewModel updateData];
    
    [self.view setBackgroundColor: UIColor.whiteColor];
    [self setupNavigationItems];
    [self setupTableView];
    [self setupActivityIndicator];
    [self.webViewViewController loadViewIfNeeded];
}

- (void)setupNavigationItems {
    self.navigationItem.title = [NSString stringWithFormat:@"Feed"];
    [self.navigationController.navigationBar setBarTintColor:UIColor.whiteColor];
    [self.navigationController.navigationBar setTintColor:UIColor.orangeColor];
    self.navigationController.navigationBar.standardAppearance.titleTextAttributes = @{NSForegroundColorAttributeName : UIColor.orangeColor};
}

- (void) setupTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"TopicsListCellId"];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.listTableView = tableView;
    
    [self.view addSubview:tableView];
    
    [NSLayoutConstraint activateConstraints:@[
        [tableView.topAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.topAnchor constant:0.0],
        [tableView.leadingAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.leadingAnchor constant:0.0],
        [tableView.trailingAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.trailingAnchor constant:0.0],
        [tableView.bottomAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.bottomAnchor constant:0.0]
    ]];
}

- (void) setupActivityIndicator {
    self.activityIndicator = [UIActivityIndicatorView new];
    [self.activityIndicator setBounds: self.view.frame];
    [self.activityIndicator setCenter: self.view.center];
    self.activityIndicator.hidesWhenStopped = true;
    [self.view addSubview:self.activityIndicator];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"TopicsListCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    RSSEntry *entry = [[self.viewModel topicForIndex:indexPath.row] retain];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = entry.title;
    cell.textLabel.textColor = UIColor.darkGrayColor;
    [entry release];
    
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfRows];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.webViewViewController setViewModel:[self.viewModel webViewForIndex:indexPath.row]];
    [self.navigationController pushViewController:self.webViewViewController animated:true];
    [self.listTableView deselectRowAtIndexPath:indexPath animated:true];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    [self.detailsViewController setViewModel:[self.viewModel detailsForIndex:indexPath.row]];
    [self.navigationController pushViewController:self.detailsViewController animated:true];
}

- (void)dealloc {
    [_listTableView release];
    [_activityIndicator release];
    [_viewModel release];
    [_detailsViewController release];
    [_webViewViewController release];
    
    [super dealloc];
}

#pragma mark - RSSListViewModelDelegate Methods

- (void)didStartLoading {
    [self activityIndicatorStart];
}

- (void)didFailWithErrorMessage:(NSString *)message {
    [self activityIndicatorStop];
    [self presentViewController:[UIAlertController presentAlertWithErrorMessage:message] animated:YES completion:nil];
}

- (void)didFinishLoading {
    [self activityIndicatorStop];
    //self.navigationItem.title = [self.viewModel titleForFeed];
    [self.listTableView reloadData];
}

#pragma mark - Private Methods

- (void)activityIndicatorStart {
    if (@available(iOS 13.0, *)) {
        [self.activityIndicator startAnimating];
    } else {
        [UIApplication startNetworkActivityIndicator];
    }
}

- (void)activityIndicatorStop {
    if (@available(iOS 13.0, *)) {
        if (self.activityIndicator.isAnimating) {
            [self.activityIndicator stopAnimating];
        }
    } else {
        [UIApplication stopNetworkActivityIndicator];
    }
}


@end
