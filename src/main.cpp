#include "ofMain.h"
#include "ofxCv.h"
#include "testApp.h"


int main( ){
	ofAppNoWindow window;
    ofSetupOpenGL(&window, 1204, 768, OF_WINDOW);
    ofRunApp(new ofApp());

}
