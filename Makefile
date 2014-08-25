COFFEEC = coffee

TARGET=scena.js
SPEC_TARGET=spec_scena.js
JSPATH=js
COFFEEPATHES=src src/core src/plugins
SPECPATH=spec


COFFEE_LIST=$(wildcard src/*.coffee) \
    $(wildcard src/core/*.coffee) \
    $(wildcard src/plugins/*.coffee)
JS_LIST = $(COFFEE_LIST:%.coffee=%.js)
SPEC_COFFEE_LIST= $(wildcard spec/*.coffee) \
    $(wildcard spec/core/*.coffee)
SPEC_JS_LIST = $(SPEC_COFFEE_LIST:%.coffee=%.js)

.DEFAULT_GOAL = all

.PHONY: all 
all: $(TARGET) $(SPEC_TARGET)


$(TARGET): $(COFFEE_LIST)
	mkdir -p $(JSPATH)
	$(COFFEEC) -c -j $(JSPATH)/$(TARGET) $(COFFEE_LIST)

.PHONY: spec
spec : $(SPEC_TARGET)
$(SPEC_TARGET): $(COFFEE_LIST) $(SPEC_COFFEE_LIST)
	$(COFFEEC) -c -j $(JSPATH)/$(SPEC_TARGET) $(COFFEE_LIST) $(SPEC_COFFEE_LIST)


.PHONY: clean
clean:
	$(RM) $(JSPATH)/$(TARGET)
	$(RM) $(JSPATH)/$(SPEC_TARGET)
	$(RM) $(JS_LIST)
