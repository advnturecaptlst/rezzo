//
//  SplashScreenController.m
//  Rezzo
//
//  Created by Rego on 6/11/13.
//  Copyright (c) 2013 Regaip Sen. All rights reserved.
//

#import "SplashScreenController.h"

@interface SplashScreenController()

@property (strong, nonatomic) UIImageView *imageView;

@end


@implementation SplashScreenController


- (UIImageView *)imageView
{
    if (!_imageView) _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    return _imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize screenSize = self.view.bounds.size;
    NSString* fileName = @"first-launch-screen";
    
    if (screenSize.height <= 480) // 3.5-inch screen
    {
        fileName = [NSString stringWithFormat:@"%@-960", fileName];
    }
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        fileName = [NSString stringWithFormat:@"%@-ipad", fileName];
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
    self.imageView.image = [UIImage imageWithContentsOfFile:path];

    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        // HACK: (0,0) includes top status bar for iOS 7
        self.imageView.frame = CGRectMake(0, 20, screenSize.width, screenSize.height-20);
    }
    else
    {
        self.imageView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    }
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.imageView];

    UITapGestureRecognizer *singleTapRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    singleTapRecognize.numberOfTapsRequired = 1;
    singleTapRecognize.numberOfTouchesRequired = 1;
    
    [self.view addGestureRecognizer:singleTapRecognize];
    [self.view setUserInteractionEnabled:YES];
}

- (void)tapped:(UIGestureRecognizer*)gesture
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
