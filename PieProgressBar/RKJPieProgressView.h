//
//  RKJPieProgressView.h
//  PieProgressBar
//
//  Created by Ronak Jangir on 26/11/13.
//  Copyright (c) 2013 Ronak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKJPieProgressView : UIView

@property(nonatomic,assign) id delegate;

- (void) progressToValue:(float)newValue duration:(CGFloat)duration;

@end

@protocol RKJPieProgressViewDelegate <NSObject>
- (void) didFinishAnimation:(RKJPieProgressView *)progressView;
@end