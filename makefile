ARCULATOR = ../../sarah-walker-pcem/arculator/hostfs

all: build/batman

build/batman: src/batman.asm build/level-1.bin
	vasmarm_std src/batman.asm -a2 -m2 -opt-ldrpc -opt-adr -L src/batman.lst -Fbin -o build/batman

build/level-1.bin: build/level-1.asm
	vasmarm_std build/level-1.asm -a2 -m2 -opt-ldrpc -opt-adr -L src/level-1.lst -Fbin -o build/level-1.bin

build/level-1.asm: assets/tiles/level-1.png
	./scripts/png2asm.py -i assets/tiles/level-1.png -o build/level-1.asm -sw 16 -sh 16

clean:
	-@rm -f build/*
	-@rm -rf $(ARCULATOR)/!Batman

deploy:
	-@make
	-@mkdir $(ARCULATOR)/!Batman
	-@cp src/Run $(ARCULATOR)/!Batman/!Run,feb
	-@cp build/batman $(ARCULATOR)/!Batman/!Batman,ff8