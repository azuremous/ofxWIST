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
    
    ofBackground(0);
    start = false;
    tempoCount = 50;
    setTempo(tempoCount);
    wistOnButton.setup(30, 100, 50, 50, "wiston");
    startButton.setup(30, 200, 50, 50, "start");//send tempo and make slave start
    
}

//--------------------------------------------------------------
void testApp::update(){
    
    
}

//--------------------------------------------------------------
void testApp::draw(){
    
    ofSetColor(255);
    if (wist.isConected()) {
        if (wist.isMaster()) {
            ofDrawBitmapString("master", 10, 20);
        }else {
            ofDrawBitmapString("slave", 10, 20);
        }
    }else {
        ofDrawBitmapString("wist", 10,20);
    }
    
    ofPushMatrix();
    ofTranslate(10, 50);
    ofDrawBitmapString("tempo:", 0,0);
    ofDrawBitmapString(tempoText, 50, 0);
    ofPopMatrix();
    
    wistOnButton.render();
    startButton.render();
	
}

//--------------------------------------------------------------
void testApp::exit(){
    
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){
    
    
    if (wistOnButton.checkClick(touch)) {
        
        if (!wist.isConected()) {
            wist.on();
        }else {
            wist.off();
        }
        
    }
    
    
    startButton.checkClick(touch);
    
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
    
    setTempo(touch.y);
    
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){
    
    
    if (wistOnButton.clicked && !wist.isConected()) wistOnButton.clicked = false;
    
    if (startButton.clicked && !start ) {
        if (wist.isConected() && wist.isMaster()) {
            wist.start(tempoCount);
        }
        start = true;
        
    }else {
        
        if (wist.isConected() && wist.isMaster()) {
            wist.stop();
        }
        
        start = false;
        startButton.clicked = false;
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
//--------------------------------------------------------------
void testApp::gotMessage(ofMessage msg){
    
    if (!wist.isMaster()) {//when this one is slave
        if (msg.message == "receiveTempo") {
            
            tempoCount = wist.getTempo();
            setTempo(tempoCount);
            
            start = true;
            startButton.clicked = true;
          
        }else if (msg.message == "stop"){
            
            start = false;
            startButton.clicked = false;
            
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
