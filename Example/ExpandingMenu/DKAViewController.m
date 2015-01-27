//
//  DKAViewController.m
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

#import "DKAViewController.h"


@interface DKAViewController () <DKAExpandingMenuDelegate>

@property (weak, nonatomic) IBOutlet DKAExpandingMenu *expandingMenu;

@end

@implementation DKAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.expandingMenu.topBorder.type = DKABorderEndTypeCircle;
    self.expandingMenu.direction = self.direction;
    
    [self.expandingMenu.button setTitle:@"OK" forState:UIControlStateNormal];
    [self.expandingMenu.button setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    
    // Initialize sample buttons to put in our expanding menu
    UIButton* button1 = [[UIButton alloc] init];
    [button1 setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [button1 setTitle:@"1" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* button2 = [[UIButton alloc] init];
    [button2 setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [button2 setTitle:@"2" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(button2Action) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* button3 = [[UIButton alloc] init];
    [button3 setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [button3 setTitle:@"3" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(button3Action) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* button4 = [[UIButton alloc] init];
    [button4 setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [button4 setTitle:@"4" forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(button4Action) forControlEvents:UIControlEventTouchUpInside];
    
    self.expandingMenu.buttons = @[button1, button2, button3, button4];
    self.expandingMenu.delegate = self;
}

-(void) button1Action{
    NSLog(@"1");
}

-(void) button2Action{
    NSLog(@"2");
}

-(void) button3Action{
    NSLog(@"3");
}

-(void) button4Action{
    NSLog(@"4");
}

-(BOOL) expandingMenuShouldExpand:(DKAExpandingMenu *)expandingMenu {
    NSLog(@"Should Expand");
    return YES;
}

-(void) expandingMenuWillExpand:(DKAExpandingMenu *)expandingMenu{
    NSLog(@"Will Expand");
}

-(void) expandingMenuDidExpand:(DKAExpandingMenu *)expandingMenu{
    NSLog(@"Did Expand");
}

-(BOOL) expandingMenuShouldContract:(DKAExpandingMenu *)expandingMenu {
    NSLog(@"Should Contract");
    return YES;
}

-(void) expandingMenuWillContract:(DKAExpandingMenu *)expandingMenu{
    NSLog(@"Will Contract");
}

-(void) expandingMenuDidContract:(DKAExpandingMenu *)expandingMenu{
    NSLog(@"Did Contract");
}

- (IBAction)tapOnWhitespaceAction:(UITapGestureRecognizer *)sender {
    [self.expandingMenu contract];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
