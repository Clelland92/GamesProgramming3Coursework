xof 0303txt 0032

// DirectX 9.0 file
// Creator: Ultimate Unwrap3D Pro v3.18
// Time: Sat Oct 10 07:52:29 2009

// Start of Templates

template VertexDuplicationIndices {
 <b8d65549-d7c9-4995-89cf-53a9a8b031e3>
 DWORD nIndices;
 DWORD nOriginalVertices;
 array DWORD indices[nIndices];
}

template FVFData {
 <b6e70a0e-8ef9-4e83-94ad-ecc8b0c04897>
 DWORD dwFVF;
 DWORD nDWords;
 array DWORD data[nDWords];
}

template Header {
 <3D82AB43-62DA-11cf-AB39-0020AF71E433>
 WORD major;
 WORD minor;
 DWORD flags;
}

template Vector {
 <3D82AB5E-62DA-11cf-AB39-0020AF71E433>
 FLOAT x;
 FLOAT y;
 FLOAT z;
}

template Coords2d {
 <F6F23F44-7686-11cf-8F52-0040333594A3>
 FLOAT u;
 FLOAT v;
}

template Matrix4x4 {
 <F6F23F45-7686-11cf-8F52-0040333594A3>
 array FLOAT matrix[16];
}

template ColorRGBA {
 <35FF44E0-6C7C-11cf-8F52-0040333594A3>
 FLOAT red;
 FLOAT green;
 FLOAT blue;
 FLOAT alpha;
}

template ColorRGB {
 <D3E16E81-7835-11cf-8F52-0040333594A3>
 FLOAT red;
 FLOAT green;
 FLOAT blue;
}

template IndexedColor {
 <1630B820-7842-11cf-8F52-0040333594A3>
 DWORD index;
 ColorRGBA indexColor;
}

template Material {
 <3D82AB4D-62DA-11cf-AB39-0020AF71E433>
 ColorRGBA faceColor;
 FLOAT power;
 ColorRGB specularColor;
 ColorRGB emissiveColor;
 [...]
}

template TextureFilename {
 <A42790E1-7810-11cf-8F52-0040333594A3>
 STRING filename;
}

template MeshFace {
 <3D82AB5F-62DA-11cf-AB39-0020AF71E433>
 DWORD nFaceVertexIndices;
 array DWORD faceVertexIndices[nFaceVertexIndices];
}

template MeshTextureCoords {
 <F6F23F40-7686-11cf-8F52-0040333594A3>
 DWORD nTextureCoords;
 array Coords2d textureCoords[nTextureCoords];
}

template MeshMaterialList {
 <F6F23F42-7686-11cf-8F52-0040333594A3>
 DWORD nMaterials;
 DWORD nFaceIndexes;
 array DWORD faceIndexes[nFaceIndexes];
 [Material]
}

template MeshNormals {
 <F6F23F43-7686-11cf-8F52-0040333594A3>
 DWORD nNormals;
 array Vector normals[nNormals];
 DWORD nFaceNormals;
 array MeshFace faceNormals[nFaceNormals];
}

template MeshVertexColors {
 <1630B821-7842-11cf-8F52-0040333594A3>
 DWORD nVertexColors;
 array IndexedColor vertexColors[nVertexColors];
}

template Mesh {
 <3D82AB44-62DA-11cf-AB39-0020AF71E433>
 DWORD nVertices;
 array Vector vertices[nVertices];
 DWORD nFaces;
 array MeshFace faces[nFaces];
 [...]
}

template FrameTransformMatrix {
 <F6F23F41-7686-11cf-8F52-0040333594A3>
 Matrix4x4 frameMatrix;
}

template Frame {
 <3D82AB46-62DA-11cf-AB39-0020AF71E433>
 [...]
}

template FloatKeys {
 <10DD46A9-775B-11cf-8F52-0040333594A3>
 DWORD nValues;
 array FLOAT values[nValues];
}

template TimedFloatKeys {
 <F406B180-7B3B-11cf-8F52-0040333594A3>
 DWORD time;
 FloatKeys tfkeys;
}

template AnimationKey {
 <10DD46A8-775B-11cf-8F52-0040333594A3>
 DWORD keyType;
 DWORD nKeys;
 array TimedFloatKeys keys[nKeys];
}

template AnimationOptions {
 <E2BF56C0-840F-11cf-8F52-0040333594A3>
 DWORD openclosed;
 DWORD positionquality;
}

template Animation {
 <3D82AB4F-62DA-11cf-AB39-0020AF71E433>
 [...]
}

template AnimationSet {
 <3D82AB50-62DA-11cf-AB39-0020AF71E433>
 [Animation]
}

template XSkinMeshHeader {
 <3CF169CE-FF7C-44ab-93C0-F78F62D172E2>
 WORD nMaxSkinWeightsPerVertex;
 WORD nMaxSkinWeightsPerFace;
 WORD nBones;
}

template SkinWeights {
 <6F0D123B-BAD2-4167-A0D0-80224F25FABB>
 STRING transformNodeName;
 DWORD nWeights;
 array DWORD vertexIndices[nWeights];
 array FLOAT weights[nWeights];
 Matrix4x4 matrixOffset;
}

template AnimTicksPerSecond {
 <9E415A43-7BA6-4a73-8743-B73D47E88476>
 DWORD AnimTicksPerSecond;
}

AnimTicksPerSecond {
 4800;
}

// Start of Frames

Frame Body {
   FrameTransformMatrix {
    1.000000, 0.000000, 0.000000, 0.000000,
    0.000000, 1.000000, 0.000000, 0.000000,
    0.000000, 0.000000, 1.000000, 0.000000,
    0.000000, 0.000000, 0.000000, 1.000000;;
   }

   Mesh staticMesh {
    162;
    -31.610003; 13.642806; -37.901264;,
    -24.687729; 12.390931; -37.901264;,
    -31.610003; -2.791675; -31.777426;,
    -18.819193; 8.829454; -37.901264;,
    -31.610003; -2.791675; -31.777426;,
    -14.897746; 3.446267; -33.792263;,
    -31.610003; -2.791675; -31.777426;,
    -13.521631; -2.791675; -31.443794;,
    -31.610003; -2.791675; -31.777426;,
    -14.897746; -9.081306; -31.443794;,
    -31.610003; -2.791675; -31.777426;,
    -18.819193; -14.464494; -33.792263;,
    -31.610003; -2.791675; -31.777426;,
    -24.687729; -17.974281; -37.901264;,
    -31.610003; -2.791675; -31.777426;,
    -31.610003; -19.226156; -37.901264;,
    -31.610003; -2.791675; -31.777426;,
    -38.532276; -17.974281; -37.901264;,
    -31.610003; -2.791675; -31.777426;,
    -44.400814; -14.412805; -37.901264;,
    -31.610003; -2.791675; -31.777426;,
    -48.322262; -9.081306; -37.901264;,
    -31.610003; -2.791675; -31.777426;,
    -49.699978; -2.791675; -37.901264;,
    -31.610003; -2.791675; -31.777426;,
    -48.322262; 3.818173; -35.224598;,
    -31.610003; -2.791675; -31.777426;,
    -44.400814; 9.149673; -35.224598;,
    -31.610003; -2.791675; -31.777426;,
    -38.532276; 12.712410; -35.224598;,
    -31.610003; -2.791675; -31.777426;,
    -38.532276; 12.712410; -35.224598;,
    -31.610003; 13.642806; -37.901264;,
    -31.610003; -2.791675; -31.777426;,
    -31.610003; 27.574799; -30.263584;,
    -18.819193; 25.262676; -30.263584;,
    -7.975472; 18.680563; -30.263584;,
    9.136147; 11.389935; -30.263584;,
    11.681479; -0.229933; -23.806112;,
    -0.730821; -14.412805; -23.806112;,
    -7.975472; -24.263912; -30.263584;,
    -18.819193; -30.846025; -30.263584;,
    -31.610003; -33.158150; -30.263584;,
    -44.614128; -21.646700; -30.263584;,
    -55.457848; -15.064587; -30.263584;,
    -62.490791; -14.412805; -30.263584;,
    -68.433105; -1.375909; -30.263584;,
    -65.889374; 10.565438; -27.586918;,
    -55.244534; 19.002041; -27.586918;,
    -44.400814; 25.584154; -27.586918;,
    -44.400814; 25.584154; -27.586918;,
    -31.610003; 13.642806; -37.901264;,
    -38.532276; 12.712410; -35.224598;,
    -31.610003; 27.574799; -30.263584;,
    -31.610003; 36.883804; -18.833143;,
    -14.897746; 33.863171; -18.833143;,
    -0.730821; 25.262676; -18.833143;,
    18.603754; 14.952673; -18.833143;,
    20.392061; -1.581403; -18.833143;,
    9.729577; -19.183292; -18.833143;,
    -0.538357; -33.888096; -18.833143;,
    -14.897746; -39.446518; -18.833143;,
    -31.823317; -33.267830; -18.833143;,
    -48.535576; -30.247192; -18.833143;,
    -62.702499; -21.646700; -18.833143;,
    -71.956795; -17.974281; -18.833143;,
    -78.680191; -1.375909; -18.833143;,
    -75.355377; 13.806697; -18.833143;,
    -62.490791; 25.262676; -18.833143;,
    -48.322262; 33.863171; -18.833143;,
    -48.322262; 33.863171; -18.833143;,
    -31.610003; 36.883804; -18.833143;,
    -31.610003; 40.152802; -5.349833;,
    -13.521631; 36.883804; -5.349833;,
    1.812907; 27.574799; -5.349833;,
    12.059990; 13.642806; -5.349833;,
    26.230124; -3.965386; -5.349833;,
    22.188389; -25.741453; -5.349833;,
    4.767223; -37.792480; -5.349833;,
    -13.521631; -42.467155; -5.349833;,
    -31.823317; -36.536823; -5.349833;,
    -49.911690; -33.267830; -5.349833;,
    -65.246231; -23.957561; -5.349833;,
    -75.281601; -19.226156; -5.349833;,
    -78.879066; -2.791675; -5.349833;,
    -75.281601; 13.642806; -5.349833;,
    -65.034515; 27.574799; -5.349833;,
    -49.699978; 36.883804; -5.349833;,
    -49.699978; 36.883804; -5.349833;,
    -31.610003; 40.152802; -5.349833;,
    -31.610003; 36.883804; 8.133478;,
    -14.897746; 33.863171; 8.133478;,
    -0.730821; 25.262676; 8.133478;,
    8.735182; 12.390931; 8.133478;,
    12.059990; -2.791675; 8.133478;,
    8.735182; -17.974281; 8.133478;,
    -0.730821; -30.846025; 8.133478;,
    -14.897746; -39.446518; 8.133478;,
    -31.610003; -42.467155; 8.133478;,
    -48.322262; -39.446518; 8.133478;,
    -62.490791; -30.846025; 8.133478;,
    -71.956795; -17.974281; 8.133478;,
    -75.281601; -2.791675; 8.133478;,
    -71.956795; 12.390931; 8.133478;,
    -65.456337; 25.262676; 14.250795;,
    -51.289406; 33.863171; 14.250795;,
    -51.289406; 33.863171; 14.250795;,
    -31.610003; 36.883804; 8.133478;,
    -34.577152; 27.574799; 25.681234;,
    -18.819193; 25.262676; 19.563917;,
    -7.975472; 18.680563; 19.563917;,
    -0.730821; 8.829454; 19.563917;,
    1.812907; -2.791675; 19.563917;,
    -0.730821; -14.412805; 19.563917;,
    -8.400496; -24.263912; 14.974571;,
    -19.244217; -30.846025; 14.974571;,
    -32.035027; -33.158150; 14.974571;,
    -44.824234; -30.846025; 14.974571;,
    -55.667953; -24.263912; 14.974571;,
    -62.490791; -14.412805; 19.563917;,
    -65.034515; -2.791675; 19.563917;,
    -65.456337; 8.829454; 25.681234;,
    -58.211681; 18.680563; 25.681234;,
    -47.367962; 25.262676; 25.681234;,
    -47.367962; 25.262676; 25.681234;,
    -34.577152; 27.574799; 25.681234;,
    -34.577152; 13.642806; 33.318916;,
    -24.687729; 12.390931; 27.201599;,
    -18.819193; 8.829454; 27.201599;,
    -14.897746; 3.497956; 27.201599;,
    -13.521631; -2.791675; 27.201599;,
    -14.897746; -9.081306; 27.201599;,
    -19.244217; -14.412805; 22.612253;,
    -25.111149; -17.974281; 22.612253;,
    -32.035027; -19.226156; 22.612253;,
    -38.957302; -17.974281; 22.612253;,
    -44.824234; -14.412805; 22.612253;,
    -48.322262; -9.081306; 27.201599;,
    -49.699978; -2.791675; 27.201599;,
    -51.289406; 3.497956; 33.318916;,
    -47.367962; 8.829454; 33.318916;,
    -41.499424; 12.390931; 33.318916;,
    -41.499424; 12.390931; 33.318916;,
    -34.577152; 13.642806; 33.318916;,
    -31.610003; -2.791675; 29.882612;,
    -31.610003; -2.791675; 29.882612;,
    -31.610003; -2.791675; 29.882612;,
    -31.610003; -2.791675; 29.882612;,
    -31.610003; -2.791675; 29.882612;,
    -31.610003; -2.791675; 29.882612;,
    -31.610003; -2.791675; 29.882612;,
    -31.610003; -2.791675; 29.882612;,
    -31.610003; -2.791675; 29.882612;,
    -31.610003; -2.791675; 29.882612;,
    -31.610003; -2.791675; 29.882612;,
    -31.610003; -2.791675; 29.882612;,
    -31.610003; -2.791675; 29.882612;,
    -31.610003; -2.791675; 29.882612;,
    -31.610003; -2.791675; 29.882612;,
    -31.610003; -2.791675; 29.882612;,
    -34.577152; 13.642806; 33.318916;,
    -41.499424; 12.390931; 33.318916;;
    224;
    3;0, 1, 2;,
    3;1, 3, 4;,
    3;3, 5, 6;,
    3;5, 7, 8;,
    3;7, 9, 10;,
    3;9, 11, 12;,
    3;11, 13, 14;,
    3;13, 15, 16;,
    3;15, 17, 18;,
    3;17, 19, 20;,
    3;19, 21, 22;,
    3;21, 23, 24;,
    3;23, 25, 26;,
    3;25, 27, 28;,
    3;27, 29, 30;,
    3;31, 32, 33;,
    3;34, 1, 0;,
    3;34, 35, 1;,
    3;35, 3, 1;,
    3;35, 36, 3;,
    3;36, 5, 3;,
    3;36, 37, 5;,
    3;37, 7, 5;,
    3;37, 38, 7;,
    3;38, 9, 7;,
    3;38, 39, 9;,
    3;39, 11, 9;,
    3;39, 40, 11;,
    3;40, 13, 11;,
    3;40, 41, 13;,
    3;41, 15, 13;,
    3;41, 42, 15;,
    3;42, 17, 15;,
    3;42, 43, 17;,
    3;43, 19, 17;,
    3;43, 44, 19;,
    3;44, 21, 19;,
    3;44, 45, 21;,
    3;45, 23, 21;,
    3;45, 46, 23;,
    3;46, 25, 23;,
    3;46, 47, 25;,
    3;47, 27, 25;,
    3;47, 48, 27;,
    3;48, 29, 27;,
    3;48, 49, 29;,
    3;50, 51, 52;,
    3;50, 53, 51;,
    3;54, 35, 34;,
    3;54, 55, 35;,
    3;55, 36, 35;,
    3;55, 56, 36;,
    3;56, 37, 36;,
    3;56, 57, 37;,
    3;57, 38, 37;,
    3;57, 58, 38;,
    3;58, 39, 38;,
    3;58, 59, 39;,
    3;59, 40, 39;,
    3;59, 60, 40;,
    3;60, 41, 40;,
    3;60, 61, 41;,
    3;61, 42, 41;,
    3;61, 62, 42;,
    3;62, 43, 42;,
    3;62, 63, 43;,
    3;63, 44, 43;,
    3;63, 64, 44;,
    3;64, 45, 44;,
    3;64, 65, 45;,
    3;65, 46, 45;,
    3;65, 66, 46;,
    3;66, 47, 46;,
    3;66, 67, 47;,
    3;67, 48, 47;,
    3;67, 68, 48;,
    3;68, 49, 48;,
    3;68, 69, 49;,
    3;70, 53, 50;,
    3;70, 71, 53;,
    3;72, 55, 54;,
    3;72, 73, 55;,
    3;73, 56, 55;,
    3;73, 74, 56;,
    3;74, 57, 56;,
    3;74, 75, 57;,
    3;75, 58, 57;,
    3;75, 76, 58;,
    3;76, 59, 58;,
    3;76, 77, 59;,
    3;77, 60, 59;,
    3;77, 78, 60;,
    3;78, 61, 60;,
    3;78, 79, 61;,
    3;79, 62, 61;,
    3;79, 80, 62;,
    3;80, 63, 62;,
    3;80, 81, 63;,
    3;81, 64, 63;,
    3;81, 82, 64;,
    3;82, 65, 64;,
    3;82, 83, 65;,
    3;83, 66, 65;,
    3;83, 84, 66;,
    3;84, 67, 66;,
    3;84, 85, 67;,
    3;85, 68, 67;,
    3;85, 86, 68;,
    3;86, 69, 68;,
    3;86, 87, 69;,
    3;88, 71, 70;,
    3;88, 89, 71;,
    3;90, 73, 72;,
    3;90, 91, 73;,
    3;91, 74, 73;,
    3;91, 92, 74;,
    3;92, 75, 74;,
    3;92, 93, 75;,
    3;93, 76, 75;,
    3;93, 94, 76;,
    3;94, 77, 76;,
    3;94, 95, 77;,
    3;95, 78, 77;,
    3;95, 96, 78;,
    3;96, 79, 78;,
    3;96, 97, 79;,
    3;97, 80, 79;,
    3;97, 98, 80;,
    3;98, 81, 80;,
    3;98, 99, 81;,
    3;99, 82, 81;,
    3;99, 100, 82;,
    3;100, 83, 82;,
    3;100, 101, 83;,
    3;101, 84, 83;,
    3;101, 102, 84;,
    3;102, 85, 84;,
    3;102, 103, 85;,
    3;103, 86, 85;,
    3;103, 104, 86;,
    3;104, 87, 86;,
    3;104, 105, 87;,
    3;106, 89, 88;,
    3;106, 107, 89;,
    3;108, 91, 90;,
    3;108, 109, 91;,
    3;109, 92, 91;,
    3;109, 110, 92;,
    3;110, 93, 92;,
    3;110, 111, 93;,
    3;111, 94, 93;,
    3;111, 112, 94;,
    3;112, 95, 94;,
    3;112, 113, 95;,
    3;113, 96, 95;,
    3;113, 114, 96;,
    3;114, 97, 96;,
    3;114, 115, 97;,
    3;115, 98, 97;,
    3;115, 116, 98;,
    3;116, 99, 98;,
    3;116, 117, 99;,
    3;117, 100, 99;,
    3;117, 118, 100;,
    3;118, 101, 100;,
    3;118, 119, 101;,
    3;119, 102, 101;,
    3;119, 120, 102;,
    3;120, 103, 102;,
    3;120, 121, 103;,
    3;121, 104, 103;,
    3;121, 122, 104;,
    3;122, 105, 104;,
    3;122, 123, 105;,
    3;124, 107, 106;,
    3;124, 125, 107;,
    3;126, 109, 108;,
    3;126, 127, 109;,
    3;127, 110, 109;,
    3;127, 128, 110;,
    3;128, 111, 110;,
    3;128, 129, 111;,
    3;129, 112, 111;,
    3;129, 130, 112;,
    3;130, 113, 112;,
    3;130, 131, 113;,
    3;131, 114, 113;,
    3;131, 132, 114;,
    3;132, 115, 114;,
    3;132, 133, 115;,
    3;133, 116, 115;,
    3;133, 134, 116;,
    3;134, 117, 116;,
    3;134, 135, 117;,
    3;135, 118, 117;,
    3;135, 136, 118;,
    3;136, 119, 118;,
    3;136, 137, 119;,
    3;137, 120, 119;,
    3;137, 138, 120;,
    3;138, 121, 120;,
    3;138, 139, 121;,
    3;139, 122, 121;,
    3;139, 140, 122;,
    3;140, 123, 122;,
    3;140, 141, 123;,
    3;142, 125, 124;,
    3;142, 143, 125;,
    3;144, 127, 126;,
    3;145, 128, 127;,
    3;146, 129, 128;,
    3;147, 130, 129;,
    3;148, 131, 130;,
    3;149, 132, 131;,
    3;150, 133, 132;,
    3;151, 134, 133;,
    3;152, 135, 134;,
    3;153, 136, 135;,
    3;154, 137, 136;,
    3;155, 138, 137;,
    3;156, 139, 138;,
    3;157, 140, 139;,
    3;158, 141, 140;,
    3;159, 160, 161;;

   MeshNormals {
    162;
    0.013006; 0.071918; -0.997326;,
    0.039062; 0.158188; -0.986636;,
    -0.063021; -0.348474; -0.935197;,
    0.240616; -0.033333; -0.970048;,
    -0.179842; -0.296341; -0.937997;,
    0.229773; -0.239344; -0.943355;,
    0.106773; -0.552964; -0.826336;,
    0.177535; -0.230430; -0.956757;,
    0.017282; -0.348944; -0.936984;,
    0.267340; -0.008273; -0.963567;,
    0.018441; -0.004035; -0.999822;,
    0.380084; 0.253161; -0.889633;,
    0.135933; 0.311298; -0.940540;,
    0.231693; 0.032446; -0.972248;,
    0.299227; 0.471112; -0.829769;,
    0.019015; -0.162493; -0.986526;,
    -0.063021; 0.348474; -0.935197;,
    -0.174203; -0.248136; -0.952933;,
    0.063021; 0.348474; -0.935197;,
    -0.205569; -0.286246; -0.935844;,
    0.179842; 0.296341; -0.937997;,
    -0.100289; -0.220809; -0.970147;,
    0.270343; 0.198844; -0.942006;,
    -0.113694; 0.112370; -0.987141;,
    0.319859; 0.070064; -0.944871;,
    -0.097842; 0.231968; -0.967790;,
    0.305680; 0.301952; -0.902987;,
    -0.124488; 0.151475; -0.980591;,
    0.156731; -0.115279; -0.980891;,
    -0.137959; 0.227267; -0.964011;,
    0.104040; -0.171374; -0.979697;,
    -0.300799; -0.332998; -0.893662;,
    -0.300799; -0.332998; -0.893662;,
    -0.300799; -0.332998; -0.893662;,
    0.105746; 0.584918; -0.804169;,
    0.215664; 0.597298; -0.772480;,
    0.373589; 0.454683; -0.808514;,
    0.415894; 0.154486; -0.896196;,
    0.459063; -0.217836; -0.861283;,
    0.440302; -0.076776; -0.894561;,
    0.467923; -0.138794; -0.872803;,
    0.203241; -0.585277; -0.784948;,
    -0.261826; -0.763588; -0.590237;,
    -0.434752; -0.705722; -0.559416;,
    -0.319131; -0.677361; -0.662825;,
    -0.359985; -0.542797; -0.758803;,
    -0.557360; 0.036068; -0.829487;,
    -0.464464; 0.320501; -0.825562;,
    -0.344338; 0.479489; -0.807169;,
    -0.324846; 0.535163; -0.779792;,
    -0.296856; 0.488544; -0.820489;,
    -0.315645; 0.403642; -0.858744;,
    -0.378594; 0.338535; -0.861430;,
    -0.216331; 0.634417; -0.742102;,
    0.153506; 0.849270; -0.505149;,
    0.310287; 0.837490; -0.449814;,
    0.437640; 0.790808; -0.427894;,
    0.828548; 0.467586; -0.308012;,
    0.794043; -0.060462; -0.604847;,
    0.604507; -0.247233; -0.757263;,
    0.453395; -0.640429; -0.619907;,
    0.055905; -0.926739; -0.371522;,
    -0.339331; -0.913646; -0.223843;,
    -0.310287; -0.837490; -0.449814;,
    -0.370906; -0.834418; -0.407645;,
    -0.615809; -0.646619; -0.450181;,
    -0.904393; -0.039646; -0.424855;,
    -0.791656; 0.453942; -0.408921;,
    -0.555785; 0.684499; -0.471767;,
    -0.472520; 0.778411; -0.413280;,
    -0.194014; 0.816251; -0.544144;,
    -0.165144; 0.913759; -0.371175;,
    0.177289; 0.980960; -0.079285;,
    0.354216; 0.935163; -0.000945;,
    0.611315; 0.782901; 0.115587;,
    0.818583; 0.522971; 0.237535;,
    0.986441; 0.146075; 0.074807;,
    0.853962; -0.513750; 0.082522;,
    0.466245; -0.872829; 0.144170;,
    0.002907; -0.998474; 0.055143;,
    -0.163447; -0.960678; -0.224460;,
    -0.339579; -0.888945; -0.307347;,
    -0.446320; -0.852553; -0.271941;,
    -0.817549; -0.572605; -0.061138;,
    -0.991953; 0.001213; 0.126604;,
    -0.892301; 0.441965; 0.092005;,
    -0.695731; 0.715650; -0.061677;,
    -0.518829; 0.854647; -0.019880;,
    -0.176738; 0.977968; -0.111097;,
    -0.144736; 0.988339; 0.047296;,
    0.168598; 0.932839; 0.318412;,
    0.359245; 0.831378; 0.423973;,
    0.604204; 0.651074; 0.459391;,
    0.726359; 0.415760; 0.547308;,
    0.713755; 0.007017; 0.700360;,
    0.652407; -0.339748; 0.677449;,
    0.446740; -0.642645; 0.622439;,
    0.213592; -0.846196; 0.488191;,
    -0.012719; -0.964876; 0.262399;,
    -0.352560; -0.889715; 0.290016;,
    -0.557820; -0.726383; 0.401503;,
    -0.778213; -0.377449; 0.501913;,
    -0.879057; 0.008031; 0.476650;,
    -0.909063; 0.254875; 0.329612;,
    -0.692902; 0.636249; 0.339226;,
    -0.457650; 0.753884; 0.471398;,
    -0.066184; 0.942295; 0.328176;,
    -0.059899; 0.901592; 0.428421;,
    0.303435; 0.684416; 0.662949;,
    0.394063; 0.528838; 0.751694;,
    0.426984; 0.453854; 0.782113;,
    0.560293; 0.242960; 0.791860;,
    0.605335; -0.010932; 0.795896;,
    0.470029; -0.333110; 0.817380;,
    0.214878; -0.528579; 0.821238;,
    0.183770; -0.497235; 0.847931;,
    -0.003617; -0.538119; 0.842861;,
    -0.192857; -0.500399; 0.844042;,
    -0.325792; -0.474621; 0.817676;,
    -0.478495; -0.399353; 0.782023;,
    -0.652075; -0.146163; 0.743932;,
    -0.723049; -0.057229; 0.688422;,
    -0.412699; 0.467393; 0.781808;,
    -0.303876; 0.500649; 0.810561;,
    -0.064863; 0.750253; 0.657961;,
    -0.115588; 0.639361; 0.760169;,
    0.489360; 0.205026; 0.847638;,
    0.337086; 0.229348; 0.913112;,
    0.244269; 0.240921; 0.939303;,
    0.311017; 0.120307; 0.942759;,
    0.329703; -0.019716; 0.943879;,
    0.144989; -0.407026; 0.901836;,
    0.116888; -0.489870; 0.863924;,
    0.141601; -0.425449; 0.893836;,
    -0.017279; -0.450556; 0.892581;,
    -0.172956; -0.409117; 0.895941;,
    -0.126520; -0.519480; 0.845064;,
    -0.226372; -0.328345; 0.917031;,
    -0.349515; -0.413822; 0.840589;,
    -0.291372; -0.213557; 0.932468;,
    -0.134050; 0.175570; 0.975298;,
    -0.080209; 0.132168; 0.987977;,
    -0.086588; 0.478901; 0.873588;,
    -0.086609; 0.478908; 0.873582;,
    0.516361; -0.084951; 0.852147;,
    0.082862; 0.136538; 0.987163;,
    0.124142; 0.091309; 0.988054;,
    0.146540; 0.032062; 0.988685;,
    0.146540; -0.032062; 0.988685;,
    -0.099201; -0.601484; 0.792702;,
    0.210832; -0.347310; 0.913743;,
    0.073237; -0.405062; 0.911351;,
    -0.072687; -0.401922; 0.912785;,
    -0.206186; -0.339657; 0.917671;,
    0.103125; -0.609182; 0.786297;,
    -0.146528; -0.032096; 0.988686;,
    -0.103708; -0.706803; 0.699767;,
    0.139251; -0.102422; 0.984946;,
    0.096716; -0.159367; 0.982471;,
    0.035867; -0.198325; 0.979480;,
    0.035867; -0.198325; 0.979480;,
    0.035867; -0.198325; 0.979480;;
    224;
    3;0, 1, 2;,
    3;1, 3, 4;,
    3;3, 5, 6;,
    3;5, 7, 8;,
    3;7, 9, 10;,
    3;9, 11, 12;,
    3;11, 13, 14;,
    3;13, 15, 16;,
    3;15, 17, 18;,
    3;17, 19, 20;,
    3;19, 21, 22;,
    3;21, 23, 24;,
    3;23, 25, 26;,
    3;25, 27, 28;,
    3;27, 29, 30;,
    3;31, 32, 33;,
    3;34, 1, 0;,
    3;34, 35, 1;,
    3;35, 3, 1;,
    3;35, 36, 3;,
    3;36, 5, 3;,
    3;36, 37, 5;,
    3;37, 7, 5;,
    3;37, 38, 7;,
    3;38, 9, 7;,
    3;38, 39, 9;,
    3;39, 11, 9;,
    3;39, 40, 11;,
    3;40, 13, 11;,
    3;40, 41, 13;,
    3;41, 15, 13;,
    3;41, 42, 15;,
    3;42, 17, 15;,
    3;42, 43, 17;,
    3;43, 19, 17;,
    3;43, 44, 19;,
    3;44, 21, 19;,
    3;44, 45, 21;,
    3;45, 23, 21;,
    3;45, 46, 23;,
    3;46, 25, 23;,
    3;46, 47, 25;,
    3;47, 27, 25;,
    3;47, 48, 27;,
    3;48, 29, 27;,
    3;48, 49, 29;,
    3;50, 51, 52;,
    3;50, 53, 51;,
    3;54, 35, 34;,
    3;54, 55, 35;,
    3;55, 36, 35;,
    3;55, 56, 36;,
    3;56, 37, 36;,
    3;56, 57, 37;,
    3;57, 38, 37;,
    3;57, 58, 38;,
    3;58, 39, 38;,
    3;58, 59, 39;,
    3;59, 40, 39;,
    3;59, 60, 40;,
    3;60, 41, 40;,
    3;60, 61, 41;,
    3;61, 42, 41;,
    3;61, 62, 42;,
    3;62, 43, 42;,
    3;62, 63, 43;,
    3;63, 44, 43;,
    3;63, 64, 44;,
    3;64, 45, 44;,
    3;64, 65, 45;,
    3;65, 46, 45;,
    3;65, 66, 46;,
    3;66, 47, 46;,
    3;66, 67, 47;,
    3;67, 48, 47;,
    3;67, 68, 48;,
    3;68, 49, 48;,
    3;68, 69, 49;,
    3;70, 53, 50;,
    3;70, 71, 53;,
    3;72, 55, 54;,
    3;72, 73, 55;,
    3;73, 56, 55;,
    3;73, 74, 56;,
    3;74, 57, 56;,
    3;74, 75, 57;,
    3;75, 58, 57;,
    3;75, 76, 58;,
    3;76, 59, 58;,
    3;76, 77, 59;,
    3;77, 60, 59;,
    3;77, 78, 60;,
    3;78, 61, 60;,
    3;78, 79, 61;,
    3;79, 62, 61;,
    3;79, 80, 62;,
    3;80, 63, 62;,
    3;80, 81, 63;,
    3;81, 64, 63;,
    3;81, 82, 64;,
    3;82, 65, 64;,
    3;82, 83, 65;,
    3;83, 66, 65;,
    3;83, 84, 66;,
    3;84, 67, 66;,
    3;84, 85, 67;,
    3;85, 68, 67;,
    3;85, 86, 68;,
    3;86, 69, 68;,
    3;86, 87, 69;,
    3;88, 71, 70;,
    3;88, 89, 71;,
    3;90, 73, 72;,
    3;90, 91, 73;,
    3;91, 74, 73;,
    3;91, 92, 74;,
    3;92, 75, 74;,
    3;92, 93, 75;,
    3;93, 76, 75;,
    3;93, 94, 76;,
    3;94, 77, 76;,
    3;94, 95, 77;,
    3;95, 78, 77;,
    3;95, 96, 78;,
    3;96, 79, 78;,
    3;96, 97, 79;,
    3;97, 80, 79;,
    3;97, 98, 80;,
    3;98, 81, 80;,
    3;98, 99, 81;,
    3;99, 82, 81;,
    3;99, 100, 82;,
    3;100, 83, 82;,
    3;100, 101, 83;,
    3;101, 84, 83;,
    3;101, 102, 84;,
    3;102, 85, 84;,
    3;102, 103, 85;,
    3;103, 86, 85;,
    3;103, 104, 86;,
    3;104, 87, 86;,
    3;104, 105, 87;,
    3;106, 89, 88;,
    3;106, 107, 89;,
    3;108, 91, 90;,
    3;108, 109, 91;,
    3;109, 92, 91;,
    3;109, 110, 92;,
    3;110, 93, 92;,
    3;110, 111, 93;,
    3;111, 94, 93;,
    3;111, 112, 94;,
    3;112, 95, 94;,
    3;112, 113, 95;,
    3;113, 96, 95;,
    3;113, 114, 96;,
    3;114, 97, 96;,
    3;114, 115, 97;,
    3;115, 98, 97;,
    3;115, 116, 98;,
    3;116, 99, 98;,
    3;116, 117, 99;,
    3;117, 100, 99;,
    3;117, 118, 100;,
    3;118, 101, 100;,
    3;118, 119, 101;,
    3;119, 102, 101;,
    3;119, 120, 102;,
    3;120, 103, 102;,
    3;120, 121, 103;,
    3;121, 104, 103;,
    3;121, 122, 104;,
    3;122, 105, 104;,
    3;122, 123, 105;,
    3;124, 107, 106;,
    3;124, 125, 107;,
    3;126, 109, 108;,
    3;126, 127, 109;,
    3;127, 110, 109;,
    3;127, 128, 110;,
    3;128, 111, 110;,
    3;128, 129, 111;,
    3;129, 112, 111;,
    3;129, 130, 112;,
    3;130, 113, 112;,
    3;130, 131, 113;,
    3;131, 114, 113;,
    3;131, 132, 114;,
    3;132, 115, 114;,
    3;132, 133, 115;,
    3;133, 116, 115;,
    3;133, 134, 116;,
    3;134, 117, 116;,
    3;134, 135, 117;,
    3;135, 118, 117;,
    3;135, 136, 118;,
    3;136, 119, 118;,
    3;136, 137, 119;,
    3;137, 120, 119;,
    3;137, 138, 120;,
    3;138, 121, 120;,
    3;138, 139, 121;,
    3;139, 122, 121;,
    3;139, 140, 122;,
    3;140, 123, 122;,
    3;140, 141, 123;,
    3;142, 125, 124;,
    3;142, 143, 125;,
    3;144, 127, 126;,
    3;145, 128, 127;,
    3;146, 129, 128;,
    3;147, 130, 129;,
    3;148, 131, 130;,
    3;149, 132, 131;,
    3;150, 133, 132;,
    3;151, 134, 133;,
    3;152, 135, 134;,
    3;153, 136, 135;,
    3;154, 137, 136;,
    3;155, 138, 137;,
    3;156, 139, 138;,
    3;157, 140, 139;,
    3;158, 141, 140;,
    3;159, 160, 161;;
   }

   MeshTextureCoords {
    162;
    0.000000; 0.875000;,
    0.062500; 0.875000;,
    0.031250; 1.000000;,
    0.125000; 0.875000;,
    0.093750; 1.000000;,
    0.187500; 0.875000;,
    0.156250; 1.000000;,
    0.250000; 0.875000;,
    0.218750; 1.000000;,
    0.312500; 0.875000;,
    0.281250; 1.000000;,
    0.375000; 0.875000;,
    0.343750; 1.000000;,
    0.437500; 0.875000;,
    0.406250; 1.000000;,
    0.500000; 0.875000;,
    0.468750; 1.000000;,
    0.562500; 0.875000;,
    0.531250; 1.000000;,
    0.625000; 0.875000;,
    0.593750; 1.000000;,
    0.687500; 0.875000;,
    0.656250; 1.000000;,
    0.750000; 0.875000;,
    0.718750; 1.000000;,
    0.812500; 0.875000;,
    0.781250; 1.000000;,
    0.875000; 0.875000;,
    0.843750; 1.000000;,
    0.937500; 0.875000;,
    0.906250; 1.000000;,
    0.904297; 0.886719;,
    0.990234; 0.886719;,
    0.982422; 0.988281;,
    0.000000; 0.750000;,
    0.062500; 0.750000;,
    0.125000; 0.750000;,
    0.187500; 0.750000;,
    0.250000; 0.750000;,
    0.312500; 0.750000;,
    0.375000; 0.750000;,
    0.437500; 0.750000;,
    0.500000; 0.750000;,
    0.562500; 0.750000;,
    0.625000; 0.750000;,
    0.687500; 0.750000;,
    0.750000; 0.750000;,
    0.812500; 0.750000;,
    0.875000; 0.750000;,
    0.937500; 0.750000;,
    0.937500; 0.867188;,
    0.970703; 1.000000;,
    0.927734; 0.960938;,
    0.994141; 0.878906;,
    0.000000; 0.625000;,
    0.062500; 0.625000;,
    0.125000; 0.625000;,
    0.187500; 0.625000;,
    0.250000; 0.625000;,
    0.312500; 0.625000;,
    0.375000; 0.625000;,
    0.437500; 0.625000;,
    0.500000; 0.625000;,
    0.562500; 0.625000;,
    0.625000; 0.625000;,
    0.687500; 0.625000;,
    0.750000; 0.625000;,
    0.812500; 0.625000;,
    0.875000; 0.625000;,
    0.937500; 0.625000;,
    0.935547; 0.753906;,
    0.994141; 0.761719;,
    0.000000; 0.500000;,
    0.062500; 0.500000;,
    0.125000; 0.500000;,
    0.187500; 0.500000;,
    0.250000; 0.500000;,
    0.312500; 0.500000;,
    0.375000; 0.500000;,
    0.437500; 0.500000;,
    0.500000; 0.500000;,
    0.562500; 0.500000;,
    0.625000; 0.500000;,
    0.687500; 0.500000;,
    0.750000; 0.500000;,
    0.812500; 0.500000;,
    0.875000; 0.500000;,
    0.937500; 0.500000;,
    0.935547; 0.621094;,
    0.994141; 0.621094;,
    0.000000; 0.375000;,
    0.062500; 0.375000;,
    0.125000; 0.375000;,
    0.187500; 0.375000;,
    0.250000; 0.375000;,
    0.312500; 0.375000;,
    0.375000; 0.375000;,
    0.437500; 0.375000;,
    0.500000; 0.375000;,
    0.562500; 0.375000;,
    0.625000; 0.375000;,
    0.687500; 0.375000;,
    0.750000; 0.375000;,
    0.812500; 0.375000;,
    0.875000; 0.375000;,
    0.937500; 0.375000;,
    0.941406; 0.503906;,
    0.994141; 0.500000;,
    0.000000; 0.250000;,
    0.062500; 0.250000;,
    0.125000; 0.250000;,
    0.187500; 0.250000;,
    0.250000; 0.250000;,
    0.312500; 0.250000;,
    0.375000; 0.250000;,
    0.437500; 0.250000;,
    0.500000; 0.250000;,
    0.562500; 0.250000;,
    0.625000; 0.250000;,
    0.687500; 0.250000;,
    0.750000; 0.250000;,
    0.812500; 0.250000;,
    0.875000; 0.250000;,
    0.937500; 0.250000;,
    0.933594; 0.375000;,
    0.992188; 0.375000;,
    0.000000; 0.125000;,
    0.062500; 0.125000;,
    0.125000; 0.125000;,
    0.187500; 0.125000;,
    0.250000; 0.125000;,
    0.312500; 0.125000;,
    0.375000; 0.125000;,
    0.437500; 0.125000;,
    0.500000; 0.125000;,
    0.562500; 0.125000;,
    0.625000; 0.125000;,
    0.687500; 0.125000;,
    0.750000; 0.125000;,
    0.812500; 0.125000;,
    0.875000; 0.125000;,
    0.937500; 0.125000;,
    0.939453; 0.250000;,
    0.992188; 0.250000;,
    0.031250; 0.000000;,
    0.093750; 0.000000;,
    0.156250; 0.000000;,
    0.218750; 0.000000;,
    0.281250; 0.000000;,
    0.343750; 0.000000;,
    0.406250; 0.000000;,
    0.468750; 0.000000;,
    0.531250; 0.000000;,
    0.593750; 0.000000;,
    0.656250; 0.000000;,
    0.718750; 0.000000;,
    0.781250; 0.000000;,
    0.843750; 0.000000;,
    0.906250; 0.000000;,
    0.939453; 0.261719;,
    0.937500; 0.117188;,
    0.996094; 0.117188;;
   }

   MeshVertexColors {
    162;
    0; 1.000000; 1.000000; 1.000000; 1.000000;,
    1; 1.000000; 1.000000; 1.000000; 1.000000;,
    2; 1.000000; 1.000000; 1.000000; 1.000000;,
    3; 1.000000; 1.000000; 1.000000; 1.000000;,
    4; 1.000000; 1.000000; 1.000000; 1.000000;,
    5; 1.000000; 1.000000; 1.000000; 1.000000;,
    6; 1.000000; 1.000000; 1.000000; 1.000000;,
    7; 1.000000; 1.000000; 1.000000; 1.000000;,
    8; 1.000000; 1.000000; 1.000000; 1.000000;,
    9; 1.000000; 1.000000; 1.000000; 1.000000;,
    10; 1.000000; 1.000000; 1.000000; 1.000000;,
    11; 1.000000; 1.000000; 1.000000; 1.000000;,
    12; 1.000000; 1.000000; 1.000000; 1.000000;,
    13; 1.000000; 1.000000; 1.000000; 1.000000;,
    14; 1.000000; 1.000000; 1.000000; 1.000000;,
    15; 1.000000; 1.000000; 1.000000; 1.000000;,
    16; 1.000000; 1.000000; 1.000000; 1.000000;,
    17; 1.000000; 1.000000; 1.000000; 1.000000;,
    18; 1.000000; 1.000000; 1.000000; 1.000000;,
    19; 1.000000; 1.000000; 1.000000; 1.000000;,
    20; 1.000000; 1.000000; 1.000000; 1.000000;,
    21; 1.000000; 1.000000; 1.000000; 1.000000;,
    22; 1.000000; 1.000000; 1.000000; 1.000000;,
    23; 1.000000; 1.000000; 1.000000; 1.000000;,
    24; 1.000000; 1.000000; 1.000000; 1.000000;,
    25; 1.000000; 1.000000; 1.000000; 1.000000;,
    26; 1.000000; 1.000000; 1.000000; 1.000000;,
    27; 1.000000; 1.000000; 1.000000; 1.000000;,
    28; 1.000000; 1.000000; 1.000000; 1.000000;,
    29; 1.000000; 1.000000; 1.000000; 1.000000;,
    30; 1.000000; 1.000000; 1.000000; 1.000000;,
    31; 1.000000; 1.000000; 1.000000; 1.000000;,
    32; 1.000000; 1.000000; 1.000000; 1.000000;,
    33; 1.000000; 1.000000; 1.000000; 1.000000;,
    34; 1.000000; 1.000000; 1.000000; 1.000000;,
    35; 1.000000; 1.000000; 1.000000; 1.000000;,
    36; 1.000000; 1.000000; 1.000000; 1.000000;,
    37; 1.000000; 1.000000; 1.000000; 1.000000;,
    38; 1.000000; 1.000000; 1.000000; 1.000000;,
    39; 1.000000; 1.000000; 1.000000; 1.000000;,
    40; 1.000000; 1.000000; 1.000000; 1.000000;,
    41; 1.000000; 1.000000; 1.000000; 1.000000;,
    42; 1.000000; 1.000000; 1.000000; 1.000000;,
    43; 1.000000; 1.000000; 1.000000; 1.000000;,
    44; 1.000000; 1.000000; 1.000000; 1.000000;,
    45; 1.000000; 1.000000; 1.000000; 1.000000;,
    46; 1.000000; 1.000000; 1.000000; 1.000000;,
    47; 1.000000; 1.000000; 1.000000; 1.000000;,
    48; 1.000000; 1.000000; 1.000000; 1.000000;,
    49; 1.000000; 1.000000; 1.000000; 1.000000;,
    50; 1.000000; 1.000000; 1.000000; 1.000000;,
    51; 1.000000; 1.000000; 1.000000; 1.000000;,
    52; 1.000000; 1.000000; 1.000000; 1.000000;,
    53; 1.000000; 1.000000; 1.000000; 1.000000;,
    54; 1.000000; 1.000000; 1.000000; 1.000000;,
    55; 1.000000; 1.000000; 1.000000; 1.000000;,
    56; 1.000000; 1.000000; 1.000000; 1.000000;,
    57; 1.000000; 1.000000; 1.000000; 1.000000;,
    58; 1.000000; 1.000000; 1.000000; 1.000000;,
    59; 1.000000; 1.000000; 1.000000; 1.000000;,
    60; 1.000000; 1.000000; 1.000000; 1.000000;,
    61; 1.000000; 1.000000; 1.000000; 1.000000;,
    62; 1.000000; 1.000000; 1.000000; 1.000000;,
    63; 1.000000; 1.000000; 1.000000; 1.000000;,
    64; 1.000000; 1.000000; 1.000000; 1.000000;,
    65; 1.000000; 1.000000; 1.000000; 1.000000;,
    66; 1.000000; 1.000000; 1.000000; 1.000000;,
    67; 1.000000; 1.000000; 1.000000; 1.000000;,
    68; 1.000000; 1.000000; 1.000000; 1.000000;,
    69; 1.000000; 1.000000; 1.000000; 1.000000;,
    70; 1.000000; 1.000000; 1.000000; 1.000000;,
    71; 1.000000; 1.000000; 1.000000; 1.000000;,
    72; 1.000000; 1.000000; 1.000000; 1.000000;,
    73; 1.000000; 1.000000; 1.000000; 1.000000;,
    74; 1.000000; 1.000000; 1.000000; 1.000000;,
    75; 1.000000; 1.000000; 1.000000; 1.000000;,
    76; 1.000000; 1.000000; 1.000000; 1.000000;,
    77; 1.000000; 1.000000; 1.000000; 1.000000;,
    78; 1.000000; 1.000000; 1.000000; 1.000000;,
    79; 1.000000; 1.000000; 1.000000; 1.000000;,
    80; 1.000000; 1.000000; 1.000000; 1.000000;,
    81; 1.000000; 1.000000; 1.000000; 1.000000;,
    82; 1.000000; 1.000000; 1.000000; 1.000000;,
    83; 1.000000; 1.000000; 1.000000; 1.000000;,
    84; 1.000000; 1.000000; 1.000000; 1.000000;,
    85; 1.000000; 1.000000; 1.000000; 1.000000;,
    86; 1.000000; 1.000000; 1.000000; 1.000000;,
    87; 1.000000; 1.000000; 1.000000; 1.000000;,
    88; 1.000000; 1.000000; 1.000000; 1.000000;,
    89; 1.000000; 1.000000; 1.000000; 1.000000;,
    90; 1.000000; 1.000000; 1.000000; 1.000000;,
    91; 1.000000; 1.000000; 1.000000; 1.000000;,
    92; 1.000000; 1.000000; 1.000000; 1.000000;,
    93; 1.000000; 1.000000; 1.000000; 1.000000;,
    94; 1.000000; 1.000000; 1.000000; 1.000000;,
    95; 1.000000; 1.000000; 1.000000; 1.000000;,
    96; 1.000000; 1.000000; 1.000000; 1.000000;,
    97; 1.000000; 1.000000; 1.000000; 1.000000;,
    98; 1.000000; 1.000000; 1.000000; 1.000000;,
    99; 1.000000; 1.000000; 1.000000; 1.000000;,
    100; 1.000000; 1.000000; 1.000000; 1.000000;,
    101; 1.000000; 1.000000; 1.000000; 1.000000;,
    102; 1.000000; 1.000000; 1.000000; 1.000000;,
    103; 1.000000; 1.000000; 1.000000; 1.000000;,
    104; 1.000000; 1.000000; 1.000000; 1.000000;,
    105; 1.000000; 1.000000; 1.000000; 1.000000;,
    106; 1.000000; 1.000000; 1.000000; 1.000000;,
    107; 1.000000; 1.000000; 1.000000; 1.000000;,
    108; 1.000000; 1.000000; 1.000000; 1.000000;,
    109; 1.000000; 1.000000; 1.000000; 1.000000;,
    110; 1.000000; 1.000000; 1.000000; 1.000000;,
    111; 1.000000; 1.000000; 1.000000; 1.000000;,
    112; 1.000000; 1.000000; 1.000000; 1.000000;,
    113; 1.000000; 1.000000; 1.000000; 1.000000;,
    114; 1.000000; 1.000000; 1.000000; 1.000000;,
    115; 1.000000; 1.000000; 1.000000; 1.000000;,
    116; 1.000000; 1.000000; 1.000000; 1.000000;,
    117; 1.000000; 1.000000; 1.000000; 1.000000;,
    118; 1.000000; 1.000000; 1.000000; 1.000000;,
    119; 1.000000; 1.000000; 1.000000; 1.000000;,
    120; 1.000000; 1.000000; 1.000000; 1.000000;,
    121; 1.000000; 1.000000; 1.000000; 1.000000;,
    122; 1.000000; 1.000000; 1.000000; 1.000000;,
    123; 1.000000; 1.000000; 1.000000; 1.000000;,
    124; 1.000000; 1.000000; 1.000000; 1.000000;,
    125; 1.000000; 1.000000; 1.000000; 1.000000;,
    126; 1.000000; 1.000000; 1.000000; 1.000000;,
    127; 1.000000; 1.000000; 1.000000; 1.000000;,
    128; 1.000000; 1.000000; 1.000000; 1.000000;,
    129; 1.000000; 1.000000; 1.000000; 1.000000;,
    130; 1.000000; 1.000000; 1.000000; 1.000000;,
    131; 1.000000; 1.000000; 1.000000; 1.000000;,
    132; 1.000000; 1.000000; 1.000000; 1.000000;,
    133; 1.000000; 1.000000; 1.000000; 1.000000;,
    134; 1.000000; 1.000000; 1.000000; 1.000000;,
    135; 1.000000; 1.000000; 1.000000; 1.000000;,
    136; 1.000000; 1.000000; 1.000000; 1.000000;,
    137; 1.000000; 1.000000; 1.000000; 1.000000;,
    138; 1.000000; 1.000000; 1.000000; 1.000000;,
    139; 1.000000; 1.000000; 1.000000; 1.000000;,
    140; 1.000000; 1.000000; 1.000000; 1.000000;,
    141; 1.000000; 1.000000; 1.000000; 1.000000;,
    142; 1.000000; 1.000000; 1.000000; 1.000000;,
    143; 1.000000; 1.000000; 1.000000; 1.000000;,
    144; 1.000000; 1.000000; 1.000000; 1.000000;,
    145; 1.000000; 1.000000; 1.000000; 1.000000;,
    146; 1.000000; 1.000000; 1.000000; 1.000000;,
    147; 1.000000; 1.000000; 1.000000; 1.000000;,
    148; 1.000000; 1.000000; 1.000000; 1.000000;,
    149; 1.000000; 1.000000; 1.000000; 1.000000;,
    150; 1.000000; 1.000000; 1.000000; 1.000000;,
    151; 1.000000; 1.000000; 1.000000; 1.000000;,
    152; 1.000000; 1.000000; 1.000000; 1.000000;,
    153; 1.000000; 1.000000; 1.000000; 1.000000;,
    154; 1.000000; 1.000000; 1.000000; 1.000000;,
    155; 1.000000; 1.000000; 1.000000; 1.000000;,
    156; 1.000000; 1.000000; 1.000000; 1.000000;,
    157; 1.000000; 1.000000; 1.000000; 1.000000;,
    158; 1.000000; 1.000000; 1.000000; 1.000000;,
    159; 1.000000; 1.000000; 1.000000; 1.000000;,
    160; 1.000000; 1.000000; 1.000000; 1.000000;,
    161; 1.000000; 1.000000; 1.000000; 1.000000;;
   }

   MeshMaterialList {
    1;
    224;
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0;

    Material mat_asteroid_1 {
     0.800000; 0.800000; 0.800000; 1.000000;;
     128.000000;
     0.000000; 0.000000; 0.000000;;
     0.000000; 0.000000; 0.000000;;

     TextureFilename {
      "mat_aste.bmp";
     }
    }

   }
  }
}
