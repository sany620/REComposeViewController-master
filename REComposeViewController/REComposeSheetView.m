//
// REComposeSheetView.m
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

#import "REComposeSheetView.h"
#import <QuartzCore/QuartzCore.h>

@implementation REComposeSheetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _textViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 44)];
        _textViewContainer.clipsToBounds = YES;
        _textViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _textView = [[DEComposeTextView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 47)];//文本View
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.font = [UIFont systemFontOfSize:17];
        _textView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
        _textView.bounces = YES;
        
        [_textViewContainer addSubview:_textView];
        [self addSubview:_textViewContainer];
        
        _attachmentView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - 84, 54, 84, 79)];
        [self addSubview:_attachmentView];//别针上的图片
        
        _attachmentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 2, 72, 72)];
        _attachmentImageView.layer.cornerRadius = 3.0f;
        _attachmentImageView.layer.masksToBounds = YES;
        [_attachmentView addSubview:_attachmentImageView];
        
        _attachmentContainerView = [[UIImageView alloc] initWithFrame:_attachmentView.bounds];
        _attachmentContainerView.image = [UIImage imageNamed:@"REComposeViewController.bundle/AttachmentFrame"];
        [_attachmentView addSubview:_attachmentContainerView];
        //_attachmentView.hidden = YES;
    }
    return self;
}


@end
