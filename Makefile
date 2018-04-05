#
# This is a project Makefile. It is assumed the directory this Makefile resides in is a
# project subdirectory.
#

PROJECT_NAME := hello-world

include $(IDF_PATH)/make/project.mk

main/main.c: src/main.idr
main/main.o: main/main.c

main/%.c: src/%.idr
	idris -S --codegen C $< -o $@

