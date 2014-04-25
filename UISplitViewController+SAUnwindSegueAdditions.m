//
//  UISplitViewController+SAUnwindSegueAdditions.m
//
//  Created by Shawn Allen on 4/25/14.
//

#import "UISplitViewController+SAUnwindSegueAdditions.h"

@implementation UISplitViewController (SAUnwindSegueAdditions)

- (UIViewController *)viewControllerForUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender;
{
    UIViewController *returnValue = [super viewControllerForUnwindSegueAction:action fromViewController:fromViewController withSender:sender];
    
    if (returnValue != nil) {
        return returnValue;
    }
    
    for (UIViewController *childViewController in [self viewControllers]) {
        if ([[fromViewController presentingViewController] isEqual:childViewController]) {
            continue;
        }
        
        if ([[fromViewController parentViewController] isEqual:childViewController]) {
            continue;
        }
        
        returnValue = [childViewController viewControllerForUnwindSegueAction:action fromViewController:fromViewController withSender:sender];
        
        if (returnValue != nil) {
            return returnValue;
        }
    }
    
    return nil;
}

- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier;
{
    if ([toViewController respondsToSelector:@selector(segueForUnwindingToViewController:fromViewController:identifier:)]) {
        return [toViewController segueForUnwindingToViewController:toViewController fromViewController:fromViewController identifier:identifier];
    }
    
    return [super segueForUnwindingToViewController:toViewController fromViewController:fromViewController identifier:identifier];
}

@end
