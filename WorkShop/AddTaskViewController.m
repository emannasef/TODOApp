//
//  AddTaskViewController.m
//  WorkShop
//
//  Created by Mac on 26/04/2023.
//

#import "AddTaskViewController.h"
#import "Task.h"
#import "Utilites.h"

@interface AddTaskViewController (){
    Task *task;
    NSMutableArray<Task*> *taskArray;
    Utilites *utlites;
  
}
@property (weak, nonatomic) IBOutlet UIDatePicker *date;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTF;
@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;



@property NSUserDefaults *defaults;

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    utlites = [Utilites new];
    
    taskArray= [utlites read:@"taskArray"];
    if(taskArray==nil){
        taskArray = [NSMutableArray new];
    }

}

- (IBAction)userAddTaskBtn:(id)sender {
    task = [Task new];
    task.title = _titleTF.text;
    task.desc =_descriptionTF.text;
    task.date=_date.date;
    

    if([_segment selectedSegmentIndex]==0){
        task.perority=@"high";
    }else if ([_segment selectedSegmentIndex]==1){
        task.perority=@"medium";
    }
    else{
        task.perority=@"low";
    }
    
    
    if(_titleTF.text.length>0){

        [taskArray addObject: task];
        [utlites write:taskArray andKey:@"taskArray"];
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Task" message:@"title shoudn't be empty" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            printf("Failed");
        }];
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:NULL];
    }
    

}

@end
