//
//  CCO8trackView.m
//  8tracks Animations
//
//  Created by Chris O'Neil on 12/21/13.
//  Copyright (c) 2013 Chris O'Neil. All rights reserved.
//

#import "CCO8trackView.h"

@implementation CCO8trackView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#define kAlphaValue 63.0
#define MIN_t 0.0000001
#define MAX_t 2.0 * M_PI
#define SQRT_2 sqrt(2)
#define INCREMENT_t 0.01
#define SKEW_Y .05
#define OFFSET 100
#define Y_MIN 10
#define Y_MIN_NEG -10

#define X_MIN 10
#define X_MIN_NEG -10


-(NSArray *)lemniscate {
    
    NSMutableArray *values = [NSMutableArray array];
    CGFloat t = MIN_t;
    while (t < MAX_t) {
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
    float numerator = kAlphaValue * sqrtf(1.6) * cosf(t);
    float denominator = powf(sinf(t), 2) + 1;
    
    float x = numerator / denominator;
    return x + OFFSET;
}


// This function get's the Cartesian 'y' value of the graph at angle t
// in radians.  It returns y as a CGFloat
-(CGFloat)getY:(CGFloat)t {
    //     a * sqrt(2) * cos(t)sin(t)
    // y = --------------------
    //         sin(t)^2 + 1
    float numerator = kAlphaValue * sqrtf(2.2) * cosf(t) * sinf(t);
    float denominator = powf(sinf(t), 2) + 1;
    
    float y = numerator / denominator;
    return y + OFFSET;
}


#define kLineWidth 15.0
-(UIBezierPath *)get8trackPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    path.lineWidth = kLineWidth;
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineJoinStyle:kCGLineJoinRound];
    
    [[UIColor redColor] setStroke];
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
    [path closePath];
    return path;
}


-(CAShapeLayer *)get8tracksLayer {
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.opaque = NO;
    [shapeLayer setFrame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [shapeLayer setPath: [[self get8trackPath] CGPath]];
    [shapeLayer setMasksToBounds:YES];
    
    float angle = M_PI / 4;
    shapeLayer.transform = CATransform3DMakeRotation (angle, 0, 0, -1);
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    shapeLayer.strokeColor = [[UIColor redColor] CGColor];
    shapeLayer.lineWidth = kLineWidth;

    return shapeLayer;
}


-(void)go {
    CAShapeLayer *shapeLayer = [self get8tracksLayer];
    [self.layer addSublayer:shapeLayer];
    
    // animate path
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 2.5f;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.repeatCount = 0;
    pathAnimation.autoreverses = NO;
    [shapeLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    [self make8track];
//}

@end
