//
//  ARViewManager.m
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 11/14/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>
#import "React/RCTEventEmitter.h"

@interface RCT_EXTERN_MODULE(ARViewManager, RCTViewManager)

RCT_EXTERN_METHOD(placeObject: (nonnull NSNumber *)node)

RCT_EXTERN_METHOD(setObjectToPlace: (nonnull NSNumber *)node
                  objectName:(nonnull NSString *)objectName)

RCT_EXTERN_METHOD(enableAdjustMode: (nonnull NSNumber *)node)

RCT_EXTERN_METHOD(disableAdjustMode: (nonnull NSNumber *)node)

RCT_EXTERN_METHOD(adjustObject: (nonnull NSNumber *)node
                  buttonPressed:(nonnull NSString *)buttonPressed)

RCT_EXPORT_VIEW_PROPERTY(onObjectSelect, RCTDirectEventBlock)

@end
