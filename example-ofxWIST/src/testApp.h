#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"

#include "ofxWIST.h"
#include "ofxSimpleButton.h"
#include "ofxSimpleMetronome.h"

class testApp : public ofxiPhoneApp {
	
public:
	void setup();
	void update();
	void draw();
	void exit();
	
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);
	void touchCancelled(ofTouchEventArgs &touch);

	void lostFocus();
	void gotFocus();
	void gotMemoryWarning();
	void deviceOrientationChanged(int newOrientation);
    
    void gotMessage(ofMessage msg);//check for message
    void setTempo(float _tempo);
    
    ofxWIST wist; 
    
    string tempoText;
    float tempoCount;
    bool start;
    
    ofxSimpleButton wistOnButton;
    ofxSimpleButton startButton;
    
    metronome metron;
    
    float c_r;
    ofColor c_c;

};


