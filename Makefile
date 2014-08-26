COFFEEC = coffee

TARGET=scena.js
SPEC_TARGET=spec_scena.js
JSPATH=js
COFFEEPATHES=src src/core src/plugins
SPECPATH=spec


CORE_COFFEE_LIST = $(wildcard src/*.coffee) $(wildcard src/core/*.coffee)
PLUGIN_COFFEE_LIST = $(wildcard src/plugins/*.coffee)
SPEC_COFFEE_LIST= $(wildcard spec/*.coffee) $(wildcard spec/core/*.coffee)

.DEFAULT_GOAL = all

.PHONY: all 
all: $(TARGET) $(SPEC_TARGET)


$(TARGET): $(CORE_COFFEE_LIST) $(PLUGIN_COFFEE_LIST)
	mkdir -p $(JSPATH)
	$(COFFEEC) -c -j $(JSPATH)/$(TARGET) $(CORE_COFFEE_LIST) $(PLUGIN_COFFEE_LIST)

.PHONY: spec
spec : $(SPEC_TARGET)
$(SPEC_TARGET): $(CORE_COFFEE_LIST) $(SPEC_COFFEE_LIST)
	$(COFFEEC) -c -j $(JSPATH)/$(SPEC_TARGET) $(CORE_COFFEE_LIST) $(SPEC_COFFEE_LIST)


.PHONY: clean
clean:
	$(RM) $(JSPATH)/$(TARGET)
	$(RM) $(JSPATH)/$(SPEC_TARGET)
