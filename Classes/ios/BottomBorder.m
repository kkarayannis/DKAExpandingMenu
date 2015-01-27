//
//  BottomBorder.m
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


#import "BottomBorder.h"

@interface BottomBorder ()

@property (strong, nonatomic) UIBezierPath* path;

@end

@implementation BottomBorder

@synthesize type = _type;
@synthesize borderColor = _borderColor;
@synthesize fillColor = _fillColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
        self.type = DKABorderEndTypeCircle;
        self.fillColor = [UIColor whiteColor];
        self.borderColor = self.tintColor;
    }
    return self;
}

-(void) setType:(DKABorderEndType) type{
    _type = type;
    [self updatePath];
}

-(void) updatePath{
    switch (self.type) {
        case DKABorderEndTypeCircle:
            self.path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(1, -self.frame.size.width/2, self.frame.size.width-2, self.frame.size.width-1)];
            break;
        case DKABorderEndTypeSquare:
            self.path =[UIBezierPath bezierPathWithRect: CGRectMake(1, -self.frame.size.width/2, self.frame.size.width-2, self.frame.size.width-1)];
            break;
            
        default:
            break;
    }
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
}

- (void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
}

 - (void)drawRect:(CGRect)rect
{
    [self.fillColor setFill];
    [self.path fill];
    [self.borderColor setStroke];
    self.path.lineWidth = 1;
    [self.path stroke];
}

@end
