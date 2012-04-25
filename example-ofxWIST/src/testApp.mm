#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	// register touch events
	ofRegisterTouchEvents(this);
	
	// initialize the accelerometer
	ofxAccelerometer.setup();
	
	//iPhoneAlerts will be sent to this.
	ofxiPhoneAlerts.addListener(this);
	
	//If you want a landscape oreintation 
	//iPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
    
    start = false;
    tempoCount = 50;
    setTempo(tempoCount);
    
    ofBackground(0);
    wistOnButton.setup(30, 100, 50, 50);
    wistOnButton.setName("wistON",0,-5);
    wistOnButton.setAppear(true);
    
    startButton.setup(30, 200, 50, 50,TOGGLE);
    startButton.setName("start",0,-5);
    startButton.setAppear(true);
    
}

//--------------------------------------------------------------
void testApp::update(){
    
}

//--------------------------------------------------------------
void testApp::draw(){
    
    ofSetColor(255);
    if (wist.isConected()) {
        if (wist.isMaster()) ofDrawBitmapString("master", 10, 20);
        else ofDrawBitmapString("slave", 10, 20);
        
    }else ofDrawBitmapString("wist", 10,20);
    
    ofPushMatrix();
    ofTranslate(10, 50);
    ofDrawBitmapString("tempo:", 0,0);
    ofDrawBitmapString(tempoText, 50, 0);
    ofPopMatrix();
	
}

//--------------------------------------------------------------
void testApp::exit(){
    
    
    
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){
    
    if (wistOnButton.pressed(touch.x, touch.y)) {
        if (!wist.isConected()) wist.on();
        else wist.off();
    }
    
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
    
    setTempo(touch.y);
    
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){
    
    if (wist.isConected()) {
        
        if (wist.isMaster()) {
            
            if (startButton.selected) wist.start(tempoCount);
            else wist.stop();
            
        }
    }
    
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){
    
}

//--------------------------------------------------------------
void testApp::lostFocus(){
    
}

//--------------------------------------------------------------
void testApp::gotFocus(){
    
}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){
    
}


//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs& args){
    
}

void testApp::gotMessage(ofMessage msg){
    
    if (!wist.isMaster()) {//when this one is slave
        if (msg.message == "start" && !start) {
            
            tempoCount = wist.getTempo();
            setTempo(tempoCount);
            
            start = true;
            startButton.selected = true;
            
        }else if (msg.message == "stop" && start){
            
            start = false;
            startButton.selected = false;
            
        }
    }
    
}

void testApp::setTempo(float _tempo){
    
    char * count = new char[255];
    sprintf(count, "%0.2f",_tempo);
    tempoCount = _tempo;
    tempoText = count;
    delete [] count;
}

