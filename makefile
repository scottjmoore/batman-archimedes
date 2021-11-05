ARCULATOR = ../../sarah-walker-pcem/arculator/hostfs

SRC = 		src/batman.asm \
			src/tiles.asm \
			src/vidc.asm \
			src/memc.asm

BUILD = 	build/level-1.bin \
			build/main_title.bin \
			build/intro_screen.bin \
			build/status_bar.bin \
			build/palette_fade.bin

SPRITES =  	build/sprites/batman_sprites.asm \
			build/sprites/explosion.asm \
			build/sprites/enemies.asm \
			build/sprites/bullets.asm \
			build/sprites/pointers.asm \
			build/sprites/intro_font.asm

LEVELS = 	build/level_1_map.asm

LUTS = 		build/sincos.asm

DEBUG =		-D DEBUG=0

all: build/batman


build/batman: $(SRC) $(BUILD) $(SPRITES) $(LEVELS) $(LUTS)
	vasmarm_std src/batman.asm $(DEBUG) -a2 -m2 -opt-ldrpc -opt-adr -L build/batman.lst -Fbin -o build/batman


build/level-1.bin: build/level-1.asm
	vasmarm_std build/level-1.asm -a2 -m2 -opt-ldrpc -opt-adr -L build/level-1.lst -Fbin -o build/level-1.bin
build/level-1.asm: assets/tiles/level-1.png
	./scripts/png2asm.py -i assets/tiles/level-1.png -o build/level-1.asm -sw 16 -sh 16 -ss

build/main_title.bin: build/main_title.asm
	vasmarm_std build/main_title.asm -a2 -m2 -opt-ldrpc -opt-adr -L build/main_title.lst -Fbin -o build/main_title.bin
build/main_title.asm: assets/images/main_title.png
	./scripts/png2asm.py -i assets/images/main_title.png -o build/main_title.asm -sw 320 -sh 256

build/intro_screen.bin: build/intro_screen.asm
	vasmarm_std build/intro_screen.asm -a2 -m2 -opt-ldrpc -opt-adr -L build/intro_screen.lst -Fbin -o build/intro_screen.bin
build/intro_screen.asm: assets/images/intro_screen.png
	./scripts/png2asm.py -i assets/images/intro_screen.png -o build/intro_screen.asm -sw 320 -sh 256

build/status_bar.bin: build/status_bar.asm
	vasmarm_std build/status_bar.asm -a2 -m2 -opt-ldrpc -opt-adr -L build/status_bar.lst -Fbin -o build/status_bar.bin
build/status_bar.asm: assets/images/status_bar.png
	./scripts/png2asm.py -i assets/images/status_bar.png -o build/status_bar.asm -sw 320 -sh 48

build/palette_fade.bin: build/palette_fade.asm
	vasmarm_std build/palette_fade.asm -a2 -m2 -opt-ldrpc -opt-adr -L build/palette_fade.lst -Fbin -o build/palette_fade.bin
build/palette_fade.asm: assets/images/palette_fade.png
	./scripts/png2asm.py -i assets/images/palette_fade.png -o build/palette_fade.asm -sw 16 -sh 16


build/sprites/batman_sprites.asm: assets/sprites/batman.png
	./scripts/compilesprite.py -i assets/sprites/batman.png -o build/sprites/batman_sprites.asm -sw 32 -sh 48

build/sprites/explosion.asm: assets/sprites/explosion.png
	./scripts/compilesprite.py -i assets/sprites/explosion.png -o build/sprites/explosion.asm -sw 32 -sh 32

build/sprites/enemies.asm: assets/sprites/enemies.png
	./scripts/compilesprite.py -i assets/sprites/enemies.png -o build/sprites/enemies.asm -sw 32 -sh 48

build/sprites/bullets.asm: assets/sprites/bullets.png
	./scripts/compilesprite.py -i assets/sprites/bullets.png -o build/sprites/bullets.asm -sw 4 -sh 4

build/sprites/pointers.asm: assets/sprites/pointers.png
	./scripts/compilesprite.py -i assets/sprites/pointers.png -o build/sprites/pointers.asm -sw 12 -sh 12

build/sprites/intro_font.asm: assets/tiles/intro_font.png
	./scripts/compilesprite.py -i assets/tiles/intro_font.png -o build/sprites/intro_font.asm -sw 8 -sh 8



build/level_1_map.asm: assets/maps/level-1.tmx
	./scripts/tmx2asm.py -i assets/maps/level-1.tmx -o build/level_1_map.asm


build/sincos.asm:
	./scripts/sincos.py


clean:
	@rm -f build/sprites/*.asm
	@rm -f build/*.asm
	@rm -f build/*.bin
	@rm -f build/*.adf
	@rm -rf $(ARCULATOR)/!Batman


deploy:
	@make
	@mkdir $(ARCULATOR)/!Batman  > /dev/null 2>&1 || true
	@cp src/Run $(ARCULATOR)/!Batman/!Run,feb
	@cp build/batman $(ARCULATOR)/!Batman/!RunImage,ff8
	@cp assets/blank.adf build/batman.adf