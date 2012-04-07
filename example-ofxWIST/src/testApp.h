#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"

#include "ofxWIST.h"

//ofxWIST need to adding GameKit.framework

class button {
    
public:
    
    ofRectangle buttonRect;
    string buttonName;
    bool clicked;
    
    void setup(float x, float y, float w, float h, string name){
        
        clicked = false;
        buttonName = name;
        buttonRect.set(x, y, w, h);
    }
    
    void render(){
        
        ofPushStyle();
        if (!clicked) {
            ofNoFill();
        }
        ofSetLineWidth(2);
        ofRect(buttonRect);
        ofPopStyle();
        ofDrawBitmapString(buttonName, buttonRect.x,buttonRect.y - 5);
    }
    
    bool checkClick(ofTouchEventArgs &touch){
        
        clicked = touch.x >= buttonRect.x && touch.x <= buttonRect.x + buttonRect.width && touch.y >= buttonRect.y && touch.y <= buttonRect.y + buttonRect.height;
        
        return clicked;
    }
    
};

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
    
    //check for got message
    void gotMessage(ofMessage msg);
    void setTempo(float _tempo);
    
    
    ofxWIST wist; 
    string tempoText;
    float tempoCount;
    bool start;
    
    button wistOnButton;
    button startButton;
    
};


