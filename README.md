storyboard-additions
====================

## Description 

Supplemental classes to make using iOS Storyboards even easier.  

While dabbling in the use of Storyboards, I found a few rough edges.  When projects became large, or I found that view controllers (UISplitViewController) didn’t support the behavior that I was expecting (unwind segue participation across all child view controllers), I threw together some classes to scratch my itch.

### UIViewController+SASegueAdditions

This class provides the capability to eliminate the construction (and maintenance) of ```-prepareForSegue:sender:```.  I hated maintaining this method, so I put this category together. 

Now, you can just create segues in your storyboard, then go to your view controller and add a new action method in support of that segue.  For instance, you add to your storyboard a segue with the identifier of “pushDetail”.  In your view controller implementation, you may now add a new method with the selector of ```-pushDetail:sender:```.  No need to add any headers, protocols, subclass anything specific, or even implement prepareForSegue at all.  If you do have an implementation of ```prepareForSegue``` and you would like to extend it to include the invocation of these new action methods, just add the category header along with a message to ```-sa_prepareForSegue:sender:```.

Originally, I was swizzling ```-[UIViewController prepareForSegue:sender]```, but I moved away from that.  The current approach just transparently masks it in the base case and made the approach both simpler and less brittle; affording for common code to exist in the case of segues with empty identifiers, or even common bootstrapping code for all segues’ action methods. 

### UISplitViewController+SAUnwindSegueAdditions

This category makes it possible for Storyboards which have UISplitViewControllers to have all their child view controllers contribute (and participate) to an unwind segue.  Currently (iOS 7.1 and earlier), only the immediate controller hierarchy participates in unwind segues.  That is to say, that if you manually perform a unwind segue in the stack of master view controllers, none of the detail view controllers are examined for prospective interest in handling the unwind.  

This comes to bear if you’d like have some sub-master in the master side, and you would like for its cooperating detail view controller pop it self off of the detail stack as it leaves. I didn’t want to create a tight coupling or a protocol, I wanted to use an unwind segue for what I believe it is for.

To use: add the category to the your project, and on either side of a split view controller hierarchy, add a unwind segue to your project.  When you manually perform the segue, no matter where it occurs in the hierarchy, it will just participate.  If you find yourself wanting the navigation view controller of an opposing side (master<->detail) to do “the right thing”, this category supports the provision to use a custom container view controller’s ```- segueForUnwindingToViewController:toViewController:fromViewController:identifier:``` to do something that isn’t intrinsically supported.

## Addendum

A few things could to be done to improve the performance of the construction of (or bypass) the segue identifier selectors.  This is a fairly straightforward enhancement.

Also, I made no affordance for segues which do not directly map into an Objective-C method identifier.  Along with that, segues/methods with underscores in them ```do_someAction``` are also not supported, but that is an easy fix.

## License

The source code is distributed under the [MIT License](http://opensource.org/licenses/mit-license.php).
