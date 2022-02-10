//
//  RSSListViewController.m
//  RSSReader
//
//  Created by Nadezhda Zenkova on 31.01.2022.
//

#import "RSSListViewController.h"

@interface RSSListViewController ()

@property (nonatomic, retain) UITableView *listTableView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) RSSListViewModel *viewModel;

@end

@implementation RSSListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: UIColor.whiteColor];
    [self setupNavigationItems];
    [self setupTableView];
    [self setupActivityIndicator];
    [self didStartLoading];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.viewModel = [RSSListViewModel new];
    self.viewModel.viewDelegate = self;
}

- (void)setupNavigationItems {
    self.navigationController.navigationBar.tintColor = UIColor.redColor;
    [self.navigationController.navigationBar setBackgroundColor: UIColor.whiteColor];
    self.navigationItem.title = [self.viewModel titleForFeed];
}

- (void) setupTableView {
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [self.listTableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"TopicsListCellId"];
    self.listTableView.dataSource = self;
    self.listTableView.delegate = self;
    
    self.listTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.listTableView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.listTableView.topAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.topAnchor constant:0.0],
        [self.listTableView.leadingAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.leadingAnchor constant:0.0],
        [self.listTableView.trailingAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.trailingAnchor constant:0.0],
        [self.listTableView.bottomAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.bottomAnchor constant:0.0]
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
    
    RSSEntry *entryData = [[self.viewModel topicAtIndex:indexPath.row] retain];
    cell.textLabel.text = entryData.title;
    [entryData release];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfRows];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *url = [self.viewModel topicAtIndex:indexPath.row].link;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
    //[url release];
    
    [self.listTableView deselectRowAtIndexPath:indexPath animated:true];
}

- (void)dealloc {
    [_listTableView release];
    [_activityIndicator release];
    [_viewModel release];
    
    [super dealloc];
}

#pragma mark - Private Methods



#pragma mark - RSSListViewModelDelegate Methods

- (void)didStartLoading {
    if (@available(iOS 13.0, *)) {
        [self.activityIndicator startAnimating];        
    } else {
        UIApplication* app = [UIApplication sharedApplication];
        app.networkActivityIndicatorVisible = true;
    }
}

- (void)didFailWithError:(NSError *)error {
    if (@available(iOS 13.0, *)) {
        if (self.activityIndicator.isAnimating) {
            [self.activityIndicator stopAnimating];
        }
    } else {
        UIApplication* app = [UIApplication sharedApplication];
        app.networkActivityIndicatorVisible = false;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                             message:[NSString stringWithFormat:@"%@", error.localizedDescription]
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didFinishLoading {
    if (@available(iOS 13.0, *)) {
        if (self.activityIndicator.isAnimating) {
            [self.activityIndicator stopAnimating];
        }
    } else {
        UIApplication* app = [UIApplication sharedApplication];
        app.networkActivityIndicatorVisible = false;
    }
    [self.listTableView reloadData];
    [self.listTableView layoutIfNeeded];
}

@end
