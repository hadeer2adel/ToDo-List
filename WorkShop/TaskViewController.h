//
//  TaskViewController.h
//  WorkShop
//
//  Created by Hadeer Adel Ahmed on 21/04/2024.
//

#import <UIKit/UIKit.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskViewController : UIViewController

@property Task* task;
@property bool isUpdateTask;

@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *descreptionText;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priorityText;
@property (weak, nonatomic) IBOutlet UISegmentedControl *statusText;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)saveTask:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
