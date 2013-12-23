//
//  Constants.h
//  8tracks Animations
//
//  Created by Chris O'Neil on 12/22/13.
//  Copyright (c) 2013 Chris O'Neil. All rights reserved.
//

#ifndef _tracks_Animations_Constants_h
#define _tracks_Animations_Constants_h

//********************************************************************//
//    UIView Frames //
//********************************************************************//
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kStatusBarHeight 20.0
#define kTableViewCellHeight 60.0

//********************************************************************//
//    8tracks Graph Params //
//********************************************************************//
#define MIN_t 0.0000001
#define START_t 3 * M_PI_2
#define MAX_t 2.0 * M_PI
#define INCREMENT_t 0.01

#define kRefreshControlStandardHeight 84.0f
#define kRefreshControlFullHeight 500.0f
#define kRefreshControlHalfHeight (kRefreshControlStandardHeight / 2.0f)
#define kRefreshLogoSize 64.0
#define ARC4RANDOM_MAX 0x100000000

#endif
