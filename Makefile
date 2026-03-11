.PHONY: kb

kb:
	@if [ -z "$(SLUG)" ] || [ -z "$(TITLE)" ] || [ -z "$(DESC)" ]; then \
		echo "Usage: make kb SLUG=<slug> TITLE=<title> DESC=<description>"; \
		exit 1; \
	fi
	./scripts/new-kb.sh "$(SLUG)" "$(TITLE)" "$(DESC)"
