ARCULATOR = ../../sarah-walker-pcem/arculator/hostfs

all: build/batman

build/batman: src/batman.asm build/level-1.bin build/main_title.bin
	vasmarm_std src/batman.asm -a2 -m2 -opt-ldrpc -opt-adr -L src/batman.lst -Fbin -o build/batman

build/level-1.bin: build/level-1.asm
	vasmarm_std build/level-1.asm -a2 -m2 -opt-ldrpc -opt-adr -L src/level-1.lst -Fbin -o build/level-1.bin

build/level-1.asm: assets/tiles/level-1.png
	./scripts/png2asm.py -i assets/tiles/level-1.png -o build/level-1.asm -sw 16 -sh 16

build/main_title.bin: build/main_title.asm
	vasmarm_std build/main_title.asm -a2 -m2 -opt-ldrpc -opt-adr -L src/level-1.lst -Fbin -o build/main_title.bin

build/main_title.asm: assets/images/main_title.png
	./scripts/png2asm.py -i assets/images/main_title.png -o build/main_title.asm -sw 320 -sh 256

clean:
	@rm -f build/*
	@rm -rf $(ARCULATOR)/!Batman

deploy:
	@make
	@mkdir $(ARCULATOR)/!Batman  > /dev/null 2>&1 || true
	@cp src/Run $(ARCULATOR)/!Batman/!Run,feb
	@cp build/batman $(ARCULATOR)/!Batman/!Batman,ff8