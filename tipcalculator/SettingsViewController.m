//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Pythis Ting on 1/19/15.
//  Copyright (c) 2015 Yahoo!, inc. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
- (void) loadUserPrefs;
- (void) saveUserPrefs;
- (void) updateUI;
@property (weak, nonatomic) IBOutlet UITextField *tipTextField0;
@property (weak, nonatomic) IBOutlet UITextField *tipTextField1;
@property (weak, nonatomic) IBOutlet UITextField *tipTextField2;
- (IBAction)onTap:(id)sender;

@end

@implementation SettingsViewController

int previousPreset;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tipTextField0.text = @"";
    self.tipTextField1.text = @"";
    self.tipTextField2.text = @"";
    [self updateUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadUserPrefs {
    // load user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    long tipOption0 = [defaults integerForKey:@"tipOption0"];
    long tipOption1 = [defaults integerForKey:@"tipOption1"];
    long tipOption2 = [defaults integerForKey:@"tipOption2"];
    
    if (tipOption0 != nil) {
        self.tipTextField0.text = [NSString stringWithFormat:@"%li",tipOption0];
    } else {
        self.tipTextField0.text = @"15";
    }
    if (tipOption1 != nil) {
        self.tipTextField1.text = [NSString stringWithFormat:@"%li",tipOption1];
    } else {
        self.tipTextField1.text = @"18";
    }
    if (tipOption2 != nil) {
        self.tipTextField2.text = [NSString stringWithFormat:@"%li",tipOption2];
    } else {
        self.tipTextField2.text = @"20";
    }
}

- (void) saveUserPrefs {
    // access user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![self.tipTextField0.text isEqual:@""]) {
        [defaults setInteger:self.tipTextField0.text.intValue forKey:@"tipOption0"];
    }
    if (![self.tipTextField1.text isEqual:@""]) {
        [defaults setInteger:self.tipTextField1.text.intValue forKey:@"tipOption1"];
    }
    if (![self.tipTextField2.text isEqual:@""]) {
        [defaults setInteger:self.tipTextField2.text.intValue forKey:@"tipOption2"];
    }
    [defaults synchronize];
}

- (void) updateUI {
    [self saveUserPrefs];
    [self loadUserPrefs];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateUI];
}
@end
