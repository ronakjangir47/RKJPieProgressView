//
//  RKJPieProgressView.m
//  PieProgressBar
//
//  Created by Ronak Jangir on 26/11/13.
//  Copyright (c) 2013 Ronak. All rights reserved.
//

#import "RKJPieProgressView.h"

typedef NS_OPTIONS(NSUInteger, RKJAnimationDirection) {
	RKJAnimationDirectionClockWise,
	RKJAnimationDirectionAntiClockWise
};

@interface RKJPieProgressView ()
@property (nonatomic, assign) float value;
@property (nonatomic, assign) float targetValue;
@property (nonatomic, strong) NSTimer *animationTimer;
@property (nonatomic, strong) CAShapeLayer *strokeCircle;
@end

@implementation RKJPieProgressView

#define RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.value = 0.0;
        [self drawPieCircle];
    }
    return self;
}

- (void) drawPieCircle {
    int radius = self.frame.size.width/2 - 20;
    self.strokeCircle = [CAShapeLayer layer];
    self.strokeCircle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                             cornerRadius:radius].CGPath;
    self.strokeCircle.position = CGPointMake(self.frame.origin.x,
                                  self.frame.origin.y);
    self.strokeCircle.fillColor = [UIColor whiteColor].CGColor;
    self.strokeCircle.strokeColor = RGBA(0, 122, 255, 1).CGColor;
    self.strokeCircle.lineWidth = 20;
    self.strokeCircle.strokeEnd = 0;
    [self.layer addSublayer:self.strokeCircle];

    CAShapeLayer *borderCircle = [CAShapeLayer layer];
    borderCircle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius + 20, 2.0*radius + 20)
                                             cornerRadius:radius - 20].CGPath;
    borderCircle.position = CGPointMake(self.frame.origin.x - 10,
                                        self.frame.origin.y - 10);
    borderCircle.fillColor = [UIColor clearColor].CGColor;
    borderCircle.strokeColor = RGBA(0, 122, 255, 1).CGColor;
    borderCircle.lineWidth = 0.5;
    [self.layer addSublayer:borderCircle];
}

- (void) progressToValue:(float)newValue duration:(CGFloat)duration {
    self.targetValue = [self validValueFromValue:newValue];
    RKJAnimationDirection direction = RKJAnimationDirectionClockWise;
	if (self.targetValue < self.value) {
        direction = RKJAnimationDirectionAntiClockWise;
	}

    [self animateInDirection:direction timeInterval:duration];
}

- (void) animateInDirection:(CGFloat)duration
               timeInterval:(NSTimeInterval)timeInterval {
    self.animationTimer = [NSTimer timerWithTimeInterval:timeInterval/10000
                                                  target:self
                                                selector:@selector(handleTimer:)
                                                userInfo:nil
                                                 repeats:YES];
    [self.animationTimer fire]; // fire instantly for first change
    [[NSRunLoop currentRunLoop] addTimer:self.animationTimer forMode:NSRunLoopCommonModes];
}

- (void)handleTimer:(NSTimer*)timer {
    if (self.strokeCircle.strokeEnd > 1) {
        [self stopAnimation];
    }
    self.strokeCircle.strokeEnd = self.strokeCircle.strokeEnd + 0.0005;
}

- (float)validValueFromValue:(float)value {
    float validValue = 0;
    if (value < 0) {
        validValue = 0;
    } else if (value > 1) {
        validValue = 1;
    }
    return validValue;
}

- (void)stopAnimation {
    [self.animationTimer invalidate];
    self.animationTimer = nil;
    if ([self.delegate respondsToSelector: @selector(didFinishAnimation:)]) {
        [self.delegate didFinishAnimation:self];
    }
}


@end
