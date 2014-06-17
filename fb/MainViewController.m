//
//  MainViewController.m
//  fb
//
//  Created by Shali Nguyen on 6/12/14.
//  Copyright (c) 2014 shali. All rights reserved.
//

#import "MainViewController.h"
#import "FeedViewController.h"
#import "SettingsViewController.h"

@interface MainViewController ()

@property (nonatomic, assign) BOOL loading;

@property (weak, nonatomic) IBOutlet UIView *signUpWrapper;
@property (weak, nonatomic) IBOutlet UIView *signUp;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *signUpLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loader;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


- (IBAction)onLoginBtn:(id)sender;
- (IBAction)onTapOut:(id)sender;
- (IBAction)loginValuesChanged:(id)sender;

- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.signUp.layer.cornerRadius = 3;
    
    [self.loginBtn setEnabled:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLoginBtn:(id)sender {
    
    if (self.loading) {
        [self.loader stopAnimating];
        self.loading = NO;
    } else {
        [self.loader startAnimating];
        self.loading = YES;
    }
    
    if ([self.passwordField.text isEqual: @"password"]) {
        UIViewController *vc = [[FeedViewController alloc] init];
        vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal; // Flip
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        UIAlertView *errorView = [[UIAlertView alloc]
                                  initWithTitle:@"Incorrect Password" message:@"The password you entered is incorrect. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [errorView show];
    }
}

- (IBAction)onTapOut:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)loginValuesChanged:(id)sender {
    if ([self.emailField.text length] && [self.passwordField.text length]) {
        [self.loginBtn setEnabled:YES];
    } else {
        [self.loginBtn setEnabled:NO];
    }
}



- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.signUpWrapper.frame = CGRectMake(self.signUpWrapper.frame.origin.x, self.signUpWrapper.frame.origin.y - 40, self.signUpWrapper.frame.size.width, self.signUpWrapper.frame.size.height);
                         self.signUpLabel.frame = CGRectMake(self.signUpLabel.frame.origin.x, self.signUpLabel.frame.origin.y - 130, self.signUpLabel.frame.size.width, self.signUpLabel.frame.size.height);
                     }
                     completion:nil];
}

- (void)willHideKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.signUpWrapper.frame = CGRectMake(self.signUpWrapper.frame.origin.x, self.signUpWrapper.frame.origin.y + 40, self.signUpWrapper.frame.size.width, self.signUpWrapper.frame.size.height);
                         self.signUpLabel.frame = CGRectMake(self.signUpLabel.frame.origin.x, self.signUpLabel.frame.origin.y + 130, self.signUpLabel.frame.size.width, self.signUpLabel.frame.size.height);
                     }
                     completion:nil];
}

@end
