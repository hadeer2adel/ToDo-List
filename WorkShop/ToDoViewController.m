//
//  ToDoViewController.m
//  WorkShop
//
//  Created by Hadeer Adel Ahmed on 21/04/2024.
//

#import "ToDoViewController.h"
#import "TaskViewController.h"
#import "Task.h"
#import "TaskHelper.h"

@interface ToDoViewController ()

@end

@implementation ToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)viewWillAppear:(BOOL)animated{
    NSMutableArray<Task *> *allTasksList = [[NSMutableArray alloc] initWithArray:[TaskHelper readArrayFromUserDefaultsForKey:@"taskList"] ?: @[]];
    
    self.taskList = [NSMutableArray new];
    
    for(Task *task in allTasksList){
        if(task.status == 0){
            [self.taskList addObject:task];
        }
    }
    
    self.searchTaskList = self.taskList;
    self.searchBar.delegate = self;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSMutableArray<Task *> *allTasks = [[NSMutableArray alloc] initWithArray:[TaskHelper readArrayFromUserDefaultsForKey:@"taskList"] ?: @[]];
        
        NSMutableArray<Task *> *newTaskList = [NSMutableArray new];
        
        for(Task *ctask in allTasks){
            if(![ctask.title isEqual:self.searchTaskList[indexPath.row].title]){
                [newTaskList addObject:ctask];
            }
        }
        [TaskHelper writeArrayToUserDefualtsForkey:@"taskList" WithArray:newTaskList];
        [self.searchTaskList removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.searchTaskList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    Task *task = [self.searchTaskList objectAtIndex:indexPath.row];
    NSString * imageName = @"noImage.png";
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
    UIImage* image = [UIImage imageNamed:imageName];
        
    cell.textLabel.text = task.title;
    cell.imageView.image = image;
    
    return  cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    TaskViewController *viewController = [segue destinationViewController];
    
    if([segue.identifier isEqual:@"updateTask"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        viewController.isUpdateTask = YES;
        viewController.task = self.searchTaskList[indexPath.row];
    }
    else{
        viewController.isUpdateTask = NO;
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length == 0){
        self.searchTaskList = self.taskList;
    }
    else{
        NSPredicate * p = [NSPredicate predicateWithFormat:@"title CONTAINS[c] %@", searchText];
        self.searchTaskList = [self.taskList filteredArrayUsingPredicate:p];
    }
    [self.tableView reloadData];
}

@end
