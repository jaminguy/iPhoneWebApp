//
//  iPhoneWebAppViewController.m
//  iPhoneWebApp
//
//  Created by Jamin Guy on 9/10/10.
//
//	Copyright (c) 2010 Inphoenixity LLC
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.

#import "iPhoneWebAppViewController.h"
#import "LinkViewController.h"

@interface iPhoneWebAppViewController () 

- (void)loadRoot;

@end


@implementation iPhoneWebAppViewController

#define kRootURL @"http://stationfinder.griffintechnology.com"

@synthesize webView;
@synthesize activityIndicator;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.webView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
	self.webView.delegate = self;
	[self loadRoot];
}

- (void)loadRoot {
	NSURL *url = [NSURL URLWithString:kRootURL];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[self.webView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[self.activityIndicator stopAnimating];
}

- (void)reload {
	self.activityIndicator.hidden = NO;
	[self.activityIndicator startAnimating];
	[self.webView reload];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		LinkViewController *linkViewController = [[LinkViewController alloc] initWithNibName:@"LinkViewController" bundle:nil];
		[self presentModalViewController:linkViewController animated:YES];
		[linkViewController loadRequest:request];
		[linkViewController release];
		return NO;
	}
	
	return YES;
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];	
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.webView = nil;
	self.activityIndicator = nil;
}

- (void)dealloc {
	[webView release];
	[activityIndicator release];
    [super dealloc];
}

@end
