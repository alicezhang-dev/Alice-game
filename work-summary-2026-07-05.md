# Animal Simulator 3D — Work Summary (July 5, 2026)

## The starting question
Why could the Poki game *Dragon Simulator 3D* flap its wings, while the dragon in our HTML game (Animal Simulator 3D) could not?

**Answer:** Flapping is *animation*, and animation needs three things: a mesh (the shape), a skeleton/rig (bones inside the wings), and an animation clip (recorded wing motion). Turning images into a 3D shape only gives the mesh — no wing bones and no flap animation — so there was nothing to move. Image-to-3D tools also tend to fuse the wings to the body as one solid piece.

## Key findings
- **HTML isn't the limitation.** A "3D game in HTML" runs on WebGL via Three.js, which *can* flap wings. The missing bones/animation were the real problem.
- **Publishing on Poki drives the language choice.** Poki only accepts **HTML5** games (Three.js is a perfect fit; Unity works via WebGL export; Roblox and Scratch cannot publish to Poki). Sticking with HTML was the right call.
- **Where to get free rigged models:** Sketchfab is the best source (filter Downloadable + Free + Animated + Rigged, download as `.glb`; check for CC0/CC-BY license). Also Meshy, RigModels, Free3D, TurboSquid.

## Models used
Three real rigged `.glb` models now drive the game (in `animal-models/`):

| Species | Model file | Animation |
|--------|-----------|-----------|
| Dragon | `dragon.glb` | Full Blender rig with wing bones (`fly1`/`fly2`, arms) — **flaps** (249-channel clip) |
| Bird | `phoenix_bird.glb` | Rigged wings — **flaps & flies** (264-channel clip) |
| Cat | `trotting_cat.glb` | **Trots** (82-channel clip) |

*Note:* the first dragon model tried (`dragon_colascorpio_-_busto.glb`) was a "busto" (bust) with no wings and no real animation, so it could not flap. It was replaced with `dragon.glb`.

## Changes made to `dragon-cat-bird-simulator.html`
1. Added Three.js **SkeletonUtils** (needed to correctly clone rigged/animated models).
2. Rewired the model loader to load the three `.glb` files per species, normalize size, and set up an **AnimationMixer** that plays each model's flap/fly/trot clip.
3. Pointed `buildDragon`, `buildBird`, and `buildCat` at their real models (with the old procedural shapes kept as a fallback).
4. Updated the render loop to advance all animations every frame.
5. Simplified the UI: since each species now has one model, clicking Dragon/Cat/Bird starts the game directly (no breed-picker screen); the Level-2 family picker shows a single card.
6. Original file backed up as `dragon-cat-bird-simulator.backup.html`.

## How to run
Open through a **local server** (not by double-clicking), or Chrome will silently fail to load the `.glb` files:

```
cd Alice-game
python3 -m http.server
# then open http://localhost:8000/dragon-cat-bird-simulator.html
```

## Tunable / still open
- **Model facing:** if a model flies backward or sideways, adjust `MODEL_YAW` (try `Math.PI` or `±Math.PI/2`) near the top of the model config.
- **Model size:** adjust `MODEL_HEIGHT` per species if a model looks too big/small.
- Not yet verified live in-browser (flap direction, facing, scale).

## For Poki later
Keep initial download under ~8 MB, add the Poki SDK, and provide static + animated thumbnails.
