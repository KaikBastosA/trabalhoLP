GHC ?= ghc
BIN ?= similaridade
SRC := src/Main.hs
BUILD_DIR ?= build

RES ?= examples/res.txt
SEP ?= examples/sep.txt
C1 ?= examples/c1.hs
C2 ?= examples/c2.hs
EXPECTED ?= examples/expected.txt
ACTUAL := $(BUILD_DIR)/actual.txt
ARGS ?= $(RES) $(SEP) $(C1) $(C2)

.PHONY: all run run-example test clean

all: $(BIN)

$(BIN): $(SRC)
	@mkdir -p $(BUILD_DIR)
	$(GHC) -O2 -Wall -outputdir $(BUILD_DIR) -odir $(BUILD_DIR) -hidir $(BUILD_DIR) -o $@ $<

run: $(BIN)
	./$(BIN) $(ARGS)

run-example: run

test: $(BIN)
	@mkdir -p $(BUILD_DIR)
	./$(BIN) $(RES) $(SEP) $(C1) $(C2) > $(ACTUAL)
	diff -u $(EXPECTED) $(ACTUAL)

clean:
	rm -rf $(BUILD_DIR) $(BIN) $(BIN).exe
