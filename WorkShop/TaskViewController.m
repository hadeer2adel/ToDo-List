//
//  TaskViewController.m
//  WorkShop
//
//  Created by Hadeer Adel Ahmed on 21/04/2024.
//

#import "TaskViewController.h"
#import "Task.h"
#import "TaskHelper.h"


@interface TaskViewController ()

@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(self.isUpdateTask){
        self.titleText.text = self.task.title;
        self.descreptionText.text = self.task.descriptionT;
        self.priorityText.selectedSegmentIndex = self.task.priority;
        self.statusText.selectedSegmentIndex = self.task.status;
        [self.datePicker setDate:self.task.date animated:YES];
    }
}

/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveTask:(UIButton *)sender {
    Task* newTask = [Task new];
    newTask.title = self.titleText.text;
    newTask.descriptionT = self.descreptionText.text;
    newTask.priority = self.priorityText.selectedSegmentIndex;
    newTask.status = self.statusText.selectedSegmentIndex;
    newTask.date = self.datePicker.date;

    NSMutableArray<Task *> *taskList = [[NSMutableArray alloc] initWithArray:[TaskHelper readArrayFromUserDefaultsForKey:@"taskList"] ?: @[]];

    if(self.isUpdateTask){
        NSMutableArray<Task *> *newTaskList = [NSMutableArray new];
        
        for(Task *ctask in taskList){
            if([ctask.title isEqual:self.task.title]){
                [newTaskList addObject:newTask];
            }
            else{
                [newTaskList addObject:ctask];
            }
        }
        [TaskHelper writeArrayToUserDefualtsForkey:@"taskList" WithArray:newTaskList];
    }
    else{
        [taskList addObject:newTask];
        [TaskHelper writeArrayToUserDefualtsForkey:@"taskList" WithArray:taskList];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)datePicker:(UIDatePicker *)sender {
}

- (IBAction)status:(UIButton *)sender {
}

- (IBAction)priority:(UISegmentedControl *)sender {
}
@end
