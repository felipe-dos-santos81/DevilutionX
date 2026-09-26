# Makefile for DevilutionX — a port of Diablo and Hellfire for modern systems
# Wraps the CMake workflow: install → configure → build → run/test/benchmark → clean
SERVICE = DevilutionX

# Variables
BUILD_DIR ?= build
BUILD_TYPE ?= Release
JOBS ?= $(shell sysctl -n hw.ncpu 2>/dev/null || getconf _NPROCESSORS_ONLN 2>/dev/null || echo 4)
CMAKE ?= cmake
BIN = $(BUILD_DIR)/devilutionx
BENCHMARKS = clx_render crawl dun_render light_render palette_blending path

.PHONY: help install clean \
        configure build debug \
        run \
        test benchmark

# ── Environment ──────────────────────────────────────────────────────────────

help: ## Print this help message
	@printf '\033[01;32m${SERVICE} — Diablo and Hellfire for modern systems\033[00;37m\n\n'
	@printf "\033[33mUsage:\033[0m\n  make [target] [arg=\"val\"...]\n\n\033[33mTargets:\033[0m\n"
	@grep -E '^[-a-zA-Z0-9_\.\/]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; \
		{printf "  \033[36m%-26s\033[0m %s\n", $$1, $$2}'

# gettext is keg-only on Homebrew: force-link so msgmerge/msgfmt are on PATH for translations.
# Homebrew's lua (5.5+) installs headers that shadow sol2's <lua/lua.h> includes and break
# the build, so it must be unlinked (undo with: brew link lua).
install: ## Install build dependencies (macOS: Homebrew; Debian/Ubuntu: apt)
	@[ -s .gitmodules ] && git submodule update --init --recursive || true
	@if [ "$$(uname)" = "Darwin" ]; then \
		brew bundle install; \
		brew link --force gettext >/dev/null 2>&1 || true; \
		if [ -e "$$(brew --prefix)/include/lua" ] && brew list --versions lua >/dev/null 2>&1; then \
			echo "Unlinking Homebrew lua (its headers break the build; undo with: brew link lua)"; \
			brew unlink lua; \
		fi; \
	elif command -v apt-get >/dev/null 2>&1; then \
		sudo apt-get update; \
		sudo apt-get install -y cmake g++ gettext libsdl2-dev libsdl2-image-dev libsodium-dev \
			libpng-dev libbz2-dev libgtest-dev libgmock-dev libbenchmark-dev; \
	else \
		echo "Unsupported platform — see docs/building.md for dependency instructions."; \
	fi
	@echo "Dependencies installed."

clean: ## Remove the build directories
	rm -rf $(BUILD_DIR) build-debug
	@echo "Cleanup complete."

# ── Build ────────────────────────────────────────────────────────────────────

configure: ## Configure the CMake build (usage: make configure [BUILD_TYPE=Debug] [flags="-DNONET=ON"])
	$(CMAKE) -S. -B$(BUILD_DIR) -DCMAKE_BUILD_TYPE=$(BUILD_TYPE) $(flags)

build: configure ## Compile the game (usage: make build [BUILD_TYPE=Debug] [JOBS=8])
	$(CMAKE) --build $(BUILD_DIR) -j $(JOBS)

debug: ## Configure and compile a Debug build into build-debug/ (ASan+UBSan enabled)
	$(MAKE) build BUILD_DIR=build-debug BUILD_TYPE=Debug

# ── Run ──────────────────────────────────────────────────────────────────────

# The game data (DIABDAT.MPQ or spawn.mpq) must be placed next to the binary or
# in the user data directory — see docs/installing.md.
run: build ## Launch the game (requires DIABDAT.MPQ or spawn.mpq — see docs/installing.md)
	@if [ -d "$(BIN).app" ]; then \
		"$(BIN).app/Contents/MacOS/devilutionx"; \
	else \
		"$(BIN)"; \
	fi

# ── Test ─────────────────────────────────────────────────────────────────────

test: build ## Build and run the GoogleTest suite via ctest (usage: make test [filter=player*])
	ctest --test-dir $(BUILD_DIR) --output-on-failure -j $(JOBS) $(if $(filter),-R "$(filter)")

benchmark: build ## Run the rendering/pathfinding micro-benchmarks (see docs/benchmarking.md)
	@for b in $(BENCHMARKS); do \
		echo "── $${b}_benchmark ──"; \
		"$(BUILD_DIR)/$${b}_benchmark" || exit 1; \
	done
