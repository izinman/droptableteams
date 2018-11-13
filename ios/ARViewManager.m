//
//  ARViewManager.m
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 11/12/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "FreeRealEstate-Swift.h"
#import <UIKit/UIKit.h>
#import <React/RCTUIManager.h>

@interface ARViewManager : RCTViewManager
@end

@implementation ARViewManager

RCT_EXPORT_MODULE()

- (ARView *)view {
  return [ARView new];
}

RCT_EXPORT_VIEW_PROPERTY(config, NSDictionary *)

@end
