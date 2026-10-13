CXX := g++
CXXFLAGS := -std=c++17 -Wall -Wextra -Wpedantic
BUILD_DIR := build
PROGRAMS := simulator new ready running blocked exit

.PHONY: all run clean

all: $(addprefix $(BUILD_DIR)/,$(PROGRAMS)) $(BUILD_DIR)/Sample_1_RR.txt $(BUILD_DIR)/Sample_2_FCFS.txt $(BUILD_DIR)/Sample_4_SJF.txt
	touch $(BUILD_DIR)/processes_stats.txt

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/simulator: src/5_state_model_simulator.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $< -o $@

$(BUILD_DIR)/%: src/%.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $< -o $@

$(BUILD_DIR)/%.txt: src/%.txt | $(BUILD_DIR)
	cp $< $@

run: all
	cd $(BUILD_DIR) && ./simulator

clean:
	rm -rf $(BUILD_DIR)
