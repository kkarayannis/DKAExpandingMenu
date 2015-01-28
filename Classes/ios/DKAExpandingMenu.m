//
//  DKAExpandingMenu.m
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

#import "DKAExpandingMenu.h"
#import "TopBorder.h"
#import "BottomBorder.h"
#import "MiddleBorders.h"

@interface DKAExpandingMenu ()

@property (strong, nonatomic) MiddleBorders* middleBorders;
@property (nonatomic) BOOL expanded;

@end

@implementation DKAExpandingMenu

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self sharedInit];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self sharedInit];
    }
    return self;
}

-(void) sharedInit
{
    self.sendToBackOnContract = YES;
}

float MARGIN_PERC = 0.0;

-(void) setDirection:(DKAExpandingMenuDirection)direction{
    _direction = direction;
    
    self.transform = CGAffineTransformMakeRotation([self rotationRadians]);
    [self initializeButton];
}

-(UIView<DKABorderEnd>*) topBorder{
    if (!_topBorder){
        _topBorder = [[TopBorder alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width/2)];
        _topBorder.clipsToBounds = YES;
        [self addSubview:_topBorder];
    }
    return _topBorder;
}

-(UIView<DKABorderEnd>*) bottomBorder{
    if (!_bottomBorder){
        _bottomBorder = [[BottomBorder alloc] initWithFrame:CGRectMake(0, self.frame.size.height - self.frame.size.width/2, self.frame.size.width, self.frame.size.width/2)];
        _bottomBorder.clipsToBounds = YES;
        [self addSubview:_bottomBorder];
    }
    return _bottomBorder;
}

-(MiddleBorders*) middleBorders{
    if (!_middleBorders){
        _middleBorders = [[MiddleBorders alloc] initWithFrame:CGRectMake(0, self.frame.size.width/2, self.frame.size.width, 1)];
        _middleBorders.clipsToBounds = YES;
        [self addSubview:_middleBorders];
    }
    return _middleBorders;
}

-(void) setButtons:(NSArray *)buttons{
    // remove previous views, we recreate them all below
    [self.buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ( [obj isKindOfClass:[UIView class] ] )
        {
            UIView *buttonsView = obj;
            [buttonsView removeFromSuperview];
        }
    }];
    
    _buttons = buttons;
    
    CGFloat maxWidth = self.frame.size.width;
    for (int i = 0; i < [_buttons count]; i++){
        UIView* view = _buttons[i];
        view.frame = CGRectMake(maxWidth * MARGIN_PERC/2, maxWidth * i * 1.2, maxWidth * (1-MARGIN_PERC), maxWidth * (1 - MARGIN_PERC));
        view.hidden = YES;
        view.transform = CGAffineTransformMakeRotation([self counterRotationRadians]);
        [self addSubview:view];
    }
}

-(void) toggle{
    if (self.frame.size.width != self.frame.size.height){
        [self contract];
    }
    else{
        [self expand];
    }
}

-(void) setTintColor:(UIColor *)tintColor{
    [super setTintColor:tintColor];
    self.backgroundColor = [UIColor clearColor];
    for (UIView* view in @[self.topBorder, self.bottomBorder, self.middleBorders]){
        view.tintColor = self.tintColor;
        [view setNeedsDisplay];
    }
    for (UIView* view in self.buttons){
        view.tintColor = self.tintColor;
        [view setNeedsDisplay];
    }
}

- (void)setFillColor:(UIColor *)fillColor
{
    self.topBorder.fillColor = fillColor;
    self.middleBorders.fillColor = fillColor;
    self.bottomBorder.fillColor = fillColor;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.topBorder.borderColor = borderColor;
    self.middleBorders.borderColor = borderColor;
    self.bottomBorder.borderColor = borderColor;
}

-(void) expand{
    if (self.expanded){
        return;
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(expandingMenuShouldExpand:)]){
        if (![self.delegate expandingMenuShouldExpand:self])
        {
            return;
        }
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(expandingMenuWillExpand:)]){
        [self.delegate expandingMenuWillExpand:self];
    }
    originalFrame = self.frame;
    self.expanded = YES;
    
    float widthTimes = [self widthTimes];
    float animationTime = 0.15;
    
    [self adjustFrame];
    
    CGAffineTransform t = CGAffineTransformMakeTranslation(0, originalFrame.size.width * (widthTimes-1));
    [UIView animateWithDuration:animationTime animations:^{
        self.bottomBorder.transform = t;
    }];
    
    CGAffineTransform s = CGAffineTransformMakeScale(1, originalFrame.size.width * (widthTimes-1) + 1);
    CGAffineTransform offsetT = CGAffineTransformMakeTranslation(0, originalFrame.size.width * (widthTimes-1) / 2);
    [UIView animateWithDuration:animationTime animations:^{
        self.middleBorders.transform = CGAffineTransformConcat(s, offsetT);
        self.button.alpha = 0;
    } completion:^(BOOL fin){
        self.button.hidden = YES;
        for (UIView* view in self.buttons){
            view.alpha = 0;
            view.hidden = NO;
            [UIView animateWithDuration:0.15 animations:^{
                view.alpha = 1;
            } completion:^(BOOL fin){
            }];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(expandingMenuDidExpand:)]){
            [self.delegate expandingMenuDidExpand:self];
        }
    }];
}

-(void) contract{
    if (!self.expanded){
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(expandingMenuShouldContract:)]){
        if (![self.delegate expandingMenuShouldContract:self])
        {
            return;
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(expandingMenuWillContract:)]){
        [self.delegate expandingMenuWillContract:self];
    }
    self.expanded = NO;
    
    float animationTime = 0.15;
    
    [UIView animateWithDuration:animationTime animations:^{
        for (UIView* view in self.buttons){
            view.alpha = 0;
        }
    } completion:^(BOOL fin){
        self.button.hidden = NO;
        
        [UIView animateWithDuration:animationTime animations:^{
            self.button.alpha = 1;
            self.bottomBorder.transform = CGAffineTransformIdentity;
            self.middleBorders.transform = CGAffineTransformIdentity;
        } completion:^(BOOL fin){
            if (self.sendToBackOnContract)
            {
                [self.superview sendSubviewToBack:self];
            }
            self.frame = originalFrame;
            if (self.delegate && [self.delegate respondsToSelector:@selector(expandingMenuDidContract:)]){
                [self.delegate expandingMenuDidContract:self];
            }
        }];
    }];
}

-(void) adjustFrame{
    if (self.direction == DKAExpandingMenuDirectionLeft){
        self.frame = CGRectMake(self.frame.origin.x + self.frame.size.width, self.frame.origin.y, -self.frame.size.width * ([self widthTimes]), self.frame.size.width);
    }
    else if (self.direction == DKAExpandingMenuDirectionUp){
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.width, self.frame.size.width, -self.frame.size.width * ([self widthTimes]));
    }
    else if (self.direction == DKAExpandingMenuDirectionDown){
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.width * ([self widthTimes]));
    }
    else if (self.direction == DKAExpandingMenuDirectionRight){
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width * ([self widthTimes]), self.frame.size.width);
    }
}

CGRect originalFrame;

-(void) awakeFromNib{
    [self setTintColor:self.tintColor];
    self.direction = DKAExpandingMenuDirectionDown;
}

-(void) initializeButton{
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    self.button.transform = CGAffineTransformMakeRotation([self counterRotationRadians]);
    
    [self addSubview:self.button];
}

-(void) buttonAction{
    [self expand];
}

-(double) widthTimes{
    int buttons = (int)[self.buttons count];
    return buttons * 1.2 - 0.25;
}

-(CGFloat) rotationRadians{
    switch (self.direction) {
        case DKAExpandingMenuDirectionDown:
            return 0;
            break;
        case DKAExpandingMenuDirectionLeft:
            return M_PI_2;
            break;
        case DKAExpandingMenuDirectionUp:
            return M_PI;
            break;
        case DKAExpandingMenuDirectionRight:
            return -M_PI_2;
            break;
            
        default:
            break;
    }
    return 0;
}

-(CGFloat) counterRotationRadians{
    return -[self rotationRadians];
}


@end
