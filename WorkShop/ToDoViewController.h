//
//  ToDoViewController.h
//  WorkShop
//
//  Created by Hadeer Adel Ahmed on 21/04/2024.
//

#import <UIKit/UIKit.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray<Task *> * taskList;
@property NSMutableArray<Task *> * searchTaskList;

@end

NS_ASSUME_NONNULL_END
