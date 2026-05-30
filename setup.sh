#!/usr/bin/env bash

set -e

# =========================
# Paths & State
# =========================
ROOT_DIR="$(pwd)"
TEMP_DIR="$ROOT_DIR/temp"
LOG_FILE="$TEMP_DIR/setup.log"

TARGET_DIR="/etc/nixos"
SAFE_FILES=("hardware-configuration.nix" "flake.lock")

mkdir -p "$TEMP_DIR"

# =========================
# Run Metadata
# =========================
RUN_ID="$(date '+%Y-%m-%d %H:%M:%S')"
SEPARATOR="============================================================"

# =========================
# Logging Helpers
# =========================
timestamp() {
    date "+%Y-%m-%d %H:%M:%S"
}

log() {
    echo "[$RUN_ID] $1" | tee -a "$LOG_FILE"
}

run() {
    log "RUN: $*"
    "$@" 2>&1 | tee -a "$LOG_FILE"
}


# Clean And Backup
clean_nixos_folder() {
    run echo "Clean $TARGET_DIR except ${SAFE_FILES[*]}..."

    for item in "$TARGET_DIR"/*; do
        skip=false

        for safe_file in "${SAFE_FILES[@]}"; do
            if [ "$item" = "$TARGET_DIR/$safe_file" ]; then
                echo "Skip: $item"
                skip=true
                break
            fi
        done

        $skip && continue

        echo "Delete: $item"
        sudo rm -rf "$item"
    done

    SCRIPT_DIR="$(pwd)"

    copied_any=false

    # copy hardware-configuration.nix kalau ada
    if [ -f "$TARGET_DIR/hardware-configuration.nix" ]; then
        run cp "$TARGET_DIR/hardware-configuration.nix" "$SCRIPT_DIR/"
        run echo "Copied hardware-configuration.nix to $SCRIPT_DIR/"
        copied_any=true
    else
        run echo "hardware-configuration.nix not found (skip)"
    fi

    # copy flake.lock kalau ada
    if [ -f "$TARGET_DIR/flake.lock" ]; then
        run cp "$TARGET_DIR/flake.lock" "$SCRIPT_DIR/"
        run echo "Copied flake.lock to $SCRIPT_DIR/"
        copied_any=true
    else
        run echo "flake.lock not found (skip)"
    fi

    if [ "$copied_any" = false ]; then
        run echo "WARNING: No config files found, but continuing anyway"
    fi
}

# Copying
clean_and_update() {
    echo "[2] CLEAN & UPDATE"

    clean_nixos_folder

    # Copy config
    run sudo cp main.nix $TARGET_DIR/
    run sudo cp flake.nix $TARGET_DIR/
    run sudo cp flake.lock $TARGET_DIR/

    if [ -f "$TARGET_DIR/hardware-configuration.nix" ]; then
        run echo "hardware-configuration.nix already exists, skip copy"
    else
        if [ -f "./hardware-configuration.nix" ]; then
            run sudo cp hardware-configuration.nix $TARGET_DIR/
            run echo "Copied hardware-configuration.nix to $TARGET_DIR/"
        else
            run echo "WARNING: hardware-configuration.nix not found in current dir"
        fi
    fi

    run sudo cp -r modules $TARGET_DIR/
    run sudo cp -r modules-flake $TARGET_DIR/

    run echo "Next Step"
    run echo "sudo nixos-rebuild switch --flake /etc/nixos#Tutturuu"
    run echo "Done..."

}


# Main
clean_and_update