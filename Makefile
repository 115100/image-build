.DEFAULT_GOAL := all

.PHONY: all
all: images/debian.qcow2 images/tumbleweed.qcow2

.PHONY: clean
clean:
	@rm -rf images/
	@rm -rf output-*

SRCS = $(wildcard *.pkr.hcl)
images/%.qcow2: vars/%.pkrvars.hcl $(SRCS)
	@rm -rf output-$*
	@mkdir -p $(dir $@)
	@packer build -var-file $< .
	@mv output-$*/$(notdir $@) $@
	@rm -rf output-$*
