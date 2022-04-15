//
//  DetailsViewController.m
//  RSSReader
//
//  Created by Nadezhda Zenkova on 11.04.2022.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@property (nonatomic, retain) UIStackView *stackView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *descriptionLabel;
@property (nonatomic, retain) UILabel *dateLabel;

@property (nonatomic, retain) DetailsViewModel *viewModel;

@end

@implementation DetailsViewController

- (instancetype)initWithViewModel:(DetailsViewModel *)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)dealloc {
    [_stackView release];
    [_titleLabel release];
    [_descriptionLabel release];
    [_dateLabel release];
    [_viewModel release];
    
    [super dealloc];
}

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [UIStackView new];
        [_stackView setAxis:UILayoutConstraintAxisVertical];
        [_stackView setDistribution:UIStackViewDistributionFillProportionally];
        [_stackView setAlignment:UIStackViewAlignmentTop];
        _stackView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _stackView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        [_titleLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightBold]];
        [_titleLabel setTextColor:UIColor.darkGrayColor];
        [_titleLabel setNumberOfLines:0];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        [_dateLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular]];
        [_dateLabel setTextColor:UIColor.grayColor];
        _dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _dateLabel;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [UILabel new];
        [_descriptionLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightRegular]];
        [_descriptionLabel setTextColor:UIColor.darkGrayColor];
        [_descriptionLabel setNumberOfLines:0];
        _descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _descriptionLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: UIColor.whiteColor];
    [self setupConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNavigationItems];
    self.viewModel.viewDelegate = self;
    [self.viewModel callData];
}

- (void) setupConstraints {
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.dateLabel];
    [self.view addSubview:self.descriptionLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.titleLabel.topAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.topAnchor constant:8.0],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.leadingAnchor constant:16.0],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.trailingAnchor constant:-16.0],
        [self.titleLabel.bottomAnchor constraintEqualToAnchor: self.dateLabel.topAnchor constant:-8.0],
        
        [self.dateLabel.leadingAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.leadingAnchor constant:16.0],
        [self.dateLabel.trailingAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.trailingAnchor constant:-16.0],
        [self.dateLabel.bottomAnchor constraintEqualToAnchor: self.descriptionLabel.topAnchor constant:-16.0],
        
        [self.descriptionLabel.leadingAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.leadingAnchor constant:16.0],
        [self.descriptionLabel.trailingAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.trailingAnchor constant:-16.0]
    ]];
}


- (void)didLoad {
    self.titleLabel.text = [self.viewModel title];
    self.dateLabel.text = [self.viewModel date];
    self.descriptionLabel.text = [self.viewModel description];
}

@end
