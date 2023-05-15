//
//  ViewController.m
//  WorkShop
//
//  Created by Mac on 26/04/2023.
//

#import "ViewController.h"
#import "AddTaskViewController.h"
#import "Task.h"
#import "Utilites.h"
#import "DetailsViewController.h"
#import "EditViewController.h"

@interface ViewController (){
    
    
    NSMutableArray<Task *> *arrHigh;
    Task *task;
    
    NSMutableArray<Task *> *filteredTasks;
    BOOL isFiltered;
    
    NSArray<Task*> *taskArray;
    Utilites *utlites;
    
}
@property (weak, nonatomic) IBOutlet UIToolbar *searchBar;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSUserDefaults *defaults;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate= self;
    _tableView.dataSource= self;
    
    arrHigh=[[NSMutableArray<Task *> alloc] init];
    
    isFiltered = false;
    self.searchBar.delegate = self;
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length == 0){
        isFiltered = false;
    }else{
        isFiltered = true;
        filteredTasks=[[NSMutableArray<Task *> alloc] init];
        
        for (Task *myTask in arrHigh) {
            NSRange titleRange = [myTask.title rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if(titleRange.location != NSNotFound){
                [filteredTasks addObject:myTask];
            }
        }
        
    }
    
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    utlites = [Utilites new];
    printf("gggggggg");
    //taskArray= [utlites read:@"taskArray"];
    
    if([utlites read:@"taskArray"]!=nil){
        taskArray=[utlites read:@"taskArray"];}
    else{
            taskArray = [NSMutableArray<Task*> new];
        taskArray=[utlites read:@"taskArray"];
        
        
        }
    
    arrHigh = taskArray;
    
    [self.tableView reloadData];
}


- (IBAction)addTaskBtn:(id)sender {
    AddTaskViewController *atvc = [self.storyboard instantiateViewControllerWithIdentifier:@"addTaskScreen"];
    [self.navigationController pushViewController:atvc animated:YES];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(isFiltered){
        return [filteredTasks count];
    }
    return [arrHigh count] ;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if(isFiltered){
        task=[filteredTasks objectAtIndex:indexPath.row];
    }else{
        task=[arrHigh objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text =task.title;
    
    if([task.perority isEqual:@"high"]){
        cell.imageView.image=[UIImage imageNamed:@"high.png"];
        
    }else if ([task.perority isEqual:@"medium"]){
        cell.imageView.image=[UIImage imageNamed:@"medium.png"];
    }
    else{
        cell.imageView.image=[UIImage imageNamed:@"low.png"];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsScreen"];
    Task *myTask =[arrHigh objectAtIndex: indexPath.row ] ;
    dvc.titleDetails= [myTask title];
    dvc.descDetails=[myTask desc];
    dvc.perorityDetails=[myTask perority];
    dvc.dateDetails=[myTask date];
    [self.navigationController pushViewController:dvc animated:YES];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Edit" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self navToEdit: indexPath.row];
    }];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self deleteTask: indexPath.row];
    }];
    
    return @[deleteAction,editAction];
}


-(void) navToEdit:(int)index{
    EditViewController *evc = [self.storyboard instantiateViewControllerWithIdentifier:@"EditScreen"];
    
    Task *myTask =[arrHigh objectAtIndex: index] ;
    
    evc.titleEdit= [myTask title];
    evc.descEdit=[myTask desc];
    evc.dateEdit=[myTask date];
    evc.perorityEdit=[myTask perority];
    evc.indexEdit=index;
    
    [utlites write:taskArray andKey:@"taskArray"];
    [self.navigationController pushViewController:evc animated:YES];
    
}

-(void) deleteTask:(int)index{
    [arrHigh removeObjectAtIndex:index];
    
    [utlites write:arrHigh andKey:@"taskArray"];
    [_tableView reloadData];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}



@end
