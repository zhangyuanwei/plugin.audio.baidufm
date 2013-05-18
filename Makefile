DIR:=plugin.audio.baidufm
FILES:=addon.xml default.py icon.png changelog.txt
TEMPFILE:=$(addprefix $(DIR)/,$(FILES))
OUTPUT:=plugin.audio.baidufm-0.0.3.zip

all:build

build:$(OUTPUT)

run:update
	xbmc-send --host=192.168.1.2 --action="XBMC.RunAddon($(DIR))"

update:$(TEMPFILE)
	#cp -r $(DIR) ~/.xbmc/addons/
	scp -r $(DIR) xbmc@raspberrypi:~/.xbmc/addons/

$(DIR)/%:%
	mkdir -p $(DIR)
	cp $^ $@

$(OUTPUT):$(TEMPFILE)
	zip -r $@ $(DIR)
	rm -rf $(DIR)

upload:$(OUTPUT)
	scp $^ xbmc@raspberrypi:~

clean:
	rm -rf $(DIR) $(OUTPUT)

.INTERMEDIATE:$(TEMPFILE) $(DIR)

.PHONEY:build update upload clean run all

