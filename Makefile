# REPO_NAME, SRCDIR, OUTDIR, FQDN, EMAIL Environment Variable must be set
ifdef SRCDIR
	ARCHS := $(wildcard $(SRCDIR)/*)
else
	ARCHS := $(error SRCDIR Environment Variable must be set)
endif
ifdef OUTDIR
	REPOS :=  $(addsuffix /repodata, $(addprefix $(OUTDIR)/,$(notdir $(ARCHS))))
else
	REPOS := $(error OUTDIR Environment Variable must be set)
endif
BINDIR := $(abspath .)
# $(warning "ARCHS=$(ARCHS), REPOS=$(REPOS), BIDIR=$(BINDIR)")

.PHONY: all FORCE
all: $(OUTDIR)/$(REPO_NAME).repo $(OUTDIR)/RPM-GPG-KEY-$(REPO_NAME) $(REPOS)

$(OUTDIR)/$(REPO_NAME).repo: generate-repo.sh
	mkdir -p $(OUTDIR)
	./generate-repo.sh > $(OUTDIR)/$(REPO_NAME).repo
	@echo "$@ is created"

$(OUTDIR)/RPM-GPG-KEY-$(REPO_NAME): generate-gpgkey.sh
	mkdir -p $(OUTDIR)
	./generate-gpgkey.sh
	gpg2 --export -a "${REPO_NAME}" > $(OUTDIR)/RPM-GPG-KEY-$(REPO_NAME)
	echo "%_signature gpg" >> ~/.rpmmacros
	echo "%_gpg_name $(REPO_NAME)" >> ~/.rpmmacros
	@echo "$@ is created"

$(OUTDIR)/%/repodata: FORCE
	@echo enter $(dir $@) and do createrepo
	mkdir -p $(dir $@)
	cd $(dir $@); SRCDIR=$(subst $(OUTDIR),$(SRCDIR),$(dir $@)) BINDIR=$(BINDIR) make -f $(BINDIR)/Makefile.repo

clean:
	rm -rf $(OUTDIR)/*

FORCE:
