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

C1_IDENTICAL := examples/c1_identical.hs
C2_IDENTICAL := examples/c2_identical.hs
C1_DIFFERENT := examples/c1_different.hs
C2_DIFFERENT := examples/c2_different.hs
C1_PARTIAL := examples/c1_partial.hs
C2_PARTIAL := examples/c2_partial.hs

.PHONY: all run run-example test test-identical test-different test-partial test-original test-all clean

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

test-identical: $(BIN)
	./$(BIN) $(RES) $(SEP) $(C1_IDENTICAL) $(C2_IDENTICAL)

test-different: $(BIN)
	./$(BIN) $(RES) $(SEP) $(C1_DIFFERENT) $(C2_DIFFERENT)

test-partial: $(BIN)
	./$(BIN) $(RES) $(SEP) $(C1_PARTIAL) $(C2_PARTIAL)

test-original: $(BIN)
	./$(BIN) $(RES) $(SEP) $(C1) $(C2)

test-all: test-original test-identical test-different test-partial test

clean:
	rm -rf $(BUILD_DIR) $(BIN) $(BIN).exe
