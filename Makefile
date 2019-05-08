CC=gcc
CFLAG=-g -Wall

INCS=-I./lib/ -I./lib/librunlog -I./lib/libstd

LIBS=-L ./lib/librunlog/ -lrunlog  -L./lib/libstd/ -lcomm  -lpthread

OTHER=-Wl,-rpath=./lib/librunlog/ -Wl,-rpath=./lib/libstd/

RUNLIB=./lib/librunlog/librunlog.so

all:host_security

OBJS=inotify_watch.o inotify_execd.o main.o event_queue.o function.o wdtables.o file_tools.o

host_security: $(OBJS) $(RUNLIB)
	$(CC) $(INCS) $(CFLAG) $(OBJS) $(LIBS) $(OTHER) -o host_security

$(OBJS):%.o:%.c
	$(CC) $(INCS) $(CFLAG) -c -o $@ $<

$(RUNLIB):
	make -C lib/


clean:
	$(RM) $(OBJS)
	$(RM) host_security

distclean:clean
	make clean -C lib
