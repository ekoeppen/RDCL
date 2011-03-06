#include <fcntl.h>
#include <termios.h>
#include "ruby.h"

void Init_posix_serial_support();

VALUE module;

VALUE set_speed(VALUE self, VALUE fd, VALUE speed)
{
    struct termios attr;
 
    tcgetattr(NUM2INT(fd),&attr);
    attr.c_lflag &= ~(ICANON | IEXTEN | ISIG | ECHO);
    attr.c_iflag &= ~(ICRNL | INPCK | ISTRIP | IXON | BRKINT);
    attr.c_oflag &= ~OPOST;
    attr.c_cflag |= CS8;	
    attr.c_cc[VMIN]  = 1;
    attr.c_cc[VTIME] = 0;
    cfsetispeed(&attr,NUM2INT(speed));
    cfsetospeed(&attr,NUM2INT(speed));
    tcsetattr(NUM2INT(fd),TCSAFLUSH,&attr);
    tcgetattr(NUM2INT(fd),&attr);
    return Qnil;
}

void Init_posix_serial_support()
{
	module = rb_define_module("PosixSerialSupport");
	rb_define_module_function(module, "set_speed", set_speed, 2);
}
