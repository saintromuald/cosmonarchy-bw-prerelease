#!/bin/bash
# ============================================================================
# Cosmonarchy Remastered launch — Samase against the player's StarCraft:
# Remastered install. Shipped with the game (this file lives in the game
# repo under remastered/); the launcher's private bundle delegates to it.
#
# Flow: boots SC:R with the Cosmonarchy mod data (loose-file tree), lands on
# the in-game Battle.net login / main menu (first run needs the player's
# own login), and the game runs with full HD rendering. CMBW maps are
# linked into the SC:R install's map folder so the in-game map list shows
# them (Custom -> CMBW-Root).
#
# Environment overrides:
#   COSMO_MOD_DIR       mod folder (defaults: launcher version installs)
#   COSMO_BNET_PREFIX   Battle.net Wine prefix (default ~/Games/battlenet)
#   COSMO_GE_PROTON     GE-Proton dir (default: GE-Proton11-7)
#   COSMO_MAP           direct map launch (best effort; login flow is the
#                       primary path)
#   COSMO_USE_64BIT=1   force the 64-bit client (menu may render black)
# ============================================================================
set -euo pipefail
SELF="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- mod data ---------------------------------------------------------------
MOD_DIR="${COSMO_MOD_DIR:-}"
if [ -z "$MOD_DIR" ] || [ ! -d "$MOD_DIR" ]; then
    ROOT="$HOME/Games/cosmonarchy/prefix/drive_c/Cosmonarchy"
    for c in \
        "$ROOT/versions/plus-prerelease-latest/mpq" \
        "$ROOT/versions/plus-release-latest/mpq" \
        "$ROOT/Prerelease/mpq" \
        "$ROOT/Release/mpq" \
        "$HOME/Projects/cosmonarchy-hd/mod"; do
        if [ -d "$c" ]; then MOD_DIR="$c"; break; fi
    done
fi
if [ -z "$MOD_DIR" ] || [ ! -d "$MOD_DIR" ]; then
    echo "cosmonarchy mod data not found (set COSMO_MOD_DIR)" >&2
    exit 1
fi
GAME_ROOT="$(cd "$MOD_DIR/.." && pwd)"

# --- Battle.net prefix ------------------------------------------------------
BNET="${COSMO_BNET_PREFIX:-$HOME/Games/battlenet}"
if [ ! -d "$BNET/drive_c/Program Files (x86)/StarCraft" ]; then
    echo "StarCraft: Remastered install not found in $BNET — install it via Battle.net first." >&2
    exit 1
fi

# --- Proton / wine ----------------------------------------------------------
GE="${COSMO_GE_PROTON:-}"
if [ -z "$GE" ]; then
    # 11-7 is the pinned, boot-verified default; set COSMO_GE_PROTON to opt
    # into a newer GE-Proton.
    GE="$HOME/.local/share/Steam/compatibilitytools.d/GE-Proton11-7-x86_64"
    [ -d "$GE/files/bin" ] || GE="$(ls -d "$HOME"/.local/share/Steam/compatibilitytools.d/GE-Proton*-x86_64 2>/dev/null | sort -V | tail -1)"
fi
if [ -z "$GE" ] || [ ! -d "$GE/files/bin" ]; then
    echo "GE-Proton not found — install it into ~/.local/share/Steam/compatibilitytools.d/" >&2
    exit 1
fi

export WINEPREFIX="$BNET"
export PATH="$GE/files/bin:$PATH"

# --- prefix repairs (idempotent) --------------------------------------------
# SC:R's CEF browser (login/menu UI) renders black under Wine unless GLES is
# disabled; Chromium then falls back to its D3D11/ANGLE path (DXVK).
wine reg add 'HKCU\Software\Wine\DllOverrides' /v libglesv2 /d disabled /f \
    >/dev/null 2>&1 || true

# --- maps: link CMBW maps into the SC:R install so the in-game map list
#     shows them (Custom -> CMBW-Root) ---------------------------------------
SC_MAPS="$BNET/drive_c/Program Files (x86)/StarCraft/Maps"
CM_ROOT="$HOME/Games/cosmonarchy/prefix/drive_c/Cosmonarchy"
for src in "$GAME_ROOT/../Starcraft/Maps/CMBW-Root" \
           "$GAME_ROOT/../../Starcraft/Maps/CMBW-Root" \
           "$CM_ROOT/Starcraft/Maps/CMBW-Root"; do
    if [ -d "$src" ] && [ ! -e "$SC_MAPS/CMBW-Root" ]; then
        ln -s "$src" "$SC_MAPS/CMBW-Root" 2>/dev/null || true
    fi
done

WINMOD="Z:${MOD_DIR//\//\\\\}"

# --- optional direct map launch ---------------------------------------------
MAPARG=()
if [ -n "${COSMO_MAP:-}" ] && [ -f "$COSMO_MAP" ]; then
    WINMAP="Z:${COSMO_MAP//\//\\\\}"
    case "$COSMO_MAP" in
        "$BNET"/drive_c/*)
            WINMAP="${COSMO_MAP#$BNET/drive_c/}"; WINMAP="C:${WINMAP//\//\\\\}";;
    esac
    MAPARG=(--map "$WINMAP")
fi

# Stable log location: the bundle dir when delegated, else beside the script.
LOG_DIR="${SAMASE_LOG_DIR:-$HOME/.local/share/cosmonarchy-remastered}"
[ -d "$LOG_DIR" ] || LOG_DIR="$SELF"
cd "$LOG_DIR"
echo "remastered/run.sh: mod=$MOD_DIR (delegated log dir: $LOG_DIR)" >&2

# The game can start with its window withdrawn/dormant under Wine. Watch for
# the window and map it as soon as it appears; one Return nudges the game
# (skips the intro).
DISP="${DISPLAY:-:0}"
(
    for _ in $(seq 1 90); do
        WID=$(DISPLAY="$DISP" xdotool search --name "Brood War" 2>/dev/null | head -1)
        if [ -n "$WID" ]; then
            DISPLAY="$DISP" xdotool windowmap "$WID" 2>/dev/null
            DISPLAY="$DISP" xdotool windowactivate "$WID" 2>/dev/null
            sleep 1
            DISPLAY="$DISP" xdotool key --window "$WID" Return 2>/dev/null
            DISPLAY="$DISP" xdotool windowmap "$WID" 2>/dev/null
            exit 0
        fi
        sleep 2
    done
) &

# HD sprites stay enabled (that is the point of the Remastered launch).
# Samase binaries live next to the launcher's bundle entry script; when this
# script is run directly from the game repo, find them there too.
SAMASE_DIR="${SAMASE_DIR:-$SELF}"
if [ "${COSMO_USE_64BIT:-}" != "1" ] && [ -f "$SAMASE_DIR/samase.exe" ]; then
    GAME32="$BNET/drive_c/Program Files (x86)/StarCraft/x86/StarCraft.exe"
    if [ -f "$GAME32" ]; then
        exec wine "$SAMASE_DIR/samase.exe" --log "${MAPARG[@]}" "$WINMOD"
    fi
fi

exec wine "$SAMASE_DIR/samase64.exe" "${MAPARG[@]}" "$WINMOD" --log --no-debug
