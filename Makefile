CXX := g++
CXXFLAGS := -std=c++17 -Wall -Wextra -Wpedantic
BUILD_DIR := build
PROGRAMS := simulator new ready running blocked exit

.PHONY: all run clean

WORKLOADS := round-robin.txt first-come-first-served.txt shortest-job-first.txt

all: $(addprefix $(BUILD_DIR)/,$(PROGRAMS)) $(addprefix $(BUILD_DIR)/,$(WORKLOADS))
	touch $(BUILD_DIR)/processes_stats.txt

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/simulator: src/main.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $< -o $@

$(BUILD_DIR)/%: src/%.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $< -o $@

$(BUILD_DIR)/%.txt: examples/%.txt | $(BUILD_DIR)
	cp $< $@

run: all
	cd $(BUILD_DIR) && ./simulator

clean:
	rm -rf $(BUILD_DIR)
