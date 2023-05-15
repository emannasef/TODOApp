//
//  DetailsViewController.m
//  WorkShop
//
//  Created by Mac on 26/04/2023.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *detailsTitleLB;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTv;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UIDatePicker *myDate;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _detailsTitleLB.text= _titleDetails;
    _descriptionTv.text= _descDetails;
    _myDate.date=_dateDetails;
    
    if([_perorityDetails isEqual:@"high"]){
        _segment.selectedSegmentIndex=0;
    }else if ([_perorityDetails isEqual:@"medium"]){
        _segment.selectedSegmentIndex=1;
    }
    else{
        _segment.selectedSegmentIndex=2;
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

@end
