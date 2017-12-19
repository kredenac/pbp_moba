CC		= gcc
CFLAGS	= -Wall -Wextra
CCLIBS	= -lmysqlclient
PROGRAM	= moba

DEPS	=			\
		demo.h	

OBJ		=			\
		demo.o

VPATH	= src


.PHONY: all create insert

all: create triggers insert $(PROGRAM)

create:
	mysql -u root --password= -D mysql <create.sql

triggers:
	mysql -u root --password= -D mysql <trigger.sql

insert:
	mysql -u root --password= -D mysql <insert.sql


%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CCFLAGS)

$(PROGRAM): $(OBJ)
	$(CC) -o $@ $^ $(CCLIBS) $(CCFLAGS)
