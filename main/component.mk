#
# "main" pseudo-component makefile.
#
# (Uses default behaviour of compiling all source files in directory, adding 'include' to include path.)

#main.c: $(PROJECT_PATH)/src/main.idr
#	idris -S --codegen C $< -o $@

$(PROJECT_PATH)/main/%.c: $(PROJECT_PATH)/src/%.idr
	idris -S --codegen C $< -o $@

#main.o: main.c

COMPONENT_OBJS+=idris_main.o main.o

