# Original C++ assignment
# converted to Ruby-OpenGL
# Ryan Hammett @Larke12

require 'opengl'
require 'glu'
require 'glut'
include Gl, Glu, Glut

$DEG2RAD = 0.017453

# Sun global variable(s)
$RAD = 0.20

# Instance square - DO NOT MODIFY
# GLfloat sqr[4][2]
$inst_sqr = [[1.0, 1.0],
			[-1.0, 1.0],
			[-1.0, -1.0],
			[1.0, -1.0]]

# House global variable(s)
# GLfloat tri[3][2]
$tri = [[0.0, 1.0],
		[-1.0, 0.0],
		[1.0, 0.0]]

# Fan global variable(s)
# GLfloat fan[4][2]
$fan = [[0.0, 0.0],
		[0.5, 0.1],
		[1.5, 0.0],
		[0.5, -0.1]]

# Render scene
def draw
	# Blue skies

	# Reset modelview matrix
	Gl.glLoadIdentity()

	# Draw gradient square
	Gl.glColor3f(0.0, 0.0, 1.0)

	Gl.glBegin(GL_POLYGON)
		Gl.glVertex2f($inst_sqr[0][0], $inst_sqr[0][1])
		Gl.glVertex2f($inst_sqr[1][0], $inst_sqr[1][1])
		Gl.glColor3f(1.0, 1.0, 1.0)
		Gl.glVertex2f($inst_sqr[2][0], $inst_sqr[2][1])
		Gl.glVertex2f($inst_sqr[3][0], $inst_sqr[3][1])
	Gl.glEnd()

	# Suns shine

	# Reset modelview matrix
	Gl.glLoadIdentity()

	# Move and size circle
	Gl.glTranslatef(-0.65, 0.65, 1)

	# Draw circle
	Gl.glColor3f(1.0, 1.0, 1.0)

	Gl.glBegin(GL_POLYGON);
		# Initalize local variables
		i = 0
		degnrad = 0

		while i < 360
			degnrad = i * $DEG2RAD
			# Add shine to sun, off-center
			if i == 10
				Gl.glColor3f(1.0, 1.0, 0.0)
			end
			Gl.glVertex2f(Math.cos(degnrad) * $RAD, Math.sin(degnrad) * $RAD)
			i += 1
		end
	Gl.glEnd();

	# Earth grows

	# Reset modelview matrix
	Gl.glLoadIdentity()

	# Move and size square
	Gl.glTranslatef(0.0, -0.65, 0.0)
	Gl.glScalef(1.0, 0.35, 0.0)

	# Draw gradient square
	Gl.glColor3f(0.0, 0.45, 0.0)

	Gl.glBegin(GL_POLYGON)
		Gl.glVertex2f($inst_sqr[0][0], $inst_sqr[0][1])
		Gl.glVertex2f($inst_sqr[1][0], $inst_sqr[1][1])
		Gl.glColor3f(0.0, 1.0, 0.0)
		Gl.glVertex2f($inst_sqr[2][0], $inst_sqr[2][1])
		Gl.glVertex2f($inst_sqr[3][0], $inst_sqr[3][1])
	Gl.glEnd()

	# Mills wind | siding

	# Reset modelview matrix
	Gl.glLoadIdentity()

	# Move and size square
	Gl.glTranslatef(0.0, -0.3, 0.0)
	Gl.glScalef(0.3, 0.3, 0.0)

	# Draw bronze square
	Gl.glColor3f(0.65, 0.50, 0.25)

	Gl.glBegin(GL_POLYGON)
		Gl.glVertex2f($inst_sqr[0][0], $inst_sqr[0][1])
		Gl.glVertex2f($inst_sqr[1][0], $inst_sqr[1][1])
		Gl.glVertex2f($inst_sqr[2][0], $inst_sqr[2][1])
		Gl.glVertex2f($inst_sqr[3][0], $inst_sqr[3][1])
	Gl.glEnd()

	# Mills wind | roof

	# Reset modelview matrix
	Gl.glLoadIdentity()

	# Size triangle
	Gl.glScalef(0.3, 0.3, 0.0)

	# Draw red triangle
	Gl.glColor3f(1.0, 0.0, 0.0)

	Gl.glBegin(GL_POLYGON)
		Gl.glVertex2f($tri[0][0], $tri[0][1])
		Gl.glVertex2f($tri[1][0], $tri[1][1])
		Gl.glVertex2f($tri[2][0], $tri[2][1])
	Gl.glEnd()

	# Mills wind | mill

	# Reset modelview matrix
	Gl.glLoadIdentity()

	# Move and size triangles
	Gl.glTranslatef(0.0, 0.3, 0.0)
	Gl.glScalef(0.2, 0.2, 0.0)

	# Draw cyan triangles
	Gl.glColor3f(0.0, 1.0, 1.0)
	i = 0

	while i < 3
		Gl.glRotated(120, 0, 0, 1) # 360 / 3
		Gl.glBegin(GL_POLYGON)
			Gl.glVertex2fv($fan[0][0], $fan[0][1])
			Gl.glVertex2fv($fan[1][0], $fan[1][1])
			Gl.glVertex2fv($fan[2][0], $fan[2][1])
			Gl.glVertex2fv($fan[3][0], $fan[3][1])
		Gl.glEnd()
		i += 1
	end
end

# Display callback
display = Proc.new {
	# Reset background
	Gl.glClear(Gl::GL_COLOR_BUFFER_BIT)

	# Render scene
	draw()

	# Flush buffer
	Gl.glFlush()

	# Swap buffers
	Glut.glutSwapBuffers();
}

# Window reshape callback
reshape = Proc.new { |w, h|
	Gl.glViewport(0, 0, w, h)
	Gl.glMatrixMode(Gl::GL_PROJECTION)
	Gl.glLoadIdentity()
	
	if (w <= h)
		Gl.glOrtho(-1.5, 1.5, -1.5*h/w, 1.5*h/w, -10.0, 10.0)
	else
		Gl.glOrtho(-1.5*w/h, 1.5*w/h, -1.5, 1.5, -10.0, 10.0)
	end
	
	Gl.glMatrixMode(Gl::GL_MODELVIEW)
}

# Keyboard callback
keyboard = lambda do |key, x, y|
	case(key)
	# Exit when ESC is pressed
	when ?\e
		exit(0)
	end
end

# Unused idle callback

# Main Loop
# Open window with initial window size, title bar,
# RGBA display mode, and handle input events.
Glut.glutInit
Glut.glutInitDisplayMode(Glut::GLUT_DOUBLE | Glut::GLUT_RGB)
Glut.glutInitWindowSize(500, 500)
Glut.glutCreateWindow("Donny!")
#Glut.glutReshapeFunc(reshape)
Glut.glutDisplayFunc(display)
Glut.glutKeyboardFunc(keyboard)
Gl.glClearColor(1.0, 1.0, 1.0, 1.0)
Glut.glutMainLoop()