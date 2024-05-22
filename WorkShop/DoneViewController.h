//
//  DoneViewController.h
//  WorkShop
//
//  Created by Hadeer Adel Ahmed on 21/04/2024.
//

#import <UIKit/UIKit.h>
#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@interface DoneViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)filter:(UIButton *)sender;

@property NSMutableArray<Task *> * taskList;
@property int sections;
@property NSMutableArray<Task *> * taskList0;
@property NSMutableArray<Task *> * taskList1;
@property NSMutableArray<Task *> * taskList2;
@end

NS_ASSUME_NONNULL_END
