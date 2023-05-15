//
//  InProgressViewController.m
//  WorkShop
//
//  Created by Mac on 26/04/2023.
//

#import "InProgressViewController.h"
#import "Utilites.h"
#import "Task.h"
#import "DetailsViewController.h"

@interface InProgressViewController (){
    Utilites *utlites;
    Task *task;
    NSMutableArray<Task*> *progressArrHigh;
    NSMutableArray<Task*> *myArrHigh;
    
    NSMutableArray<Task*> *progressArrLow;
    NSMutableArray<Task*> *myArrLow;
    
    NSMutableArray<Task*> *progressArrMedium;
    NSMutableArray<Task*> *myArrMedium;
    
    NSMutableArray<Task*> *arr;
    
    BOOL isFiltered;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation InProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate= self;
    _tableView.dataSource= self;
    isFiltered = false;
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    myArrHigh=[[NSMutableArray<Task *> alloc] init];
    myArrMedium=[[NSMutableArray<Task *> alloc] init];
    myArrLow=[[NSMutableArray<Task *> alloc] init];
    utlites = [Utilites new];
    if([utlites read:@"inProgressArrayHigh"]!= nil){
        progressArrHigh=[utlites read:@"inProgressArrayHigh"];}
    
    if([utlites read:@"inProgressArrayMedium"]!= nil){
        progressArrMedium=[utlites read:@"inProgressArrayMedium"];}
    
    if([utlites read:@"inProgressArrayLow"]!= nil){
        progressArrLow=[utlites read:@"inProgressArrayLow"];}
    
    myArrHigh= progressArrHigh;
    myArrMedium=progressArrMedium;
    myArrLow=progressArrLow;
    arr=[[NSMutableArray<Task *> alloc] init];
    
   
    [arr addObjectsFromArray:myArrHigh];
    [arr addObjectsFromArray:myArrMedium];
    [arr addObjectsFromArray:myArrLow];
    
    [self.tableView reloadData];
}

- (IBAction)filterBtn:(id)sender {
    isFiltered = true;
    [_tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(isFiltered){
        return 1;
    }else{
        return 3;}
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(isFiltered){
        return nil;
    }else{
        switch(section)
        {
            case 0:
                return @"High";
            case 1:
                return @"Medium";
            default:
                return @"Low";
        }
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //return [myArrHigh count] ;
    if(isFiltered){
        return [arr count];
    }else{
        switch (section) {
            case 0:
                return [myArrHigh count] ;
                break;
                
            case 1:
                return [myArrMedium count];
                
            case 2:
                return [myArrLow count];
            default:
                return 0;
                break;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if(isFiltered){
        Task *myTassssk = [arr objectAtIndex:indexPath.row];
        if([myTassssk.perority isEqual:@"high"] ){
            cell.imageView.image=[UIImage imageNamed:@"high.png"];
        }else if ([myTassssk.perority isEqual:@"medium"] ){
            cell.imageView.image=[UIImage imageNamed:@"medium.png"];
        }else{
            cell.imageView.image=[UIImage imageNamed:@"low.png"];
        }
       // cell.imageView.image=[[arr objectAtIndex:indexPath.row] ];
        cell.textLabel.text=[[arr objectAtIndex:indexPath.row] title];
    }else{
        
        switch (indexPath.section) {
            case 0:
                cell.textLabel.text =[[myArrHigh objectAtIndex:indexPath.row] title];
                cell.imageView.image=[UIImage imageNamed:@"high.png"];
                break;
                
            case 1:
                cell.textLabel.text =[[myArrMedium objectAtIndex:indexPath.row] title];
                cell.imageView.image=[UIImage imageNamed:@"medium.png"];
                break;
                
            case 2:
                cell.textLabel.text =[[myArrLow objectAtIndex:indexPath.row] title];
                cell.imageView.image=[UIImage imageNamed:@"low.png"];
                break;
                
            default:
                break;
        }
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if(isFiltered){
            [arr removeObjectAtIndex:indexPath.row];
           // [utlites write:<#(nonnull NSMutableArray *)#> andKey:<#(nonnull NSString *)#>];
//            [utlites write:myArrHigh andKey:@"inProgressArrayHigh"];
//            [utlites write:myArrMedium  andKey:@"inProgressArrayMedium"];
//            [utlites write:myArrLow andKey:@"inProgressArrayLow"];
//            
            Task *myTassssk = [arr objectAtIndex:indexPath.row];
            if([myTassssk.perority isEqual:@"high"] ){
                [utlites write:myArrHigh andKey:@"inProgressArrayHigh"];
            }else if([myTassssk.perority isEqual:@"high"] ){
                [utlites write:myArrMedium  andKey:@"inProgressArrayMedium"];
            }else{
                [utlites write:myArrLow andKey:@"inProgressArrayLow"];
            }
        }else{
            
            switch(indexPath.section){
                case 0:
                    [myArrHigh removeObjectAtIndex:indexPath.row];
                    [utlites write:myArrHigh andKey:@"inProgressArrayHigh"];
                    break;
                case 1:
                    [myArrMedium removeObjectAtIndex:indexPath.row];
                    [utlites write:myArrMedium  andKey:@"inProgressArrayMedium"];
                    break;
                case 2:
                    [myArrLow removeObjectAtIndex:indexPath.row];
                    [utlites write:myArrLow andKey:@"inProgressArrayLow"];
                    break;
                    
                default:
                    break;
            }
        }
        [tableView reloadData];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsScreen"];
    Task *myTask =[arr objectAtIndex: indexPath.row ] ;
    dvc.titleDetails= [myTask title];
    dvc.descDetails=[myTask desc];
    dvc.perorityDetails=[myTask perority];
    dvc.dateDetails=[myTask date];
    [self.navigationController pushViewController:dvc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


@end
