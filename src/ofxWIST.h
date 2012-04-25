//
//  ofxWIST.h
//  emptyExample
//
//  Created by 정운 김 on 4/5/12.
//  Copyright (c) 2012 pinkroad.co.cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KorgWirelessSyncStart.h"
#import "ofMain.h"

#ifndef emptyExample_ofxWIST_h
#define emptyExample_ofxWIST_h


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

#endif
