//
//  GameViewController.m
//  IOS_ASS1
//
//  Created by Denis Turitsa on 2017-02-20.
//  Copyright © 2017 Denis Turitsa. All rights reserved.
//

#import "GameViewController.h"
#import <OpenGLES/ES2/glext.h>
#define BUFFER_OFFSET(i) ((char *)NULL + (i))



// Uniform index.
enum
{
    UNIFORM_MODELVIEWPROJECTION_MATRIX,
    UNIFORM_NORMAL_MATRIX,
    NUM_UNIFORMS
};
GLint uniforms[NUM_UNIFORMS];

// Attribute index.
enum
{
    ATTRIB_VERTEX,
    ATTRIB_NORMAL,
    NUM_ATTRIBUTES
};

bool isRotating = true;
/*
GLfloat gCubeVertexData[216] =
{
    // Data layout for each line below is:
    // positionX, positionY, positionZ,     normalX, normalY, normalZ,
    0.5f, -0.5f, -0.5f,        1.0f, 0.0f, 0.0f,
    0.5f, 0.5f, -0.5f,         1.0f, 0.0f, 0.0f,
    0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f,
    0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f,
    0.5f, 0.5f, -0.5f,          1.0f, 0.0f, 0.0f,
    0.5f, 0.5f, 0.5f,         1.0f, 0.0f, 0.0f,
    
    0.5f, 0.5f, -0.5f,         0.0f, 1.0f, 0.0f,
    -0.5f, 0.5f, -0.5f,        0.0f, 1.0f, 0.0f,
    0.5f, 0.5f, 0.5f,          0.0f, 1.0f, 0.0f,
    0.5f, 0.5f, 0.5f,          0.0f, 1.0f, 0.0f,
    -0.5f, 0.5f, -0.5f,        0.0f, 1.0f, 0.0f,
    -0.5f, 0.5f, 0.5f,         0.0f, 1.0f, 0.0f,
    
    -0.5f, 0.5f, -0.5f,        -1.0f, 0.0f, 0.0f,
    -0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f,
    -0.5f, 0.5f, 0.5f,         -1.0f, 0.0f, 0.0f,
    -0.5f, 0.5f, 0.5f,         -1.0f, 0.0f, 0.0f,
    -0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f,
    -0.5f, -0.5f, 0.5f,        -1.0f, 0.0f, 0.0f,
    
    -0.5f, -0.5f, -0.5f,       0.0f, -1.0f, 0.0f,
    0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f,
    -0.5f, -0.5f, 0.5f,        0.0f, -1.0f, 0.0f,
    -0.5f, -0.5f, 0.5f,        0.0f, -1.0f, 0.0f,
    0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f,
    0.5f, -0.5f, 0.5f,         0.0f, -1.0f, 0.0f,
    
    0.5f, 0.5f, 0.5f,          0.0f, 0.0f, 1.0f,
    -0.5f, 0.5f, 0.5f,         0.0f, 0.0f, 1.0f,
    0.5f, -0.5f, 0.5f,         0.0f, 0.0f, 1.0f,
    0.5f, -0.5f, 0.5f,         0.0f, 0.0f, 1.0f,
    -0.5f, 0.5f, 0.5f,         0.0f, 0.0f, 1.0f,
    -0.5f, -0.5f, 0.5f,        0.0f, 0.0f, 1.0f,
    
    0.5f, -0.5f, -0.5f,        0.0f, 0.0f, -1.0f,
    -0.5f, -0.5f, -0.5f,       0.0f, 0.0f, -1.0f,
    0.5f, 0.5f, -0.5f,         0.0f, 0.0f, -1.0f,
    0.5f, 0.5f, -0.5f,         0.0f, 0.0f, -1.0f,
    -0.5f, -0.5f, -0.5f,       0.0f, 0.0f, -1.0f,
    -0.5f, 0.5f, -0.5f,        0.0f, 0.0f, -1.0f
    
};
 */

static GLfloat v_quads[] = {1.0f,-1.0f,-1.0f,1.0f,-1.0f,1.0f,-1.0f,-1.0f,1.0f,-1.0f,-1.0f,-1.0f,
    1.0f,1.0f,-0.999999f,-1.0f,1.0f,-1.0f,-1.0f,1.0f,1.0f,0.999999f,1.0f,1.000001f,
    1.0f,-1.0f,-1.0f,1.0f,1.0f,-0.999999f,0.999999f,1.0f,1.000001f,1.0f,-1.0f,1.0f,
    1.0f,-1.0f,1.0f,0.999999f,1.0f,1.000001f,-1.0f,1.0f,1.0f,-1.0f,-1.0f,1.0f,
    -1.0f,-1.0f,1.0f,-1.0f,1.0f,1.0f,-1.0f,1.0f,-1.0f,-1.0f,-1.0f,-1.0f,
    1.0f,1.0f,-0.999999f,1.0f,-1.0f,-1.0f,-1.0f,-1.0f,-1.0f,-1.0f,1.0f,-1.0f,
};

static GLfloat vt_quads[] = {
    
    
    
    
    
};

static GLfloat vn_quads[] = {0.0f,-1.0f,0.0f,0.0f,-1.0f,0.0f,0.0f,-1.0f,0.0f,0.0f,-1.0f,0.0f,
    0.0f,1.0f,0.0f,0.0f,1.0f,0.0f,0.0f,1.0f,0.0f,0.0f,1.0f,0.0f,
    1.0f,0.0f,0.0f,1.0f,0.0f,0.0f,1.0f,0.0f,0.0f,1.0f,0.0f,0.0f,
    0.0f,0.0f,1.0f,0.0f,0.0f,1.0f,0.0f,0.0f,1.0f,0.0f,0.0f,1.0f,
    -1.0f,0.0f,0.0f,-1.0f,0.0f,0.0f,-1.0f,0.0f,0.0f,-1.0f,0.0f,0.0f,
    0.0f,0.0f,-1.0f,0.0f,0.0f,-1.0f,0.0f,0.0f,-1.0f,0.0f,0.0f,-1.0f,
};



@interface GameViewController () {
    GLuint _program;
    
    GLKMatrix4 _modelViewProjectionMatrix;
    GLKMatrix3 _normalMatrix;
    float _rotation;
    
    GLuint _vertexArray;
    GLuint _vertexBuffer;
    
}

@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) GLKBaseEffect *effect;

- (void)setupGL;
- (void)tearDownGL;

- (BOOL)loadShaders;
- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
- (BOOL)linkProgram:(GLuint)prog;
- (BOOL)validateProgram:(GLuint)prog;
@end

@implementation GameViewController
@synthesize posLabel;
@synthesize rotLabel;
@synthesize q8Label;

//how much the displayed object is scaled
float scaleAmount = 1.0f;

//location of the UI gesture in the previous frame
CGPoint oldLocation;

//the position of the object
float xPosition, yPosition, zPosition;

//the rotation of the object
float xRotation, yRotation, zRotation;

//rotation of the 2 finger UI gesture in the previous frame
CGPoint oldRotation;

//is the Cpp value used for (Question 8)
bool usingCppVal = true;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];

    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [self setupGL];
    
    //detec taps
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapGesture];
   // [tapGesture release];
    
    //detect 1 finger drag
    UIPanGestureRecognizer *panRecognizer;
    panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
    panRecognizer.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:panRecognizer];
    
    //detect 2 finger drag
    UIPanGestureRecognizer *dragRecognizer;
    dragRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(translateDetecter:)];
    dragRecognizer.minimumNumberOfTouches = 2;
    [self.view addGestureRecognizer:dragRecognizer];
    
    //detect pinch
    UIPinchGestureRecognizer *pinchRecognizer;
    pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinching:)];
    [self.view addGestureRecognizer:pinchRecognizer];
    
    theObject = [[MixTest alloc] init];
}

//resets position and rotation
- (IBAction)ResetBut:(id)sender{
    xRotation = 0.0f;
    yRotation = 0.0f;
    xPosition = 0.0f;
    yPosition = 0.0f;
}

//the button action for incrementing and displaying the int for Q8
- (IBAction)q8But:(id)sender {
    if(!usingCppVal){
        [q8Label setText:[NSString stringWithFormat:@"Obj C value: %d", [theObject incrementObjCVal]]];
    } else{
        [q8Label setText:[NSString stringWithFormat:@"Cpp value: %d", [theObject incrementCppVal]]];
    }
    usingCppVal = !usingCppVal;
    
}

 

- (void)dealloc
{    
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
}
- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
        isRotating = !isRotating;
    }
}

//handles pinching
- (void) pinching:(UIPinchGestureRecognizer *) recognizer {
    
    if (!isRotating && ([recognizer state] == UIGestureRecognizerStateBegan || [recognizer state] == UIGestureRecognizerStateChanged)) {
        scaleAmount *= recognizer.scale;
        //reset recognizer
        [recognizer setScale:1.0];
    }
}

//drag-rotate detection
-(void)dragging:(UIPanGestureRecognizer *)gesture
{
    if(!isRotating){
        if(gesture.state == UIGestureRecognizerStateBegan)
        {
            oldRotation = [gesture locationInView:gesture.view];
        }
        CGPoint newCoord = [gesture locationInView:gesture.view];
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        xRotation += newCoord.x / screenRect.size.width - oldRotation.x / screenRect.size.width;
        yRotation += newCoord.y / screenRect.size.width - oldRotation.y / screenRect.size.width;
        oldRotation = [gesture locationInView:gesture.view];
    }
   
}

//drag-translate detection

-(void)translateDetecter:(UIPanGestureRecognizer *)gesture
{
    if(!isRotating){
        if(gesture.state == UIGestureRecognizerStateBegan) {
            oldLocation = [gesture locationInView:gesture.view];
        }
        CGPoint newCoord = [gesture locationInView:gesture.view];
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        xPosition += newCoord.x / screenRect.size.width - oldLocation.x / screenRect.size.width;
        yPosition += newCoord.y / screenRect.size.width - oldLocation.y / screenRect.size.width;
        
        oldLocation = [gesture locationInView:gesture.view];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        self.view = nil;
        
        [self tearDownGL];
        
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }

    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    
    [self loadShaders];
    
    self.effect = [[GLKBaseEffect alloc] init];
    self.effect.light0.enabled = GL_TRUE;
    self.effect.light0.diffuseColor = GLKVector4Make(.4f, 1.0f, 0.4f, 1.0f);
    
    glEnable(GL_DEPTH_TEST);
    
    glGenVertexArraysOES(1, &_vertexArray);
    glBindVertexArrayOES(_vertexArray);
    
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    
    long size = sizeof(v_quads) * 2;
    GLfloat mixedArray[size];
    //NSLog(@"%u", size);
   // NSLog(@"%u", sizeof(vn_quads));

    int j = 0;
     int k = 0;
    for(int i = 0; i < size; i++){
        //NSLog(@"%u", i%6);
        if(i%6 < 3){
            mixedArray[i] = v_quads[j];
            j++;
        }else{
            mixedArray[i] = vn_quads[k];
            k++;
        }
        NSLog(@"%.2f", mixedArray[i]);
  
    }
    
    glBufferData(GL_ARRAY_BUFFER, sizeof(mixedArray), mixedArray, GL_STATIC_DRAW);
    
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
   glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(0));
    //glVertexAttribPointer(GLKVertexAttribPosition3, GL_FLOAT, 0, v_quads);
    
   // glBufferData(GL_ARRAY_BUFFER, sizeof(vn_quads), vn_quads, GL_STATIC_DRAW);
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(12));
    
    
    
    //new
    /*
    std::vector< glm::vec3 > vertices;
    std::vector< glm::vec2 > uvs;
    std::vector< glm::vec3 > normals; // Won't be used at the moment.
    bool res = loadOBJ("cube.obj", vertices, uvs, normals);
*/
  //  glBufferData(GL_ARRAY_BUFFER, sizeof(v_quads), v_quads, GL_STATIC_DRAW);
    /*
    glVertexPointer(3, GL_FLOAT, 0, v_quads);
    glTexCoordPointer(2, GL_FLOAT, 0, vt_quads);
    glNormalPointer(GL_FLOAT, 0, vn_quads);
    if(glLockArraysEXT!=NULL) {glLockArraysEXT (0,24);}
    glDrawArrays(GL_QUADS, 0, 24);
    if(glUnlockArraysEXT!=NULL) {glUnlockArraysEXT();}
    //end new
    */
    glBindVertexArrayOES(0);
}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];
    
    glDeleteBuffers(1, &_vertexBuffer);
    glDeleteVertexArraysOES(1, &_vertexArray);
    
    self.effect = nil;
    
    if (_program) {
        glDeleteProgram(_program);
        _program = 0;
    }
}

-(void)updatePosLabel{
    NSString *labelString = [NSString stringWithFormat:@"Position: %.2f %.2f %.2f", xPosition, yPosition, zPosition];
    // labelString = [labelString stringByAppendingString:[NSString stringWithFormat:@"%1.2f", yPosition]];
    self.posLabel.text = labelString;
    
    NSString *rotLabelString = [NSString stringWithFormat:@"Rotation: %.2f %.2f %.2f",xRotation, yRotation, zRotation];
    // labelString = [labelString stringByAppendingString:[NSString stringWithFormat:@"%1.2f", yPosition]];
    self.rotLabel.text = rotLabelString;
}


#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
    float aspect = fabs(self.view.bounds.size.width / self.view.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 100.0f);
    
    self.effect.transform.projectionMatrix = projectionMatrix;
    
    GLKMatrix4 baseModelViewMatrix = GLKMatrix4MakeTranslation(xPosition, -yPosition, -4.0f);
    baseModelViewMatrix = GLKMatrix4Rotate(baseModelViewMatrix, xRotation, 0.0f, 1.0f, 0.0f);
    baseModelViewMatrix = GLKMatrix4Rotate(baseModelViewMatrix, yRotation, 1.0f, 0.0f, 0.0f);
    
    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, 0.0f);
    modelViewMatrix = GLKMatrix4MakeScale(scaleAmount,scaleAmount,scaleAmount);
    modelViewMatrix = GLKMatrix4Multiply(baseModelViewMatrix, modelViewMatrix);
 
    self.effect.transform.modelviewMatrix = modelViewMatrix;
    
    _normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(modelViewMatrix), NULL);
    
    _modelViewProjectionMatrix = GLKMatrix4Multiply(projectionMatrix, modelViewMatrix);
    
    if(isRotating){
        xRotation += self.timeSinceLastUpdate * 0.5f;
    }
    [self updatePosLabel];
    
}


- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glBindVertexArrayOES(_vertexArray);
    
    
    // Render the object with GLKit
    [self.effect prepareToDraw];
    
    glDrawArrays(GL_TRIANGLES, 0, 36);

}

#pragma mark -  OpenGL ES 2 shader compilation

- (BOOL)loadShaders
{
    GLuint vertShader, fragShader;
    NSString *vertShaderPathname, *fragShaderPathname;
    
    // Create shader program.
    _program = glCreateProgram();
    
    // Create and compile vertex shader.
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname]) {
        NSLog(@"Failed to compile vertex shader");
        return NO;
    }
    
    // Create and compile fragment shader.
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname]) {
        NSLog(@"Failed to compile fragment shader");
        return NO;
    }
    
    // Attach vertex shader to program.
    glAttachShader(_program, vertShader);
    
    // Attach fragment shader to program.
    glAttachShader(_program, fragShader);
    
    // Bind attribute locations.
    // This needs to be done prior to linking.
    glBindAttribLocation(_program, GLKVertexAttribPosition, "position");
    glBindAttribLocation(_program, GLKVertexAttribNormal, "normal");
    
    // Link program.
    if (![self linkProgram:_program]) {
        NSLog(@"Failed to link program: %d", _program);
        
        if (vertShader) {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader) {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (_program) {
            glDeleteProgram(_program);
            _program = 0;
        }
        
        return NO;
    }
    
    // Get uniform locations.
    uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX] = glGetUniformLocation(_program, "modelViewProjectionMatrix");
    uniforms[UNIFORM_NORMAL_MATRIX] = glGetUniformLocation(_program, "normalMatrix");
    
    // Release vertex and fragment shaders.
    if (vertShader) {
        glDetachShader(_program, vertShader);
        glDeleteShader(vertShader);
    }
    if (fragShader) {
        glDetachShader(_program, fragShader);
        glDeleteShader(fragShader);
    }
    
    return YES;
}

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source) {
        NSLog(@"Failed to load vertex shader");
        return NO;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0) {
        glDeleteShader(*shader);
        return NO;
    }
    
    return YES;
}

- (BOOL)linkProgram:(GLuint)prog
{
    GLint status;
    glLinkProgram(prog);
    
#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif
    
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}

- (BOOL)validateProgram:(GLuint)prog
{
    GLint logLength, status;
    
    glValidateProgram(prog);
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
    
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}

@end


