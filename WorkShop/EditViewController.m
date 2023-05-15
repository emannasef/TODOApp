//
//  EditViewController.m
//  WorkShop
//
//  Created by Mac on 26/04/2023.
//

#import "EditViewController.h"
#import "Task.h"
#import "Utilites.h"
@interface EditViewController (){
    Task *task;
    NSMutableArray<Task*> *inProgressArrayHigh;
    NSMutableArray<Task*> *inProgressArrayMedium;
    NSMutableArray<Task*> *inProgressArrayLow;
    
    NSMutableArray<Task*> *doneArrayHigh;
    NSMutableArray<Task*> *doneArrayMedium;
    NSMutableArray<Task*> *doneArrayLow;
    
    NSMutableArray<Task*>  *taskArray;
    Utilites *utlites;
}
@property (weak, nonatomic) IBOutlet UITextField *editDescTF;
@property (weak, nonatomic) IBOutlet UITextField *editTitleTF;
@property (weak, nonatomic) IBOutlet UIDatePicker *editDateTf;
@property (weak, nonatomic) IBOutlet UISegmentedControl *editPeriorityTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *state;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    utlites = [Utilites new];
    taskArray=[NSMutableArray<Task*> new];
    
    inProgressArrayHigh=[NSMutableArray<Task*> new];
    inProgressArrayMedium=[NSMutableArray<Task*> new];
    inProgressArrayLow=[NSMutableArray<Task*> new];
    
    doneArrayHigh=[NSMutableArray<Task*> new];
   doneArrayMedium=[NSMutableArray<Task*> new];
    doneArrayLow=[NSMutableArray<Task*> new];
   
    if([utlites read:@"taskArray"]!=nil){
        taskArray=[utlites read:@"taskArray"];}
    
    if([utlites read:@"inProgressArrayHigh"]!= nil){
        inProgressArrayHigh=[utlites read:@"inProgressArrayHigh"];}
    
    if([utlites read:@"inProgressArrayMedium"]!= nil){
        inProgressArrayMedium=[utlites read:@"inProgressArrayMedium"];}
    
    if([utlites read:@"inProgressArrayLow"]!= nil){
        inProgressArrayLow=[utlites read:@"inProgressArrayLow"];}
    
    
    if([utlites read:@"doneArrayHigh"]!= nil){
       doneArrayHigh=[utlites read:@"doneArrayHigh"];}
    
    if([utlites read:@"doneArrayMedium"]!= nil){
        doneArrayMedium=[utlites read:@"doneArrayMedium"];}
    
    if([utlites read:@"doneArrayLow"]!= nil){
        doneArrayLow=[utlites read:@"doneArrayLow"];}
    
    
    
    _editTitleTF.text=_titleEdit;
    _editDescTF.text=_descEdit;
    _editDateTf.date=_dateEdit;
    
    if([_perorityEdit isEqual:@"high"]){
        _editPeriorityTF.selectedSegmentIndex=0;
    }else if ([_perorityEdit isEqual:@"medium"]){
        _editPeriorityTF.selectedSegmentIndex=1;
    }
    else{
        _editPeriorityTF.selectedSegmentIndex=2;
    }
    
}


- (IBAction)saveChangesAfterEdit:(id)sender {
    
    
    
    task = [Task new];
    task.title= _editTitleTF.text;
    task.desc=_editDescTF.text;
    task.date=_editDateTf.date;
    
    if( _editPeriorityTF.selectedSegmentIndex==0){
        task.perority=@"high";
    }else if (_editPeriorityTF.selectedSegmentIndex==1){
        task.perority=@"medium";
    }else{
        task.perority=@"low";
    }
    

    
    
    if([_state selectedSegmentIndex]==0){
        task.taskState=@"toDoList";
        [taskArray removeObjectAtIndex:_indexEdit];
        [taskArray addObject:task];
        [utlites write:taskArray andKey:@"taskArray"];
        
    }else if ([_state selectedSegmentIndex]==1){
        task.taskState=@"inProgress";
        printf("%d counnnnnt\n",[taskArray count]);
        printf("%d indeeeeeeeex\n",_indexEdit);
        [taskArray removeObjectAtIndex:_indexEdit];
        [utlites write:taskArray andKey:@"taskArray"];
        
        if([_perorityEdit isEqual:@"high"]){
            [inProgressArrayHigh addObject:task];
            [utlites write:inProgressArrayHigh andKey:@"inProgressArrayHigh"];}
        
        else if ([_perorityEdit isEqual:@"medium"]){
            [inProgressArrayMedium addObject:task];
            [utlites write:inProgressArrayMedium andKey:@"inProgressArrayMedium"];
        }else{
            [inProgressArrayLow addObject:task];
            [utlites write:inProgressArrayLow andKey:@"inProgressArrayLow"];
        }
   
    }else {
        task.taskState=@"done";
        [taskArray removeObjectAtIndex:_indexEdit];
        [utlites write:taskArray andKey:@"taskArray"];
        if([_perorityEdit isEqual:@"high"]){
            [doneArrayHigh addObject:task];
            [utlites write:doneArrayHigh andKey:@"doneArrayHigh"];}
        
        else if ([_perorityEdit isEqual:@"medium"]){
            [doneArrayMedium addObject:task];
            [utlites write:doneArrayMedium andKey:@"doneArrayMedium"];
        }else{
            [doneArrayLow addObject:task];
            [utlites write:doneArrayLow andKey:@"doneArrayLow"];
        }
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
