//
//  ARViewManager.m
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 11/14/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(ARViewManager, RCTViewManager)

RCT_EXTERN_METHOD(enterPlacementMode: (nonnull NSNumber *)node
                  count:(nonnull NSNumber *)count)
RCT_EXTERN_METHOD(adjustObject: (nonnull NSNumber *)node
                  buttonPressed:(nonnull NSString *)buttonPressed)

@end
