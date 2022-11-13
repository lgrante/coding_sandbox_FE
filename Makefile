SRC_DIR		:=	./src/modules
BUILD_DIR	:=	./src/modules_build

SRC_FILES	:=	$(shell find $(SRC_DIR) -name "*.c" -type f -printf "%f\n")

SRC			:=	$(SRC_FILES:%=$(SRC_DIR)/%)
OUTPUT		:=	$(SRC_FILES:%.c=$(BUILD_DIR)/%.mjs)
BIN			:=	$(SRC_FILES:.c=.wasm)
BIN_DIR		:=	$(SRC_FILES:%.c=$(BUILD_DIR)/%.wasm)
BIN_DEST	:=	$(SRC_FILES:%.c=./public/%.wasm)

NAME		=	main

CC			=	emcc --no-entry 

CCFLAGS		=	--pre-js src/locateFile.js \
				-s ENVIRONMENT='web' \
				-s EXPORT_NAME='createModule' \
				-s USE_ES6_IMPORT_META=0 \
				-s EXPORTED_FUNCTIONS='["_test", "_malloc", "_free"]' \
				-s EXPORTED_RUNTIME_METHODS='["ccall", "cwrap"]' \
				-O3

RM			=	rm -rf

all: 		$(NAME)

$(NAME):	$(SRC)
		@printf "\e[1m\e[38;2;21;124;214mCompiling $(NAME)...\033[0m  "
		@mkdir $(BUILD_DIR)
		@$(CC) $(SRC) -o $(OUTPUT) $(CCFLAGS)
		@mv $(BIN_DIR) ./public
		@printf "Done.\n"

clean:
		@printf "\e[1m\e[38;2;21;124;214mCleaning all object files...\033[0m  "
		@$(RM) $(BUILD_DIR)
		@$(RM) $(BIN_DEST) 
		@printf "Done.\n"

re:		clean all

test:
		@printf "Running test...\n"

.PHONY: all clean fclean re test
