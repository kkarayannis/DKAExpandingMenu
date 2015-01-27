//
//  MiddleBorders.m
//  DKAExpandingMenu
//
//  Copyright (c) 2014 Konstadinos Karayannis.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//


#import "MiddleBorders.h"

@implementation MiddleBorders

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        self.borderColor = self.tintColor;
        self.fillColor = [UIColor whiteColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0.5, 0, self.frame.size.width-1, self.frame.size.height)];
    [self.fillColor setFill];
    [rectanglePath fill];
    [[UIColor clearColor] setStroke];
    rectanglePath.lineWidth = 1;
    [rectanglePath stroke];
 
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(1, 0)];
    [bezierPath addLineToPoint: CGPointMake(1, self.frame.size.height)];
    [self.borderColor setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    
    UIBezierPath* bezierPath2 = [UIBezierPath bezierPath];
    [bezierPath2 moveToPoint: CGPointMake(self.frame.size.width-1, 0)];
    [bezierPath2 addLineToPoint: CGPointMake(self.frame.size.width-1, self.frame.size.height)];
    [self.borderColor setStroke];
    bezierPath2.lineWidth = 1;
    [bezierPath2 stroke];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = rectanglePath.CGPath;
    [self.layer setMask:shapeLayer];
}


@end
