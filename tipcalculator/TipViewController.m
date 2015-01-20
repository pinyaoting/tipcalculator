//
//  TipViewController.m
//  tipcalculator
//
//  Created by Pythis Ting on 1/19/15.
//  Copyright (c) 2015 Yahoo!, inc. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (IBAction)onTap:(id)sender;
- (void)updateUI;

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self) {
        self.title = @"Tip Calculator";
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"⚙" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    [self updateUI];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateUI];
}

- (void)updateUI {
    float billAmount = [self.billTextField.text floatValue];

    // Load user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
    long tipOption0 = [defaults integerForKey:@"tipOption0"];
    long tipOption1 = [defaults integerForKey:@"tipOption1"];
    long tipOption2 = [defaults integerForKey:@"tipOption2"];
    
    if (tipOption0 == nil) {
        tipOption0 = 15;
    }
    if (tipOption1 == nil) {
        tipOption1 = 18;
    }
    if (tipOption2 == nil) {
        tipOption2 = 20;
    }
    
    // update segment labels
    [self.tipControl setTitle:[NSString stringWithFormat:@"%li%%",tipOption0] forSegmentAtIndex:0];
    [self.tipControl setTitle:[NSString stringWithFormat:@"%li%%",tipOption1] forSegmentAtIndex:1];
    [self.tipControl setTitle:[NSString stringWithFormat:@"%li%%",tipOption2] forSegmentAtIndex:2];
    
    NSArray *tipValues = @[[NSNumber numberWithFloat:(float)tipOption0/100], [NSNumber numberWithFloat:(float)tipOption1/100], [NSNumber numberWithFloat:(float)tipOption2/100]];
    
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmount + billAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void)onSettingsButton {
    SettingsViewController* svc = [[SettingsViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}

@end
