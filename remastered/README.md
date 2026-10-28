# Cosmonarchy Remastered — graphics pass

Cosmonarchy's own sprites, rebuilt to StarCraft: Remastered class. This tree
carries the launch script (`remastered/run.sh`, see below) and, under
`mpq/anim/`, HD `.anim` sprite files (SC:R format 0x0204) generated from the
mod's GRPs by the cleanroom toolchain in `cosmonarchy-hd/tools`.

## What is where

| Path | Content |
|---|---|
| `remastered/run.sh` | SC:R launch script the bundle entry delegates to (HD on, CEF repair, version-install aware, CMBW map linking) |
| `mpq/anim/main_XXX.anim` | one HD sprite per Cosmonarchy image id |
| `mpq/unit/**` | the mod's SD GRPs (kept: SD mode + frame metadata reference) |

## Why the anims exist

SC:R renders a sprite from `anim\main_XXX.anim` keyed by the image id. For
image ids the mod redefines or adds, Blizzard has no HD art, so the game
falls back to the SD GRP (blurry at HD zoom). Each `main_XXX.anim` here is
built from the mod's own GRP, upscaled to the 4x grid Blizzard's HD sprites
use, with a teamcolor layer (palette indices 8-15) so player colours work
exactly like the SD art. Classic-BW units that Cosmonarchy redrew get the
same treatment from their Cosmonarchy sprites; BW-original art never ships
here (players already have it through their own SC:R install).

## Pipeline (cleanroom)

1. `grpinventory.py` — inventory/classify the mod's GRPs.
2. image id -> GRP mapping: `mpq/samase/images_ext.txt` (id, name, grp_id)
   plus `mpq/arr/images.txt` (line N = image id N-1), matched to the mod's
   `unit/**/*.grp` files by name.
3. `animpack.py <grp> <palette.wpe> <out.anim>` — GRP frames -> 4x sheet,
   DXT1 diffuse + DXT1 teamcolor mask, 0x0204 container (format implemented
   from the public SEN wiki / SCR-Graphics documentation; cross-checked
   against the on-disk behaviour of the shipped game).
4. `batch_anims.py <map.json> <mod> <out>` — builds the whole mapped roster.
   The batch output is large (~2-4 GB) and is distributed via the launcher's
   Remastered bundle channel, not committed to this repo.

## Verify

- `tools/animdump.py` (cosmonarchy-hd) re-parses a built anim.
- Game-side: launch via Play Remastered; `samase.log` must show
  `Loading custom anim/main_XXX.anim` for each shipped image (not
  `No custom file` / `dummied out`), and the game must keep running.

## Status

- Launch path: working (HD on, login/menu flow; first run needs the player's
  own Battle.net login).
- Pilot: `mpq/anim/main_017.anim` (Droleth) shipped and load-verified.
- Full roster: mapped ~440 unit images; batch build in progress.
