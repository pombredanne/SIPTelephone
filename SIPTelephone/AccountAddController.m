//
//  AccountAddController.m
//  SIPTelephone
//
//  Copyright (c) 2011 Alexei Kuznetsov. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//  1. Redistributions of source code must retain the above copyright notice,
//     this list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//     this list of conditions and the following disclaimer in the documentation
//     and/or other materials provided with the distribution.
//  3. Neither the name of the copyright holder nor the names of contributors
//     may be used to endorse or promote products derived from this software
//     without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
//  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
//  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE THE COPYRIGHT HOLDER
//  OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
//  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
//  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
//  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
//  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
//  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "AccountAddController.h"


@implementation AccountAddController

@synthesize fullNameCell = fullNameCell_;
@synthesize domainCell = domainCell_;
@synthesize usernameCell = usernameCell_;
@synthesize passwordCell = passwordCell_;
@synthesize fullNameField = fullNameField_;
@synthesize domainField = domainField_;
@synthesize usernameField = usernameField_;
@synthesize passwordField = passwordField_;

- (id)init {
  self = [super initWithNibName:@"AccountAddController" bundle:nil];
  if (self != nil) {
    [self setTitle:NSLocalizedString(@"New SIP Account",
                                     @"New Account title.")];
  }
  return self;
}

- (id)initWithStyle:(UITableViewStyle)style {
  return [self init];
}

- (void)dealloc {
  [fullNameCell_ release];
  [domainCell_ release];
  [usernameCell_ release];
  [passwordCell_ release];
  [fullNameField_ release];
  [domainField_ release];
  [usernameField_ release];
  [passwordField_ release];
  
  [super dealloc];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIBarButtonItem *doneItem
    = [[[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                             target:self
                             action:@selector(addAccount)]
       autorelease];
  [[self navigationItem] setRightBarButtonItem:doneItem];
  
  UIBarButtonItem *cancelItem
    = [[[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                             target:self
                             action:@selector(cancelAccountAdd)]
       autorelease];
  [[self navigationItem] setLeftBarButtonItem:cancelItem];
}

- (void)viewDidUnload {
  [super viewDidUnload];
  
  [self setFullNameCell:nil];
  [self setDomainCell:nil];
  [self setUsernameCell:nil];
  [self setPasswordCell:nil];
  [self setFullNameField:nil];
  [self setDomainField:nil];
  [self setUsernameField:nil];
  [self setPasswordField:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)addAccount {
  [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)cancelAccountAdd {
  [[self parentViewController] dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  
  return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell = nil;
  
  switch ([indexPath row]) {
    case 0:
      cell = [self fullNameCell];
      break;
    case 1:
      cell = [self domainCell];
      break;
    case 2:
      cell = [self usernameCell];
      break;
    case 3:
      cell = [self passwordCell];
      break;
    default:
      break;
  }
  
  return cell;
}


#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if ([textField isEqual:[self fullNameField]]) {
    [[self domainField] becomeFirstResponder];
  } else if ([textField isEqual:[self domainField]]) {
    [[self usernameField] becomeFirstResponder];
  } else if ([textField isEqual:[self usernameField]]) {
    [[self passwordField] becomeFirstResponder];
  } else if ([textField isEqual:[self passwordField]]) {
    if ([[[self fullNameField] text] length] > 0 &&
        [[[self domainField] text] length] > 0 &&
        [[[self usernameField] text] length] > 0 &&
        [[[self passwordField] text] length] > 0) {
      [self addAccount];
    }
  }
  
  return YES;
}

@end

