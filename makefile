# Makefile Written by ticktick

# Show how to cross-compile c/c++ code for android platform

.PHONY: clean
#-------------------------------------------------------
CC = gcc
CXX = g++
AR = ar
LD = ld
STRIP = strip
WALL = -Wall

CUR_DIR = $(shell pwd)

INCLUDE = -I$(CUR_DIR)/inc\
			-I$(CUR_DIR)/dbc/common\
			-I$(CUR_DIR)/dbc/libdbc/inc\
			-I/usr/local/include\
			-I/usr/local/include/dbi

STATIC_LIB = 

SHARE_LIB_PATH = -L/usr/local/lib
SHARE_LIB = -ldl -lpthread -ldbi

COMPILE_TARGET_DIR = $(CUR_DIR)/bin/
TARGET_NAME = dbc
TARGET = $(COMPILE_TARGET_DIR)$(TARGET_NAME)

OBJ_DIR = $(CUR_DIR)/obj

#获取当前目录下所有的.c文件
SOURCE = $(wildcard $(CUR_DIR)/src/*.c)\
		$(wildcard $(CUR_DIR)/dbc/libdbc/src/*.c)

#得到相应的.o文件,所有的.c文件替换为.o文件
OBJ = $(patsubst %.c,$(OBJ_DIR)/%.o,$(notdir $(SOURCE)))

$(OBJ_DIR)/%.o:$(CUR_DIR)/src/%.c
	@echo "CC $<"
	@$(CC) -ggdb $(WALL) $(INCLUDE) $< -c -o $@

$(OBJ_DIR)/%.o:$(CUR_DIR)/dbc/libdbc/src/%.c
	@echo "CC $<"
	@$(CC) -ggdb $(WALL) $(INCLUDE) $< -c -o $@

#生成目标的依赖
$(TARGET): $(OBJ)
	@echo "--------------create $(TARGET)---------"
	@$(CC) $(WALL) $(SHARE_LIB_PATH) -o $@ $^ $(SHARE_LIB) $(STATIC_LIB)
	$(STRIP) $(TARGET)
	ls -alh $(TARGET)
clean:
	rm -rf $(OBJ_DIR)/*.o
	rm -rf $(TARGET)