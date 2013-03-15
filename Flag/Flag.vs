uniform vec4 scale;

uniform float time;

uniform float amplitude;


uniform vec2 freq;

uniform vec3 light;
uniform vec3 ambient;
uniform vec3 specular;

varying vec4 ColorOut;

void main()
{

	
	vec3 normal;
	vec3 perp;

	vec4 vertex = gl_Vertex * scale;

	float tx = vertex.x * freq.x + time;
	float ty = vertex.y * freq.y + time;

	float comp_x = sin(tx);
	float comp_y = sin(ty);
	
	float offset = amplitude * (comp_x+comp_y);
     vertex.z = vertex.z + offset;

	float amp = sin(amplitude) / cos(amplitude);

	vec3 rot;
	rot.x = amp*cos(tx);
	rot.y = amp*cos(ty);	
	rot.z = 0.0;
	
	mat3 rot_x;
	rot_x[0] = vec3(1,0,0);
	rot_x[1] = vec3(0, cos(rot.x), -sin(rot.x));
	rot_x[2] = vec3(0, sin(rot.x), cos(rot.x));

	mat3 rot_y;
	rot_y[0] = vec3(cos(rot.y), 0, -sin(rot.y));
	rot_y[1] = vec3(0,1,0);
	rot_y[2] = vec3(- sin(rot.y),0, cos(rot.y));

	normal = normalize(gl_NormalMatrix * gl_Normal);

	normal = rot_x * normal;
	normal = rot_y * normal;

	vec3 lightDir = normalize(light);

	float shade = dot(normal,lightDir);



	ColorOut.r = shade;
	ColorOut.g = shade;
	ColorOut.b = shade;

	ColorOut.a = 1.0;


	gl_TexCoord[0] = gl_MultiTexCoord0;
	gl_Position = gl_ModelViewProjectionMatrix * vertex;

}
