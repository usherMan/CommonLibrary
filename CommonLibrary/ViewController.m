//
//  ViewController.m
//  CommonLibrary
//
//  Created by usher on 2019/5/8.
//  Copyright © 2019年 usher. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+Usher.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.shopTextView.zw_placeHolder =@"请输入用户名";
    self.shopTextView.zw_limitCount=10;
    
    NSDate  *date  =[[NSDate date] dateOfYMDHMS];
    NSDate  *date1 =[date dateByAddingYears:3];
    
    NSString *str1 =[date stringOfYMDHMS];

    NSLog(@"str1=====%@=====%@=====%ld",str1,date,[date1 yearsEarlierThan:date]);
    
}
- (IBAction)btnClick:(id)sender forEvent:(UIEvent *)event {
    SHOWERROR(@"偶奥如皋人寡人龚fei1合肥市")
}

@end
