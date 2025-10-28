# Music Prompt‑Engineering Starter Pack (v1)
Modular prompting for music, designed for non‑musicians and engineers. Reuse the same discipline you use for images: small deltas, locked seeds, clean logs.

**Legend:**  
- 🛠 **PE** = Prompt‑engineering–specific (model/automation knobs)  
- 🎨 **ART** = General music craft (motif, harmony, groove)  
- 🔁 **BOTH** = Useful in both PE and music craft

---
## Phase 1 — Foundations (🔁 BOTH)
**Goal:** generate coherent sketches you can iterate on.  
**Concepts:** key, BPM, meter, 4/8‑bar loops, verse/chorus/bridge.

**Baseline prompt skeleton**
```
[MOTIF] short {2–4 bar} hook; interval shape {stepwise | leaps at bar ends}
[HARMONY] key {C minor}; mode {aeolian}; loop length {8 bars}
[GROOVE] BPM {96}; meter {4/4}; feel {laid-back swing 55% | straight}
[INSTRUMENTATION] {drums: dry kit}, {bass: warm}, {lead: plucky synth}, {pads: airy}
[MOOD] {uplifting | moody | contemplative}
[FORM] {Intro 4b} {Verse 16b} {Chorus 16b} {Bridge 8b} {Outro 4b}
[NEGATIVES] no auto-tune artifacts; no distorted guitars; no busy hi-hats
[OUTPUT] length {90s}; seed {1234}
```

**Drills (5–10 min each)**
- A/B BPM only (±10) and keep everything else fixed.  
- Swap **instrumentation** only (synth lead → pizzicato strings).  
- Lock a “golden seed,” branch `S+1`/`S+2`, pick a winner.

---
## Phase 2 — Style & Palette (🎨 ART + 🛠 PE)
**Goal:** control timbre and harmony like you control color/texture.

- **Sound palette card (like a swatch):**  
  - Lead: “plucky square with fast attack”  
  - Pad: “tape-warped choir, low-pass 8 kHz”  
  - Perc: “dry rim, no reverb”  
  - FX: “wow/flutter 1.5%, noise −35 dB”
- **Harmony limits:** choose 1 progression per section (e.g., **i–VI–III–VII** for chorus) and don’t change it until late.
- **Negatives (failure modes):** “no sidechain pump,” “no wide stereo on bass,” “no over-compressed master.”

---
## Phase 3 — Prompt as Code (🛠 PE)
**Goal:** reusable macros + clean versioning.

- **Macro headers:** declare key/BPM/meter/instruments once per project.  
- **Changelog:** v1.0 seed 314159 (BPM 96), v1.1 (swap pad), v1.2 (raise chorus by +2 semitones).  
- **Attention weighting analogues:** “lead foreground, −6 dB on pads; drums tight, short room; vocal jumps +3 dB in chorus.”

---
## Phase 4 — Arrangement & Consistency (🔁 BOTH)
**Goal:** multi‑pass like image pipelines.

1. **Pass A (motif):** generate 8 bars lead + bass only.  
2. **Pass B (harmony):** lock chords; test 2 voicing options.  
3. **Pass C (groove):** drums/percussion only; tight vs roomy.  
4. **Pass D (orchestration):** introduce pads/secondary hooks.  
5. **Pass E (space/mix):** reverb size, stereo width, buss compression.  
**Rule:** change ≤2 parameters per pass.

---
## Phase 5 — Production & QA (🎨 ART)
**Readability checks (music edition):**
- **Hook test:** can you hum the motif after one listen?  
- **Contrast:** verse instrument count vs chorus (+2 new layers in chorus).  
- **Value (grayscale) analog:** **loudness & density map**—only one section gets peak energy.  
- **Mix sanity:** kick/bass mono, sub below 120 Hz mono; lead not masked by pad.

---
# Six Reusable Music Macros (copy/paste, fill braces)

## 1) Hook/Motif Generator
```
[MOTIF] 2–4 bar catchy hook; stepwise motion with leap at bar end; range ≤ 8 semitones
[KEY] {G Dorian} [BPM] {96} [METER] {4/4}
[INSTRUMENTATION] lead {plucky synth}, bass {warm sub}, minimal drums {kick/snare}
[MOOD] hopeful, nocturnal city glow
[NEGATIVES] no melisma vocals; no auto-tune artifacts; no cymbal wash
[OUTPUT] 30s loop; seed {####}
```

## 2) Groove Builder (Drums‑First)
```
[GROOVE] BPM {100}, pocket {laid-back 53%}, swing {10%}
[DRUM KIT] dry, short room; kick tight; snare wood rim; hats sparse
[STRUCTURE] 8 bars: bars 1–4 basic; bars 5–8 add ghost notes + fill at bar 8
[NEGATIVES] no crash cymbals; no long tails; no sidechain pump
[OUTPUT] drums-only stem; seed {####}
```

## 3) Harmony Loop to Song Map
```
[HARMONY] key {E minor}; chorus progression {i–VI–III–VII}; verse {i–iv–v}
[VOICE-LEADING] smooth, ≤ step between chords in top voice
[FORM] Intro 4b | Verse 16b | Chorus 16b | Verse 16b | Chorus 16b | Bridge 8b | Chorus 16b | Outro 4b
[INSTRUMENTATION] piano block chords at verse; chorus add pads + counterline
[NEGATIVES] no borrowed chords; avoid modulation on first pass
[OUTPUT] 90s; seed {####}
```

## 4) Orchestration Swap (Timbre A/B)
```
[INSTRUMENTATION_A] lead {analog brass}, pad {lo-fi choir}, bass {sine}, perc {brush kit}
[INSTRUMENTATION_B] lead {electric guitar clean}, pad {tremolo organ}, bass {picked}, perc {808 minimal}
[KEEP] same motif, same harmony, same BPM
[COMPARE] choose winner based on hook clarity + chorus lift
[OUTPUT] two 60s versions; seed {####}
```

## 5) Space & Mix Profile
```
[SPACE] small room on drums (0.4s), plate on lead (1.2s), pads hall (2.5s), bass dry
[STEREO] bass mono <120 Hz; lead center; pads wide; hats 30% L/R
[DYNAMICS] gentle buss comp 1.5:1, slow attack, fast release
[NEGATIVES] no brickwall limiting; no extreme wideners; keep crest factor intact
[OUTPUT] stems + premaster; seed {####}
```

## 6) Style Transfer with References
```
[REF_TRACKS] groove feel like {Ref A}; harmony color like {Ref B}; space/mix like {Ref C}
[DELTA] keep only feel/space; new motif & chords; new instrumentation {strings + synth}
[KEY/BPM] {A minor}/{88}; [FORM] verse-chorus; [MOOD] bittersweet triumphant
[NEGATIVES] no vocal ad-libs; no guitar distortion
[OUTPUT] 90s draft; seed {####}
```

---
## Five Essential Music Principles (the “Appendix G” of music)
- 🎨 **Motif First:** a tune you can hum > sound design. Write 2–4 bars that loop cleanly.  
- 🔁 **Contrast by Section:** add/remove 2 layers at chorus; change register, not just volume.  
- 🎨 **Rhythm Pocket:** pick one feel (straight or swung) and be consistent.  
- 🎨 **Timbre Economy:** 1 lead, 1 bass, 1 pad, 1 percussive color—avoid stacking similar roles.  
- 🔁 **Form Clarity:** label sections (V/C/Br), keep lengths in 4s or 8s; surprise with **one** twist only.

---
## Versioning & Notes (🛠 PE)
- Name files like `Song_{slug}_vX.Y_seed####.md` and keep a short changelog.  
- For Stable Diffusion‑style music tools: treat weights as instrument priorities; change one at a time.  
- For generative DAWs/plugins: lock BPM/key early; export stems per pass.  
- Keep a **NEGATIVES** list per project (e.g., “no sidechain pump,” “no wide bass,” “no cymbal wash”).

