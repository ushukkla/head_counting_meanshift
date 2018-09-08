#include "ofMain.h"
#include "ofxCv.h"
#include "testApp.h"

//========================================================================
int main( ){
	ofSetupOpenGL(1204,768,OF_WINDOW);			// <-------- setup the GL context

	
	ofRunApp(new testApp());

}
