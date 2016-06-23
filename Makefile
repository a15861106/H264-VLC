CROSS=arm-linux-
#arm-hisiv200-linux-
CC=$(CROSS)gcc
CXX=$(CROSS)g++
LINK=$(CROSS)g++ -o
LIBRARY_LINK=$(CROSS)ar cr

TOP_DIR := $(shell pwd)
OUT=$(TOP_DIR)/bin
SRCDIR=$(TOP_DIR)/src


#头文件
INCLUDE=-I ./include/jthread/ -I ./include/jrtplib3 -I ./src

#库文件
LIBDIR= -L $(TOP_DIR)/lib
LIBS=-ljrtp -ljthread -lpthread -ldl
LDLIBS=$(LIBDIR) $(LIBS)

#编译选项
CXXFLAGS=-g
CXXFLAGS+=$(INCLUDE) $(LDLIBS) 

CFLAGS=-g
CFLAGS+=$(INCLUDE) $(LDLIBS)

#目标
all: test_jrtp test_for_nal

$(OUT)/%.o:$(SRCDIR)/%.cpp
	$(CXX) -c $< -o $@ $(CXXFLAGS)

CPPOBJS=$(OUT)/NALDecoder.o

test_jrtp:$(OUT)/test_jrtp.o $(CPPOBJS)
	$(LINK) $@ $< $(CPPOBJS) $(CXXFLAGS)
 	
$(OUT)/test_jrtp.o: $(SRCDIR)/test_jrtp.cpp
	$(CXX) -c $< -o $@ $(CXXFLAGS)

test_for_nal:$(OUT)/test_for_nal.o $(CPPOBJS)
	$(LINK) $@ $< $(CPPOBJS) $(CXXFLAGS)
 	
$(OUT)/test_for_nal.o: $(SRCDIR)/test_for_nal.cpp
	$(CXX) -c $< -o $@ $(CXXFLAGS)
	
clean:
	rm $(OUT)/*.o test_jrtp test_for_nal

	
	
	
