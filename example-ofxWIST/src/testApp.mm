#include "testApp.h"

void testApp::setup(){	
	// register touch events
	ofRegisterTouchEvents(this);
	
	// initialize the accelerometer
	ofxAccelerometer.setup();
	
	//iPhoneAlerts will be sent to this.
	ofxiPhoneAlerts.addListener(this);
	
	//If you want a landscape oreintation 
	//iPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
    
    ofSetFrameRate(60);
    ofSetVerticalSync(true);
    ofSetCircleResolution(50);
    
    start = false;
    tempoCount = 60;
    setTempo(tempoCount);
    
    ofBackground(0);
    wistOnButton.setup(30, 100, 50, 50, false);
    wistOnButton.setName("wistON",0,-5);
    wistOnButton.setAppear(true);
    
    startButton.setup(30, 200, 50, 50, false, TOGGLE);
    startButton.setName("start",0,-5);
    startButton.setAppear(true);
    
    metron.setup(tempoCount, 10,35);
    c_r = 10;
    c_c.set(255, 255, 255);
    
    
}

//--------------------------------------------------------------
void testApp::update(){
    
    if (metron.checkBang()&& metron.start) {
        if (metron.getBang()) {
            c_r = ofRandom(50,200);
        }else{
            
            c_r = 10;
        }
        c_c.set(ofRandom(255), ofRandom(255), ofRandom(255));
    }
    
}

//--------------------------------------------------------------
void testApp::draw(){
    
    ofPushMatrix();
    ofTranslate(ofGetWidth()/2, ofGetHeight()/2);
    ofSetColor(c_c);
    ofCircle(0, 0, c_r);
    ofPopMatrix();
    
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
    
    wistOnButton.press(touch);
    startButton.press(touch);
    
    if (wistOnButton.selected) {
        if (!wist.isConected()) wist.on();
        else wist.off();
        return;
    }
    
    setTempo(ofMap(touch.y, 0, ofGetHeight(), 40.0, 300.0));
    
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
    
    setTempo(ofMap(touch.y, 0, ofGetHeight(), 40.0, 300.0));
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){
    
    if (startButton.selected) {
        if (wist.isConected()) {
            if (wist.isMaster()) {
                wist.start(tempoCount);
                
            }
        }
        metron.start = true;
        metron.setTempo(tempoCount);
        return;
        
    }else {
        if (wist.isConected()) {
            if (wist.isMaster()) { 
                wist.stop();
            }
        }
        metron.start = false;
        metron.setTempo(tempoCount);
        return;
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
        if (msg.message == "start") {
            
            tempoCount = wist.getTempo();
            setTempo(tempoCount);
            
            start = true;
            startButton.selected = true;
            
        }else if (msg.message == "stop"){
            
            start = false;
            startButton.selected = false;
            
        }
    }
    
    metron.start = start;
    metron.setTempo(tempoCount);
}

void testApp::setTempo(float _tempo){
    
    char * count = new char[255];
    sprintf(count, "%0.1f",_tempo);
    tempoCount = _tempo;
    tempoText = count;
    delete [] count;
    
}

