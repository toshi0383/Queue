BUILD_DIR=./.build/debug

test: lib
	$(BUILD_DIR)/spectre-build

clean:
	swift build --clean

lib:
	swift build
