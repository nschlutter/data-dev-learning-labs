
 varying vec2 v_texCoord;
 
 uniform sampler2D CC_Texture0;
 
 uniform float fractionalWidthOfPixel;
 uniform float aspectRatio;
 uniform vec2 pixelateCenter;
 uniform float pixelateRadius;
  uniform float opacity;
 
 void main()
 {
     vec2 textureCoordinateToUse = vec2(v_texCoord.x, (v_texCoord.y * aspectRatio + 0.5 - 0.5 * aspectRatio));
     float dist = distance(pixelateCenter, textureCoordinateToUse);
     
     if (dist < pixelateRadius)
     {
         vec2 sampleDivisor = vec2(fractionalWidthOfPixel, fractionalWidthOfPixel / aspectRatio);
         vec2 samplePos = v_texCoord - mod(v_texCoord, sampleDivisor) + 0.5 * sampleDivisor;
         gl_FragColor = texture2D(CC_Texture0, samplePos ) * opacity;
     }
     else
     {
         gl_FragColor = texture2D(CC_Texture0, v_texCoord ) * opacity;
     }
 }
/*

@interface GPUImagePixellatePositionFilter ()

@property (readwrite, nonatomic) CGFloat aspectRatio;

@end

@implementation GPUImagePixellatePositionFilter

@synthesize fractionalWidthOfAPixel = _fractionalWidthOfAPixel;
@synthesize aspectRatio = _aspectRatio;
@synthesize center = _center;
@synthesize radius = _radius;

#pragma mark -
#pragma mark Initialization and teardown

- (id)init;
{
    if (!(self = [self initWithFragmentShaderFromString:kGPUImagePixellationPositionFragmentShaderString]))
    {
		return nil;
    }
    
    return self;
}

- (id)initWithFragmentShaderFromString:(NSString *)fragmentShaderString;
{
    if (!(self = [super initWithFragmentShaderFromString:fragmentShaderString]))
    {
		return nil;
    }
    
    fractionalWidthOfAPixelUniform = [filterProgram uniformIndex:@"fractionalWidthOfPixel"];
    aspectRatioUniform = [filterProgram uniformIndex:@"aspectRatio"];
    centerUniform = [filterProgram uniformIndex:@"pixelateCenter"];
    radiusUniform = [filterProgram uniformIndex:@"pixelateRadius"];
    
    self.fractionalWidthOfAPixel = 0.05;
    self.center = CGPointMake(0.5f, 0.5f);
    self.radius = 0.25f;
    
    return self;
}

- (void)setInputSize:(CGSize)newSize atIndex:(NSInteger)textureIndex;
{
    CGSize oldInputSize = inputTextureSize;
    [super setInputSize:newSize atIndex:textureIndex];
    
    if ( (!CGSizeEqualToSize(oldInputSize, inputTextureSize)) && (!CGSizeEqualToSize(newSize, CGSizeZero)) )
    {
        if (GPUImageRotationSwapsWidthAndHeight(inputRotation))
        {
            [self setAspectRatio:(inputTextureSize.width / inputTextureSize.height)];
        }
        else
        {
            [self setAspectRatio:(inputTextureSize.height / inputTextureSize.width)];
        }
    }
}

#pragma mark -
#pragma mark Accessors

- (void)setFractionalWidthOfAPixel:(CGFloat)newValue;
{
    CGFloat singlePixelSpacing;
    if (inputTextureSize.width != 0.0)
    {
        singlePixelSpacing = 1.0 / inputTextureSize.width;
    }
    else
    {
        singlePixelSpacing = 1.0 / 2048.0;
    }
    
    if (newValue < singlePixelSpacing)
    {
        _fractionalWidthOfAPixel = singlePixelSpacing;
    }
    else
    {
        _fractionalWidthOfAPixel = newValue;
    }
    
    [self setFloat:_fractionalWidthOfAPixel forUniform:fractionalWidthOfAPixelUniform program:filterProgram];
}

- (void)setAspectRatio:(CGFloat)newValue;
{
    _aspectRatio = newValue;

    [self setFloat:_aspectRatio forUniform:aspectRatioUniform program:filterProgram];
}

- (void)setCenter:(CGPoint)center
{
    _center = center;
    
    [self setPoint:_center forUniform:centerUniform program:filterProgram];
}

- (void)setRadius:(CGFloat)radius
{
    _radius = radius;
    
    [self setFloat:_radius forUniform:radiusUniform program:filterProgram];
}

@end
 */
