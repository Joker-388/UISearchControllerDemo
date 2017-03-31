//
//  JKRViewController.m
//  JKRSearchBar
//
//  Created by tronsis_ios on 17/3/31.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "JKRViewController.h"
#import "JKRSearchResultViewController.h"
#import "JKRDataStore.h"

@interface JKRViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *dataArray;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation JKRViewController

static NSString *const cellID = @"CELL_ID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"城市列表";
    // 不加这句的话，弹出的结果视图不会跟随搜索框上移
    self.definesPresentationContext = YES;
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.tableView];
    [self.tableView setTableHeaderView:self.searchController.searchBar];
    [self customSearchBar];
}

- (void)customSearchBar {
    // 搜索框背景色
    self.searchController.searchBar.barTintColor = [UIColor yellowColor];
    // 搜索框光标颜色和取消按钮文字颜色
    self.searchController.searchBar.tintColor = [UIColor greenColor];
    // 搜索框放大镜图标
    [self.searchController.searchBar setImage:[UIImage imageNamed:@"search_gray"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    // 搜索框清楚按钮图标
    [self.searchController.searchBar setImage:[UIImage imageNamed:@"wrong_progress"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    [self.searchController.searchBar setImage:[UIImage imageNamed:@"wrong_progress"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateHighlighted];
    // 搜索框文字输入框设置
    UITextField *textField = [self.searchController.searchBar valueForKey:@"_searchField"];
    textField.textColor = [UIColor redColor];
    textField.font = [UIFont systemFontOfSize:16.f];
    // 搜索框文字输入框占位文字颜色
    [textField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    // 取消按钮文字
    [self.searchController.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
    // 搜索框背景图片，会覆盖背景色
    self.searchController.searchBar.backgroundImage = [UIImage imageNamed:@"5"];
    // 搜索框文字输入框边框图片
    [self.searchController.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UISearchResultsUpdating
// Called when the search bar's text or scope has changed or when the search bar becomes first responder.
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    if (!(searchText.length > 0)) return;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF CONTAINS %@)", searchText];
    JKRSearchResultViewController *resultController = (JKRSearchResultViewController *)searchController.searchResultsController;
    resultController.filterDataArray = [self.dataArray filteredArrayUsingPredicate:predicate];
}

#pragma mark - UISearchControllerDelegate
/**
 These methods are called when automatic presentation or dismissal occurs. They will not be called if you present or dismiss the search controller yourself.
 */

- (void)willPresentSearchController:(UISearchController *)searchController {
    
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    
}

#pragma mark - UISearchBarDelegate
// return NO to not become first responder
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
}

// called when text starts editing
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}

// return NO to not resign first responder
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}

// called when text ends editing
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
}

// called when text changes (including clear)
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}

// called before text changes
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0) {
    return YES;
}

// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
}

// called when bookmark button pressed
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED {
    
}

// called when cancel button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED {
    
}

// called when search results button pressed
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED {
    
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope NS_AVAILABLE_IOS(3_0) {
    
}

#pragma mark - lazy load
- (NSArray<NSString *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [JKRDataStore sharedStore].dataArray;
    }
    return _dataArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

- (UISearchController *)searchController {
    if (!_searchController) {
        JKRSearchResultViewController *resultSearchController = [[JKRSearchResultViewController alloc] init];
        _searchController = [[UISearchController alloc] initWithSearchResultsController:resultSearchController];
        _searchController.dimsBackgroundDuringPresentation = YES;
        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.searchBar.placeholder = @"请输入搜索内容";
        _searchController.searchBar.delegate = self;
        _searchController.searchResultsUpdater = self;
        _searchController.delegate = self;
    }
    return _searchController;
}

@end
