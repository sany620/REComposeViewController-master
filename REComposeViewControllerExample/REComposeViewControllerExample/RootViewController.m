//
//  RootViewController.m
//  REComposeViewControllerExample
//
//  Created by Roman Efimov on 10/19/12.
//  Copyright (c) 2012 Roman Efimov. All rights reserved.
//

#import "RootViewController.h"
#import "REComposeViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
    
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    
    
    UIButton *tumblrExampleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    tumblrExampleButton.frame = CGRectMake(60, 60, 200, 40);
    [tumblrExampleButton addTarget:self action:@selector(tumblrExampleButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [tumblrExampleButton setTitle:@"Tumblr" forState:UIControlStateNormal];
    [self.view addSubview:tumblrExampleButton];
    
}

#pragma mark -
#pragma mark Button actions

- (void)tumblrExampleButtonPressed
{
    REComposeViewController *composeViewController = [[REComposeViewController alloc] init];
    composeViewController.title = @"Tumblr";
    composeViewController.hasAttachment = YES;
    composeViewController.attachmentImage = [UIImage imageNamed:@"Flower.jpg"];
    composeViewController.delegate = self;
    [self presentViewController:composeViewController animated:YES completion:nil];
    [composeViewController release];
}

#pragma mark -
#pragma mark Orientation

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return YES;
}

#pragma mark -
#pragma mark REComposeViewControllerDelegate

- (void)composeViewController:(REComposeViewController *)composeViewController didFinishWithResult:(REComposeResult)result
{
    if (result == REComposeResultCancelled) {
        NSLog(@"Cancelled");
    }
    
    if (result == REComposeResultPosted) {
        NSLog(@"Text = %@", composeViewController.text);
    }
}

@end
