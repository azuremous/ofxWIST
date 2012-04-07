//
//  ofxWIST.cpp
//  emptyExample
//
//  Created by 정운 김 on 4/5/12.
//  Copyright (c) 2012 pinkroad.co.cc. All rights reserved.
//

#include "ofxWIST.h"

#import <mach/mach_time.h>


@implementation ofxWISTDelegate

@synthesize tempo = tempo_;

-(id)init{
    
    self.tempo = 120.0f;
    musicStart = false;
    bwistMaster = false;
    
    wist_ = [[KorgWirelessSyncStart alloc] init];
    wist_.delegate = self;
    
    [self updateWistStatus:NO];
    
    return self;
    
}

- (void)dealloc
{
    
    [wist_ release];
    wist_ = nil;
    
    [super dealloc];
}


//  ---------------------------------------------------------------------------
//      setTempo
//  ---------------------------------------------------------------------------
- (void)setTempo:(float)value
{
    tempo_ = static_cast<float>(static_cast<int>(value * 10)) / 10;
}


//  ---------------------------------------------------------------------------
//      wistOn
//  ---------------------------------------------------------------------------
- (void)wistOn
{
    if (!wist_.isConnected)
    {
     
        [wist_ searchPeer];
    }
}
//  ---------------------------------------------------------------------------
//      wistOff
//  ---------------------------------------------------------------------------
- (void)wistOff
{
    if (wist_.isConnected)
    {
        [wist_ disconnect];
    }
}

- (uint64_t)now
{
    return mach_absolute_time();
}

- (void)wistStart:(float)tempo
{
    if (wist_.isConnected && wist_.isMaster)  //  In MASTER mode, send command to SLAVE
    {
        //  sync start
        const uint64_t  hostTime = [self now];
        //remote
        [wist_ sendStartCommand:hostTime withTempo:tempo];             
    }
    
}
- (void)wistStop
{
    
    if (wist_.isConnected && wist_.isMaster)  //  In MASTER mode, send command to SLAVE
    {
        //sync stop
        const uint64_t  hostTime = [self now];
     
        //remote
        [wist_ sendStopCommand:hostTime]; 
    }
    
}

-(float) getWistTempo{
    
    return self.tempo;
}

-(bool) isWistMaster{
    
    return bwistMaster;
}

-(bool) isWistConected{
    
    return wist_.isConnected;
}

-(void) updateWistStatus:(BOOL)checked{
    
    if (wist_.isConnected && wist_.isMaster) {
        bwistMaster = true;
    }else {
        bwistMaster = false;
    }
    
}
- (void)wistStartCommandReceived:(uint64_t)hostTime withTempo:(float)tempo
{
    //  (In SLAVE mode) received start command from MASTER
    self.tempo = tempo;
    ofSendMessage("receiveTempo");
   
}

- (void)wistStopCommandReceived:(uint64_t)hostTime
{
 
    ofSendMessage("stop");
}

//  ---------------------------------------------------------------------------
//      wistConnectionCancelled (@optional)
//  ---------------------------------------------------------------------------
- (void)wistConnectionCancelled
{
    [self updateWistStatus:YES];
}

//  ---------------------------------------------------------------------------
//      wistConnectionEstablished (@optional)
//  ---------------------------------------------------------------------------
- (void)wistConnectionEstablished
{
    [self updateWistStatus:YES];
}

//  ---------------------------------------------------------------------------
//      wistConnectionLost (@optional)
//  ---------------------------------------------------------------------------
- (void)wistConnectionLost
{
    [self updateWistStatus:YES];
}


@end


ofxWIST::ofxWIST(){
    
    myWist = [[ofxWISTDelegate alloc]init];

}

ofxWIST::~ofxWIST(){
    
    [myWist release];
}

void ofxWIST::on(){
    
    [myWist wistOn];
}

void ofxWIST::off(){
    
    [myWist wistOff];
}

void ofxWIST::start(float _tempo){
    
    [myWist wistStart:_tempo];
}

void ofxWIST::stop(){
    
    [myWist wistStop];
    
}

float ofxWIST::getTempo(){
    
    return [myWist getWistTempo];
}

bool ofxWIST::isMaster(){
    
    return [myWist isWistMaster];
}
bool ofxWIST::isConected(){
    
    return [myWist isWistConected];
}
