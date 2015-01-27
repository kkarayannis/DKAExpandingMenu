//
//  DKAExpandingMenu.h
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

#import <UIKit/UIKit.h>
#import "DKABorderEnd.h"

typedef NS_ENUM(NSInteger, DKAExpandingMenuDirection){
    DKAExpandingMenuDirectionUp,
    DKAExpandingMenuDirectionRight,
    DKAExpandingMenuDirectionDown,
    DKAExpandingMenuDirectionLeft
};

#ifndef IBInspectable // prevent compile issues with older SDKS
#define IBInspectable
#endif

@protocol DKAExpandingMenuDelegate;

@interface DKAExpandingMenu : UIView

@property (weak, nonatomic) id <DKAExpandingMenuDelegate> delegate;
@property (strong, nonatomic) NSArray* buttons;
@property (nonatomic, readonly) BOOL expanded;
@property (nonatomic) DKAExpandingMenuDirection direction;
@property (strong, nonatomic) UIView<DKABorderEnd>* topBorder;
@property (strong, nonatomic) UIView<DKABorderEnd>* bottomBorder;
@property (strong, nonatomic) UIButton* button;
@property (readwrite) IBInspectable BOOL sendToBackOnContract;

-(void) expand;
-(void) contract;
-(void) toggle;

@end

@protocol DKAExpandingMenuDelegate <NSObject>

@optional
-(void) expandingMenuWillExpand:(DKAExpandingMenu *)expandingMenu;
-(void) expandingMenuDidExpand:(DKAExpandingMenu *)expandingMenu;
-(void) expandingMenuWillContract:(DKAExpandingMenu *)expandingMenu;
-(void) expandingMenuDidContract:(DKAExpandingMenu *)expandingMenu;

@end