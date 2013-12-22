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

#define kAlphaValue 40.0
#define MIN_t 0.0000001
#define MAX_t 2.0 * M_PI
#define SQRT_2 sqrt(2)
#define INCREMENT_t 0.001

#define OFFSET_X 100
#define OFFSET_Y 100


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


-(CGFloat)getX:(CGFloat)t {
    //     a * sqrt(2) * cos(t)
    // x = --------------------
    //         sin(t)^2 + 1
    float numerator = kAlphaValue * SQRT_2 * cosf(t);
    float denominator = powf(sinf(t), 2) + 1;
    return OFFSET_X + numerator / denominator;
}


-(CGFloat)getY:(CGFloat)t {
    //     a * sqrt(2) * cos(t)sin(t)
    // y = --------------------
    //         sin(t)^2 + 1
    float numerator = kAlphaValue * SQRT_2 * cosf(t) * sinf(t);
    float denominator = powf(sinf(t), 2) + 1;
    return OFFSET_Y + numerator / denominator;
}

-(void)make8track {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path setLineWidth:8.0];
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineJoinStyle:kCGLineJoinRound];
    
    [[UIColor redColor] setStroke];
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
    [path stroke];
    //    [path fill];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self make8track];
}

@end
