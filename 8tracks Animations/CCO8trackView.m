//
//  CCO8trackView.m
//  8tracks Animations
//
//  Created by Chris O'Neil on 12/21/13.
//  Copyright (c) 2013 Chris O'Neil. All rights reserved.
//

#import "CCO8trackView.h"

@implementation CCO8trackView
@synthesize numRepeats, duration, graphColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaults];
        [self setPropertiesForFrame:frame];
    }
    return self;
}


// sets all of the defaults for the customizable paramaters
-(void)setDefaults {
    numRepeats = 0;
    duration = 2.5;
    graphColor = [UIColor paleWhite];
}

// Sets some of the properties that allow the 8tracks logo to scale
// proportionally.  The values .63 and .25 came from some logic
// as well as trial and error.
-(void)setPropertiesForFrame:(CGRect)frame {
    offset = frame.size.width / 2;
    a = offset * .63;
    lineWidth = .25 * a;
    padding = lineWidth / M_PI / (offset / 4);
}


// Returns false if the point falls under part of the logo that
// should not be drawn (the very start and the very finish)
-(BOOL)shouldAdd:(CGPoint)point {
    float paddingMinus = padding - lineWidth;
    if (point.x > paddingMinus && point.x < padding) {
//        if (point.y > paddingMinus && point.y < padding) {
//            NSLog(@"Not adding point x: %f, y: %f", point.x, point.y);
//            return NO;
//        }
    }
    return YES;
}


// Create the graph.
-(NSArray *)lemniscate {
    NSUInteger capacity = ceil(2 * M_PI / INCREMENT_t + 1);
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:capacity];
    
    // start in the middle
    CGFloat t = START_t + padding;
    while (t < MAX_t) {
        CGPoint point = CGPointMake([self getX:t], [self getY:t]);
        [values addObject:[NSValue valueWithCGPoint:point]];
        t += INCREMENT_t;
    }
    
    // finish the drawing
    t = 0.0;
    while (t < START_t - padding) {
        CGPoint point = CGPointMake([self getX:t], [self getY:t]);
        [values addObject:[NSValue valueWithCGPoint:point]];
        t += INCREMENT_t;
    }
    
    return values;
}


// This function get's the Cartesian 'x' value of the graph at angle t
// in radians.  It returns x as a CGFloat
-(CGFloat)getX:(CGFloat)t {
    //     a * sqrt(2) * cos(t)
    // x = --------------------
    //         sin(t)^2 + 1
    float numerator = a * sqrtf(1.6) * cosf(t);
    float denominator = powf(sinf(t), 2) + 1;
    
    float x = numerator / denominator;
    return x + offset;
}


// This function get's the Cartesian 'y' value of the graph at angle t
// in radians.  It returns y as a CGFloat
-(CGFloat)getY:(CGFloat)t {
    //     a * sqrt(2) * cos(t)sin(t)
    // y = --------------------
    //         sin(t)^2 + 1
    float numerator = a * sqrtf(2.2) * cosf(t) * sinf(t);
    float denominator = powf(sinf(t), 2) + 1;
    
    float y = numerator / denominator;
    return y + offset;
}


// Creates a UIBezierPath along the graph of the 8tracks logo
// and returns it.  This function does NOT draw a graph.
-(UIBezierPath *)get8trackPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    path.lineWidth = lineWidth;
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineJoinStyle:kCGLineJoinRound];
    
    [graphColor setStroke];
    [[UIColor clearColor] setFill];
    
    NSArray *values = [self lemniscate];
    
    // start at our initial point.
    CGPoint p1 = [[values objectAtIndex:0] CGPointValue];
    [path moveToPoint:p1];
    
    for (int i = 1; i < values.count; i++) {
        
        CGPoint p2 = [[values objectAtIndex:i] CGPointValue];
        CGPoint centerPoint = CGPointMake((p1.x+p2.x)/2, (p1.y+p2.y)/2);
        
        if (p1.y < p2.y) {
            centerPoint = CGPointMake(centerPoint.x, centerPoint.y+(abs(p2.y-centerPoint.y)));
        } else if(p1.y > p2.y){
            centerPoint = CGPointMake(centerPoint.x, centerPoint.y-(abs(p2.y-centerPoint.y)));
        }
        
        [path addQuadCurveToPoint:p2 controlPoint:centerPoint];
        p1 = p2; // make the new point equal to the previous point.
    }
    
    // draw the graph.
//    [path closePath];
    return path;
}


// Creates a CAShapeLayer that is the contains the 8tracks logo.
-(CAShapeLayer *)get8tracksLayer {
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.opaque = NO;
    [shapeLayer setFrame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [shapeLayer setPath: [[self get8trackPath] CGPath]];
    [shapeLayer setMasksToBounds:YES];
    
    float angle = M_PI / 4;
    shapeLayer.transform = CATransform3DMakeRotation (angle, 0, 0, -1);
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    shapeLayer.strokeColor = graphColor.CGColor;
    shapeLayer.lineWidth = lineWidth;

    return shapeLayer;
}


// Adds the 8tracks logo as a sublayer to the view and animates it
// repeating based on the numRepeats
-(void)animate {
    CAShapeLayer *shapeLayer = [self get8tracksLayer];
    [self.layer addSublayer:shapeLayer];
    
    // animate path
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = duration;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.repeatCount = numRepeats;
    pathAnimation.autoreverses = NO;
    [shapeLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}


@end
