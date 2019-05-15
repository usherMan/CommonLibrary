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
    
}
- (IBAction)btnClick:(id)sender forEvent:(UIEvent *)event {
    [ self.view  makeToastActivity];
}

@end
