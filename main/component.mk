#
# "main" pseudo-component makefile.
#
# (Uses default behaviour of compiling all source files in directory, adding 'include' to include path.)
CFLAGS+=-DFORCE_ALIGNMENT -DIDRIS_TARGET_OS=\"none\" -DIDRIS_TARGET_TRIPLE=\"xtensa-esp32-elf\" -DESP32

IDRIS_FILES=$(wildcard $(PROJECT_PATH)/src/*.idr)

idris_main.o: $(PROJECT_PATH)/main/main.c

$(PROJECT_PATH)/main/main.c: $(IDRIS_FILES) 
	@echo "recompiling idris files"
	idris -S --codegen C -i $(PROJECT_PATH)/src/ $(PROJECT_PATH)/src/main.idr -o $@

COMPONENT_OBJS+=idris_main.o main.o
COMPONENT_EXTRA_CLEAN=$(PROJECT_PATH)/main/main.c
