//
//  ofxWIST.h
//  ofxWIST
//
//  Created by kim jung un a.k.a azuremous on 4/5/12.
//  Copyright (c) 2012 azuremous.net All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KorgWirelessSyncStart.h"
#import "ofMain.h"

#pragma once


@interface ofxWISTDelegate : UIViewController <KorgWirelessSyncStartDelegate>
{
    
    KorgWirelessSyncStart * wist_;
    
    bool musicStart;
    bool bwistMaster;
    
    float   tempo_;
}

@property (nonatomic, assign) float tempo;

-(id)init;

-(void) wistOn;
-(void) wistOff;
-(void) wistStart:(float)tempo;
-(void) wistStop;
-(void) updateWistStatus:(BOOL)checked;
-(float) getWistTempo;
-(bool) isWistMaster;
-(bool) isWistConected;

@end

class ofxWIST {
    
protected:
    
    ofxWISTDelegate * myWist;
    
public:
    
    ofxWIST();
    ~ofxWIST();
    
    void on();
    void off();
    void start(float _tempo);
    void stop();
    
    float getTempo();
    
    bool isMaster();
    bool isConected();
    
};

