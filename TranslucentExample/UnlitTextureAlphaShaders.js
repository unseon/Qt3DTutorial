.pragma library

function getVertES2() {
    return "\
attribute vec3 vertexPosition;
attribute vec2 vertexTexCoord;

varying vec2 texCoord;

uniform mat4 mvp;

uniform float texCoordScale;

void main()
{
    texCoord = vertexTexCoord * texCoordScale;
    gl_Position = mvp * vec4( vertexPosition, 1.0 );
}"
}

function getFragES2() {
    return "\
#define FP highp

uniform FP float alpha;
uniform sampler2D diffuseTexture;

varying FP vec2 texCoord;

void main()
{
    FP vec4 diffuseTexture = texture2D( diffuseTexture, texCoord );
    //if (diffuseTexture.a < 0.2)
    //    discard;
    gl_FragColor = vec4(diffuseTexture.rgb, diffuseTexture.a * alpha);
}"

}

function getVertGL() {
    return "\
#version 150 core

in vec3 vertexPosition;
in vec2 vertexTexCoord;

out vec2 texCoord;

uniform mat4 mvp;
uniform float texCoordScale;

void main()
{
    texCoord = vertexTexCoord * texCoordScale;
    gl_Position = mvp * vec4( vertexPosition, 1.0 );
}"
}

function getFragGL() {
    return "\
#version 150 core
#define FP highp

uniform float alpha;
uniform sampler2D diffuseTexture;

out vec4 fragColor;

void main()
{
    FP vec4 diffuseTexture = texture2D( diffuseTexture, texCoord );
    fragColor = vec4(diffuseTexture.rgb, diffuseTexture.a * alpha);
}"
}
