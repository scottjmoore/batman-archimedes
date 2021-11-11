SRC = 		src/batman.asm \
			src/tiles.asm \
			src/vidc.asm \
			src/memc.asm \
			src/debug.asm

BUILD = 	build/level-1.bin \
			build/main_title.bin \
			build/intro_screen.bin \
			build/status_bar.bin \
			build/palette_fade.bin

SPRITES =  	build/sprites/batman.asm \
			build/sprites/explosion.asm \
			build/sprites/enemies.asm \
			build/sprites/bullets.asm \
			build/sprites/pointers.asm

FONTS = 	build/fonts/intro_font.asm \
			build/fonts/system_font.asm \
			build/fonts/system_bold_font.asm


LEVELS = 	build/level_1_map.asm

LUTS = 		build/sincos.asm

VASM = 		vasmarm_std
DEBUG =		-D DEBUG=0
OPTS =		-a3 -m3 -opt-ldrpc -opt-adr -Fbin

PNG2ASM = 			./scripts/png2asm.py
COMPILESPRITE = 	./scripts/compilesprite.py
TMX2ASM = 			./scripts/tmx2asm.py
SINCOS = 			./scripts/sincos.py
ARCULATOR =			../../sarah-walker-pcem/arculator

all: build/batman


build/batman: $(SRC) $(BUILD) $(SPRITES) $(FONTS) $(LEVELS) $(LUTS) makefile
	$(VASM) src/batman.asm $(DEBUG) $(OPTS) \
		-L build/batman.lst \
		-o build/batman


build/level-1.bin: build/level-1.asm makefile
	$(VASM) build/level-1.asm $(OPTS) \
		-L build/level-1.lst \
		-o build/level-1.bin

build/level-1.asm: assets/tiles/level-1.png makefile
	$(PNG2ASM) \
		-i assets/tiles/level-1.png \
		-o build/level-1.asm \
		-sw 16 -sh 16 -ss


build/main_title.bin: build/main_title.asm makefile
	$(VASM) build/main_title.asm $(OPTS) \
		-L build/main_title.lst \
		-o build/main_title.bin

build/main_title.asm: assets/images/main_title.png makefile
	$(PNG2ASM) \
		-i assets/images/main_title.png \
		-o build/main_title.asm \
		-sw 320 -sh 256


build/intro_screen.bin: build/intro_screen.asm makefile
	$(VASM) build/intro_screen.asm $(OPTS) \
		-L build/intro_screen.lst \
		-o build/intro_screen.bin

build/intro_screen.asm: assets/images/intro_screen.png makefile
	$(PNG2ASM) \
		-i assets/images/intro_screen.png \
		-o build/intro_screen.asm \
		-sw 320 -sh 256


build/status_bar.bin: build/status_bar.asm makefile
	$(VASM) build/status_bar.asm $(OPTS) \
		-L build/status_bar.lst \
		-o build/status_bar.bin

build/status_bar.asm: assets/images/status_bar.png makefile
	$(PNG2ASM) \
		-i assets/images/status_bar.png \
		-o build/status_bar.asm \
		-sw 320 -sh 48


build/palette_fade.bin: build/palette_fade.asm makefile
	$(VASM) build/palette_fade.asm $(OPTS) \
	-L build/palette_fade.lst \
	-o build/palette_fade.bin

build/palette_fade.asm: assets/images/palette_fade.png makefile
	$(PNG2ASM) \
		-i assets/images/palette_fade.png \
		-o build/palette_fade.asm \
		-sw 16 -sh 16
		

build/sprites/batman.asm: assets/sprites/batman.png makefile
	$(COMPILESPRITE) \
		-i assets/sprites/batman.png \
		-o build/sprites/batman.asm \
		-sw 32 \
		-mi 159 \
		-at true \
		-afx true \
		-afy true


build/sprites/explosion.asm: assets/sprites/explosion.png makefile
	$(COMPILESPRITE) \
		-i assets/sprites/explosion.png \
		-o build/sprites/explosion.asm \
		-sw 32 -sh 32 \
		-mi 159


build/sprites/enemies.asm: assets/sprites/enemies.png makefile
	$(COMPILESPRITE) \
		-i assets/sprites/enemies.png \
		-o build/sprites/enemies.asm \
		-sw 32 -sh 48 \
		-mi 159


build/sprites/bullets.asm: assets/sprites/bullets.png makefile
	$(COMPILESPRITE) \
		-i assets/sprites/bullets.png \
		-o build/sprites/bullets.asm \
		-sw 4 -sh 4 \
		-mi 159


build/sprites/pointers.asm: assets/sprites/pointers.png makefile
	$(COMPILESPRITE) \
		-i assets/sprites/pointers.png \
		-o build/sprites/pointers.asm \
		-sw 12 -sh 12 \
		-mi 159 \
		-afx true \
		-afy true


build/fonts/intro_font.asm: assets/fonts/intro_font.png makefile
	$(COMPILESPRITE) \
		-i assets/fonts/intro_font.png \
		-o build/fonts/intro_font.asm \
		-sw 8 -sh 8 \
		-mi 159


build/fonts/system_font.asm: assets/fonts/system_font.png makefile
	$(COMPILESPRITE) \
		-i assets/fonts/system_font.png \
		-o build/fonts/system_font.asm \
		-sw 8 -sh 8 \
		-mi 159


build/fonts/system_bold_font.asm: assets/fonts/system_bold_font.png makefile
	$(COMPILESPRITE) \
		-i assets/fonts/system_bold_font.png \
		-o build/fonts/system_bold_font.asm \
		-sw 8 -sh 8 \
		-mi 159


build/level_1_map.asm: assets/maps/level-1.tmx makefile
	$(TMX2ASM) \
		-i assets/maps/level-1.tmx \
		-o build/level_1_map.asm


build/sincos.asm: makefile
	$(SINCOS)


clean:
	@rm -f build/batman
	@rm -f build/*.asm
	@rm -f build/*.bin
	@rm -f build/*.lst
	@rm -f build/*.adf
	@rm -f build/sprites/*.asm
	@rm -f build/sprites/*.bin
	@rm -f build/sprites/*.lst
	@rm -f build/fonts/*.asm
	@rm -f build/fonts/*.bin
	@rm -f build/fonts/*.lst
	@rm -rf $(ARCULATOR)/hostfs/!Batman


deploy:
	@make
	@mkdir $(ARCULATOR)/hostfs/!Batman  > /dev/null 2>&1 || true
	@cp src/Run $(ARCULATOR)/hostfs/!Batman/!Run,feb
	@cp src/Sprites $(ARCULATOR)/hostfs/!Batman/!Sprites,ff9
	@cp build/batman $(ARCULATOR)/hostfs/!Batman/!RunImage,ff8
	@cp assets/blank.adf build/batman.adf