//
//  InProgressViewController.m
//  WorkShop
//
//  Created by Hadeer Adel Ahmed on 21/04/2024.
//

#import "InProgressViewController.h"
#import "TaskViewController.h"
#import "Task.h"
#import "TaskHelper.h"
@interface InProgressViewController ()

@end

@implementation InProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    NSMutableArray<Task *> *allTasksList = [[NSMutableArray alloc] initWithArray:[TaskHelper readArrayFromUserDefaultsForKey:@"taskList"] ?: @[]];
    
    self.taskList = [NSMutableArray new];
    
    for(Task *task in allTasksList){
        if(task.status == 1){
            [self.taskList addObject:task];

        }
    }
    self.sections = 1;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSMutableArray<Task *> *allTasks = [[NSMutableArray alloc] initWithArray:[TaskHelper readArrayFromUserDefaultsForKey:@"taskList"] ?: @[]];
        
        NSMutableArray<Task *> *newTaskList = [NSMutableArray new];
        
        Task * task;
        if(self.sections == 1){
            task = [self.taskList objectAtIndex:indexPath.row];
        }
        else{
            if(indexPath.section == 0){
                task = [self.taskList0 objectAtIndex:indexPath.row];
            }
            else if(indexPath.section == 1){
                task = [self.taskList1 objectAtIndex:indexPath.row];
            }
            else {
                task = [self.taskList2 objectAtIndex:indexPath.row];
            }
        }
        
        for(Task *ctask in allTasks){
            if(![ctask.title isEqual:task.title]){
                [newTaskList addObject:ctask];
            }
        }
        [TaskHelper writeArrayToUserDefualtsForkey:@"taskList" WithArray:newTaskList];
        if(self.sections == 1){
            [self.taskList removeObject:task];
        }
        else{
            if(indexPath.section == 0){
                [self.taskList0 removeObject:task];
            }
            else if(indexPath.section == 1){
                [self.taskList1 removeObject:task];
            }
            else {
                [self.taskList2 removeObject:task];
            }
        }
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.sections == 1)
        return [self.taskList count];
    else if (section == 0)
        return [self.taskList0 count];
    else if (section == 1)
        return [self.taskList1 count];
    else
        return [self.taskList2 count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Task *task;
    NSString * imageName = @"noImage.png";
    
    // Configure the cell...
    if(self.sections == 1){
        task = [self.taskList objectAtIndex:indexPath.row];
        switch(task.priority){
            case 0:
                imageName = @"high";
                break;
            case 1:
                imageName = @"medium";
                break;
            case 2:
                imageName = @"low";
                break;
            default:
                break;
                
        }
    }
    else{
        if(indexPath.section == 0){
            task = [self.taskList0 objectAtIndex:indexPath.row];
            imageName = @"high";
        }
        else if(indexPath.section == 1){
            task = [self.taskList1 objectAtIndex:indexPath.row];
            imageName = @"medium";
        }
        else {
            task = [self.taskList2 objectAtIndex:indexPath.row];
            imageName = @"low";
        }
    }
    
    UIImage* image = [UIImage imageNamed:imageName];
    cell.textLabel.text = task.title;
    cell.imageView.image = image;
    
    return  cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    TaskViewController *viewController = [segue destinationViewController];
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Task * task;
    
    if(self.sections == 1){
        task = [self.taskList objectAtIndex:indexPath.row];
    }
    else{
        if(indexPath.section == 0){
            task = [self.taskList0 objectAtIndex:indexPath.row];
        }
        else if(indexPath.section == 1){
            task = [self.taskList1 objectAtIndex:indexPath.row];
        }
        else {
            task = [self.taskList2 objectAtIndex:indexPath.row];
        }
    }
    viewController.isUpdateTask = YES;
    viewController.task = task;
    
}

- (IBAction)filter:(UIButton *)sender {
    self.sections = 3;
    self.taskList0 = [NSMutableArray new];
    self.taskList1 = [NSMutableArray new];
    self.taskList2 = [NSMutableArray new];
    
    for(Task *task in self.taskList){
        if(task.priority == 0){
            [self.taskList0 addObject:task];
        }
        else if(task.priority == 1){
            [self.taskList1 addObject:task];
        }
        else{
            [self.taskList2 addObject:task];
        }
    }
    
    [self.tableView reloadData];
}
@end
