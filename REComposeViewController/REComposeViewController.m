//
// REComposeViewController.m
// REComposeViewController
//
// Copyright (c) 2012 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "REComposeViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface REComposeViewController ()

@end

@implementation REComposeViewController
@synthesize completionHandler=_completionHandler,delegate=_delegate,cornerRadius = _cornerRadius,navigationBar;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _cornerRadius = 10;
        _sheetView = [[REComposeSheetView alloc] initWithFrame:CGRectMake(0, 0, self.currentWidth - 8, 202)];
    }
    return self;
}

- (int)currentWidth
{
    UIScreen *screen = [UIScreen mainScreen];
    return (!UIDeviceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) ? screen.bounds.size.width : screen.bounds.size.height;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    navigationBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    UINavigationItem *navBar = [[UINavigationItem alloc]initWithTitle:@"分享"];
    
	UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]
                                initWithTitle:@"返回"
                                style:UIBarButtonItemStylePlain
                                target:nil
                                action:@selector(back:)] ;
    
    UIBarButtonItem *shareBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStyleBordered target:self action:@selector(shareBtnItemClicked:)];
    [navigationBar pushNavigationItem:navBar animated:NO];
    
    [navBar setLeftBarButtonItem:backBtn];
    [navBar setRightBarButtonItem:shareBtnItem];
    //把导航栏添加到视图中
    [self.view addSubview:navigationBar];
    
    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44)];
    _containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _backView = [[UIView alloc] initWithFrame:CGRectMake(4, 0, self.currentWidth - 8, 180)];
    _containerView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = _cornerRadius;
    _backView.layer.shadowOpacity = 0.7;
    _backView.layer.shadowColor = [UIColor blackColor].CGColor;
    _backView.layer.shadowOffset = CGSizeMake(3, 5);
    _backView.backgroundColor = [UIColor yellowColor];
    
    _sheetView.frame = _backView.bounds;
    _sheetView.layer.cornerRadius = _cornerRadius;
    _sheetView.clipsToBounds = YES;
    
//    _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(245, 180, 64, 21)];
//    _stateLabel.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_containerView];
    [_containerView addSubview:_backView];
    [_containerView addSubview:_stateLabel];
    [_backView  addSubview:_sheetView];
    
    _paperclipView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 77, 70, 79, 34)];//别针
    _paperclipView.image = [UIImage imageNamed:@"REComposeViewController.bundle/PaperClip"];
    [_containerView addSubview:_paperclipView];
    //[_paperclipView setHidden:YES];

    
    if (!_attachmentImage)
        _attachmentImage = [UIImage imageNamed:@"REComposeViewController.bundle/URLAttachment"];
    
    _sheetView.attachmentImageView.image = _attachmentImage;
}
- (void)back:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_sheetView.textView becomeFirstResponder];
    
}

- (void)layoutWithOrientation:(UIInterfaceOrientation)interfaceOrientation width:(NSInteger)width height:(NSInteger)height
{
        
    CGRect textViewFrame = _sheetView.textView.frame;
    textViewFrame.size.width = !_hasAttachment ? _sheetView.frame.size.width : _sheetView.frame.size.width - 84;
    _sheetView.textView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0f, 44.0f, 0.0f, _hasAttachment ? -85 : 0);
    textViewFrame.size.height = _sheetView.frame.size.height - self.navigationBar.frame.size.height - 3;
    _sheetView.textView.frame = textViewFrame;
    
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    [_sheetView.textView resignFirstResponder];
}


- (UIImage *)attachmentImage
{
    return _attachmentImage;
}

- (void)setAttachmentImage:(UIImage *)attachmentImage
{
    _attachmentImage = attachmentImage;
    _sheetView.attachmentImageView.image = _attachmentImage;
}

- (BOOL)hasAttachment
{
    return _hasAttachment;
}

- (void)setHasAttachment:(BOOL)hasAttachment
{
    _hasAttachment = hasAttachment;
}

- (NSString *)text
{
    return _sheetView.textView.text;
}

- (void)setText:(NSString *)text
{
    _sheetView.textView.text = text;
}

#pragma mark -
#pragma mark REComposeSheetViewDelegate

- (void)cancelButtonPressed
{
    if (_delegate && [_delegate respondsToSelector:@selector(composeViewController:didFinishWithResult:)]) {
        [_delegate composeViewController:self didFinishWithResult:REComposeResultCancelled];
    }
    if (_completionHandler) {
        _completionHandler(REComposeResultCancelled);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)postButtonPressed
{
    if (_delegate && [_delegate respondsToSelector:@selector(composeViewController:didFinishWithResult:)]) {
        [_delegate composeViewController:self didFinishWithResult:REComposeResultPosted];
    }
    if (_completionHandler) {
        _completionHandler(REComposeResultPosted);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    [self layoutWithOrientation:interfaceOrientation width:self.view.frame.size.width height:self.view.frame.size.height];
}

@end
