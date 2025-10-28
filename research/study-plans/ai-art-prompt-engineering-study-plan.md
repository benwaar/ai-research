# 🧭 AI Art Prompt‑Engineering Study Plan (Revised + Tagged)
### Procedural Creativity • Visual Pipelines • Modular Design Thinking

**Legend:**  
- 🛠 **PE** = Prompt‑engineering–specific (model/automation knobs)  
- 🎨 **ART** = General art & design craft (composition, color, print)  
- 🔁 **BOTH** = Useful in both prompt‑engineering and general art workflow

---
## Learning outcomes
By the end of this plan you will be able to:

- 🔁 Think and build prompts like a procedural designer — compose prompts as modular, reusable systems.
- 🔁 Maintain visual consistency across long projects — apply a Style Bible and asset discipline to avoid drift.
- 🔁 Prototype and iterate with version control discipline — tag prompt revisions, track seeds, and document changes.
- 🔁 Treat **STYLE**, **MOOD**, and **TEXTURE** as modular layers — toggle, test, and combine them independently.
- 🔁 Output print‑ready, reproducible visuals — produce assets that meet production and reproduction constraints.

---
## **Phase 1 – Foundations · Thinking in Modules**
**Goal:** understand how DALL·E (and similar models) interpret structured language.

**Concepts**
- 🛠 **PE** Core modules: `[COMPOSITION]`, `[SUBJECT]`, `[STYLE]`, `[COLOR]`, `[TEXTURE]`, `[LIGHTING]`, `[MOOD]`, `[DETAILS]`, `[OUTPUT]`.
- 🎨 **ART** Geometry constraints · ratio statements · symmetry.
- 🔁 **BOTH** Vocabulary seeding · style tokens.
- 🔁 **BOTH** Reference‑anchored prompting · seed reuse.
- 🔁 **BOTH** STYLE / MOOD / TEXTURE as independent toggleable layers.

**Exercises**
1. 🛠 **PE** Write one prompt using all core blocks.  
2. 🔁 **BOTH** Generate three images changing **only [COLOR]** (A/B test discipline).  
3. 🎨 **ART** Write geometry specs (e.g., “object = ¼ canvas height”).  
4. 🔁 **BOTH** Upload a reference; vary one structural parameter.  
5. 🔁 **BOTH** Observe visual drift when STYLE / MOOD / TEXTURE are toggled individually.  

---
## **Phase 2 – Style & Surface · Visual Semantics**
**Goal:** develop control over aesthetics and surface feel.

**Concepts**
- 🔁 **BOTH** Reversible layers: STYLE ↔ TEXTURE ↔ MOOD.  
- 🎨 **ART** Color harmony · value mapping · grayscale readability.  
- 🎨 **ART** Texture vocab: distressed / halftone / risograph / grain.  
- 🎨 **ART** Lighting direction · material realism.  
- 🎨 **ART** **Lighting micro‑glossary** (key/fill/rim/back; overcast skylight vs softbox; hard vs soft shadows; 35mm vs 85mm perspective cues).
- 🎨 **ART** **Palette discipline**: 3–5 colors max; name pigments (e.g., ultramarine, yellow ochre) or HEX codes.

**Exercises**
1. 🎨 **ART** Render same subject in three style eras (’70s retro, Bauhaus, Y2K).  
2. 🔁 **BOTH** Swap only **TEXTURE** layer (10% vs 40% wear).  
3. 🎨 **ART** Compare grayscale clarity across all variants.  
4. 🔁 **BOTH** Lighting‑only sweep: north‑light window / clamshell / hard noon / overcast; evaluate edge acuity & shadow shapes.  
5. 🎨 **ART** Warm vs cool limited palettes; compare value separation in grayscale.

---
## **Phase 3 – Prompt as Code · Macro Thinking**
**Goal:** treat prompts as composable functions.

**Concepts**
- 🛠 **PE** JSON macro set structure.  
- 🛠 **PE** Prompt DSL syntax: `>`, `//`, `:`, `[]`, `--`.  
- 🛠 **PE** Iteration ladder (v1 → v1.3) & version tags.  
- 🛠 **PE** Negative prompting · output constraints.  
- 🔁 **BOTH** Prompt archive + changelog discipline.  
- 🛠 **PE** Environment Header (declare macros once per project).  
- 🛠 **PE** **Attention weighting**: `(token:1.2–1.6)` emphasize; `[token:0.7–0.9]` de‑emphasize; in SD, balance with CFG scale (typ. 7–12).  
- 🛠 **PE** **Seed branching strategy**: lock a golden seed; branch `S`, `S+1`, `S+2`; record lineage back to parent.

**Exercises**
1. 🛠 **PE** Build one base JSON macro file and generate 5 subjects from it.  
2. 🛠 **PE** Implement `NEGATIVE` block to forbid unwanted effects — include concrete failure modes (extra fingers, watermark, mushy edges, text artifacts).  
3. 🔁 **BOTH** Document each iteration (v1.x) with notes & seed; maintain a changelog.  
4. 🛠 **PE** Attention‑weighting micro‑test: vary a focal noun from 1.0 → 1.6; log artifacts; adjust CFG accordingly.  
5. 🛠 **PE** Branch seeds from a chosen “golden seed,” compare results, and select a canonical branch for the Style Bible.

---
## **Phase 4 – Advanced Pipelines**
**Goal:** master multi‑pass generation and consistency control.

**Concepts**
- 🔁 **BOTH** Multi‑pass workflow: composition → style → texture → lighting.  
- 🔁 **BOTH** Reference image anchoring & seed reuse.  
- 🛠 **PE** Inpainting / regional editing passes.  
- 🛠 **PE** Programmatic macro assembly (ComfyUI, ChatGPT → DALL·E scripts).  
- 🔁 **BOTH** Feedback‑loop rule (change ≤ 2 parameters per run).  
- 🔁 **BOTH** Reverse‑layer testing (toggle STYLE, MOOD, TEXTURE separately).  
- 🛠 **PE** **Composition‑first ordering rule**: front‑load `[COMPOSITION]` & `[SUBJECT]` before style adjectives to avoid style overfitting.

**Exercises**
1. 🔁 **BOTH** Multi‑pass generation A/B/C; record deltas between passes.  
2. 🛠 **PE** Lock SUBJECT; iterate only `[TYPO]` + background (controlled variance).  
3. 🛠 **PE** Masking exercise – edit aura only.  
4. 🔁 **BOTH** A/B batch: palette A vs B; texture 20% vs 35% — change max two parameters per run.  
5. 🛠 **PE** Reorder prompt (style‑first vs composition‑first) and compare framing drift.

---
## **Phase 5 – Print‑Ready Thinking**
**Goal:** build outputs suitable for real production.

**Concepts**
- 🎨 **ART** Spot‑color discipline · grayscale separation.  
- 🎨 **ART** Halftone simulation · overprint planning.  
- 🎨 **ART** Edge cleanup · vectorization · path simplification.  
- 🎨 **ART** **Film/print cues:** Tri‑X 400 pushed 1 stop, halation, optical diffusion, cotton rag paper scan overlay, subtle vignette for containment.

**Exercises**
1. 🎨 **ART** Limit to 3–4 inks; verify value contrast.  
2. 🎨 **ART** Export → vectorize → inspect at 150%.  
3. 🔁 **BOTH** QA check: edges, registration, grain consistency; assess halation/diffusion overlay vs clean export.

---
## **Phase 6 – Visual Bible & Asset Library**
**Goal:** ensure global consistency across projects.

**Concepts**
- 🎨 **ART** Style Bible (visual DNA).  
- 🔁 **BOTH** Folder architecture (`/Style_Bible/ /Prompts/ /Generated/ /Finals/`).  
- 🔁 **BOTH** Style token reuse · macro index · seed tracking.  
- 🛠 **PE** “Base Style Block” reuse (e.g., Utala header).  
- 🛠 **PE** Seed lineage tracking: record parent/branch seeds and canonicalize the winning branch.

**Exercises**
1. 🎨 **ART** Compile palette (HEX), line weights, texture % into a Style Card.  
2. 🎨 **ART** Generate coordinated set (T‑shirt, poster, sticker).  
3. 🔁 **BOTH** Verify color / texture consistency across all assets; cross‑check against Style Bible and seed lineage.

---
## **Phase 7 – Quality Gates & Review**
**Goal:** audit, document, and maintain creative reproducibility.

**Checklist**
- 🎨 **ART** Thumbnail legibility · grayscale map · text spacing.  
- 🎨 **ART** Edge cleanup · no unintended gradients.  
- 🔁 **BOTH** Prompt archive + metadata stored with file.  
- 🔁 **BOTH** Visual consistency vs Style Bible (include seed lineage reference).  
- 🛠 **PE** **Failure‑mode checks:** hands/eyes sanity, watermark/text artifacts, mushy edges.

---
## **Appendix A – Workflow Hygiene**
- 🔁 **BOTH** File naming pattern: `Project_Element_vX.Y_modifier.png`.  
- 🔁 **BOTH** Folder tree discipline · seed logs.  
- 🛠 **PE** Environment Header macro at top of each prompt document.

---
## **Appendix B – Macro Header Template (Example Utala)**
```text
###############################################################
# U T A L A  •  M A C R O  D E C L A R A T I O N  H E A D E R
###############################################################

[BASE_STYLE]
In the established *Utala* visual style — sacred geometry + sci‑fi minimalism.  
Perfect symmetry, fine etched lines, matte graphite texture, luminous engraving.

[COLOR_SYSTEM]
Yellow = Body | Blue = Mind | Brown = Memory | Green = Unity.

[MATERIAL_BLOCK]
Surface = matte graphite / brushed metal | Lighting = diffuse glow.

[FX_GLOW]
Subtle green inner aura — soft, no bloom.

[MOOD_BLOCK]
Calm power · sacred technology · harmony through structure.

[PRINT_SPECS]
High contrast · vector clarity · foil/matte ready · ≥ 4K render.
```

---
## **Appendix C – Layered Prompt Example (JSON)**
```json
{
  "layers": {
    "STYLE":   { "on": true,  "value": "Minimalist retro T-shirt vector; clean geometry." },
    "MOOD":    { "on": true,  "value": "Playful, nostalgic, sun-faded." },
    "TEXTURE": { "on": true,  "value": "Distressed screen-print, 25 % wear." }
  },
  "negative": "No gradients, no metallic shine, no busy background.",
  "notes": "(mascot:1.4) to emphasize subject; [background:0.8] to de-emphasize; CFG=9"
}
```

---
## **Appendix D – Learning Outcomes ↔ Professional Practices**

| Professional Practice (from consistency guide) | Covered in the Plan / Learning Outcomes | Where it Appears in the Study Plan |
|---|---|---|
| **1. Use Reference Images (Seeded or Uploaded)** | ✔ Maintain visual consistency across projects — reference‑anchored prompting and seed reuse | *Phase 4 – Advanced Pipelines* → “Reference image anchoring & seed reuse”; exercises use inpainting and seed control. |
| **2. Lock the Style with a “Style Token” Prompt** | ✔ Maintain visual consistency — apply a Style Bible and reuse style tokens to prevent drift | *Phase 1 – Foundations* (“Vocabulary seeding · style tokens”) and *Phase 6 – Visual Bible & Asset Library*. |
| **3. Describe Structure, Not Just Texture** | ✔ Think and build prompts like a procedural designer — use compositional ratios, geometry, and axis alignment | *Phase 1 – Foundations* → “Geometry constraints, ratio statements, symmetry” within `[COMPOSITION]` block. |
| **4. Iterate with “Edit Image” Instead of New Prompts** | ✔ Prototype and iterate with version control discipline — refine rather than restart | *Phase 4 – Advanced Pipelines* → “Inpainting / regional editing passes” and “Feedback loop rule (≤ 2 parameter changes per run)”. |
| **5. Maintain a Visual Bible** | ✔ Maintain visual consistency and asset discipline — build a shared visual language document | *Phase 6 – Visual Bible & Asset Library* → palettes, textures, glyph grids, and style documentation. |

---
## **Appendix E – Model Cheatsheet (Quick Tuning Notes)**

**Stable Diffusion (local/WebUI)**  
- 🛠 **PE** Use attention weights `(term:1.2–1.6)` / `[term:0.7–0.9]`.  
- 🛠 **PE** Balance with CFG 7–12; higher = stricter to text, risk of overshoot.  
- 🛠 **PE** Strong negatives; curate failure‑mode list.  
- 🛠 **PE** LoRAs/ControlNets for pose/layout; seeds matter a lot.

**Midjourney**  
- 🛠 **PE** Word order matters; keep prompts concise.  
- 🛠 **PE** Explore with `--stylize` and `--chaos` (controlled); grid‑compare like A/B tests.  
- 🔁 **BOTH** Reference images to anchor composition; upscale vs vary for branching.

**DALL·E‑style**  
- 🛠 **PE** Clear natural language; fewer knobs.  
- 🔁 **BOTH** Provide 1–3 refs and specify composition/lighting plainly; iterate with edit/mask tools for consistency.

---
## **Appendix F – Composition‑First Prompt Ordering (Example)**
```
[COMPOSITION] wide establishing shot, foreground foliage frame, horizon upper third
[SUBJECT] mossy shrine, fox statue, falling camellia petals
[LIGHTING] dappled midday sunbeams, light fog
[STYLE] hand-painted cel shading, watercolor washes
[COLOR] spring greens with vermilion accents; low-contrast shadows
[TEXTURE] paper grain, light bloom on highlights
[NEGATIVE] no photoreal textures, no hard specular highlights, no text
[OUTPUT] --ar 16:9 --seed 314159
```

---
## **Appendix G – Core Artistic Principles (Essentials)**
These fit both non‑engineer artists and engineers new to art. Each includes a rule, a 60‑second diagnostic, and a 5‑minute drill.

1) 🎨 **Value Hierarchy = Readability**  
- **Rule:** If it works in grayscale at thumbnail size, it will read in color at full size.  
- **60‑sec diagnostic:** Convert to grayscale & shrink to ~200px. Can you separate subject, midground, background instantly?  
- **5‑min drill:** Paint/fill with only 3 values (dark/mid/light). Place the focal point in the highest‑contrast zone.

2) 🔁 **Focal Point & Visual Hierarchy**  
- **Rule:** One area wins; everything else supports via contrast, isolation, scale, or detail.  
- **60‑sec diagnostic:** Squint—where does your eye land first? If it’s not immediate, hierarchy is muddy.  
- **5‑min drill:** Duplicate your image. In A, boost contrast at the subject. In B, reduce detail elsewhere. Compare eye flow.

3) 🎨 **Shape Language & Proportion (Big–Medium–Small)**  
- **Rule:** Strong silhouettes and clear proportion rhythms beat tiny details. Aim for ~60/30/10 mass split.  
- **60‑sec diagnostic:** Fill subject as a black silhouette—recognizable and interesting without interior lines?  
- **5‑min drill:** Redesign the same object three times, rotating which mass is “big.” Keep silhouettes unique.

4) 🎨 **Edges: Hard / Soft / Lost**  
- **Rule:** Depth & focus are edge management: hard at focal, soft on form turns, lost in atmosphere overlaps.  
- **60‑sec diagnostic:** Mark where edges are crisp vs soft. Do hard edges cluster at the focal point?  
- **5‑min drill:** Take a render. Soften all edges except 3–5 “hero” edges near the focal point; confirm form still reads.

5) 🔁 **Gesture & Flow (Line of Action)**  
- **Rule:** Start with the energy curve; details ride on top. A good gesture survives massive simplification.  
- **60‑sec diagnostic:** Can you draw the piece’s “one‑line” flow in 3 seconds? If not, the inner rhythm is weak.  
- **5‑min drill:** Do five 30‑second gestures of your subject. Build one clean drawing on the strongest gesture only.

**Cross‑links:** See Phase 1 (composition/geometry), Phase 2 (value & lighting checks), Phase 7 (thumbnail/readability QA).

---
## **Appendix H – Assistant Notes (for future runs)**
Operational notes for any AI assistant supporting this plan.

- **Tag awareness:** Respect markers — 🛠 PE (model control), 🎨 ART (craft), 🔁 BOTH (bridges). When presenting advice, surface 🔁 items first for widest impact.  
- **Prompt ordering:** Always front‑load `[COMPOSITION]` and `[SUBJECT]` before style adjectives.  
- **Change budget:** Enforce “≤ 2 variables per run.” If a user asks for many changes, queue them as sequential steps.  
- **Seeds & lineage:** When a run succeeds, lock the seed, name it, and branch `S+1`, `S+2` for exploration; record lineage in the changelog.  
- **Attention weights & CFG:** For SD: start `(focus:1.3)` and CFG 8–10; adjust one at a time.  
- **Negatives:** Maintain a model‑specific negative list (hands/eyes/text/watermark/mushy edges). Remind user to include it in `NEGATIVE`.  
- **References:** Prefer 1–3 reference images to anchor composition/palette/material; describe *deltas* from the refs rather than re‑describing the whole scene.  
- **QA ritual:** Before export, run grayscale thumbnail check (Appendix G #1), edge audit (Appendix G #4), and artifact sweep (Phase 7).  
- **Audience mode:** If the user is an engineer new to art, recommend reading Appendix G first, then Phases 1→2. If the user is an artist new to PE, recommend Phases 1→3, then Appendix E.
