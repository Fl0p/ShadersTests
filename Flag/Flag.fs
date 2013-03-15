uniform sampler2D tex;

varying vec4 ColorOut;

uniform vec3 u_color1;
uniform vec3 u_color2;
uniform vec3 u_color3;

uniform float toon;

void main()
{
    vec4 color = texture2D(tex, gl_TexCoord[0].xy);

    //vec4 color = v_fragmentColor * texture2D(u_texture, v_texCoord);
    
	mat4 matrix = mat4(
	   u_color1.r, u_color1.g, u_color1.b, 0.0, // first column 
	   u_color2.r, u_color2.g, u_color2.b, 0.0, // second column 
	   u_color3.r, u_color3.g, u_color3.b, 0.0, // third column 
   	   0.0, 0.0, 0.0, 1.0  // adds column
	);


	float toon_shade = 0.1;

	float shade = 0.0;
	if (ColorOut.r > 0.1) {
		toon_shade = 0.2;
	}

	if (ColorOut.r > 0.4) {
		toon_shade = 0.5;
	}

	if (ColorOut.r > 0.7) {
		toon_shade = 0.8;
	}

	if (ColorOut.r > 0.9) {
		toon_shade = 1.0;
	}

	vec4 cOut = ColorOut;
	cOut.r = ColorOut.r * toon_shade * toon + (1.0 - toon) * ColorOut.r;
	cOut.g = ColorOut.g * toon_shade * toon + (1.0 - toon) * ColorOut.g;
	cOut.b = ColorOut.b * toon_shade * toon + (1.0 - toon) * ColorOut.b;

	gl_FragColor = matrix * cOut * color;
}
