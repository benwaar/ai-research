# Graphic Novel Prompt‑Engineering Starter Pack (v1)
Modular prompting and process for planning & scripting comics/graphic novels. Works for solo creators and teams. Keep the same discipline: small deltas, locked “seeds” (IDs), and clean logs.

**Legend:**  
- 🛠 **PE** = Prompt‑engineering–specific (structure/automation knobs)  
- 🎨 **ART** = Comics craft (story, layout, visual storytelling)  
- 🔁 **BOTH** = Useful in both PE and comics craft

---
## Core Modules
`[LOGLINE] [THEME] [CHARACTERS] [SETTING] [STRUCTURE] [BEATS] [PAGE GRID] [PANELING] [CAMERA] [DIALOGUE] [CAPTIONS] [STYLE BIBLE] [REFS] [NEGATIVES] [OUTPUT]`

**Engineering knobs (🛠 PE):** page count, issue length, beats per act, grid (3x3, 6‑panel, widescreen), panels/page cap, balloons/panel cap, words/panel cap (~20–25 max), letter size, page‑turns on even pages, seeding via `{issue_id/page_id/panel_id}` for reproducibility.

**Failure‑mode negatives:** “no more than {6} panels per page,” “no scene with >3 balloons per panel,” “avoid 180° line breaks,” “avoid unclear eyelines,” “no exposition overload.”

---
## Phase 1 — Concept & Scope (🔁 BOTH)
**Goal:** define a tractable concept and production scope.

**Deliverables**
- `[LOGLINE]` one‑sentence premise.  
- `[THEME]` what it’s really about in one clause (e.g., “found family vs duty”).  
- `[STRUCTURE]` 3‑act or 4‑act; target **{20–24} pages per issue**.  
- `[STYLE BIBLE]` tone refs (2–3 books/films), art style tag, lettering tone.

**Drills (5–10 min)**
- Write three alternate loglines; pick the one with the strongest conflict.  
- Create a “scope fence”: max cast in issue #1 = {3}, max locations = {3}.

---
## Phase 2 — Beats to Pages (🔁 BOTH)
**Goal:** turn premise into a tight beat sheet and page plan.

- `[BEATS]` 8 major beats (inciting, first turn, midpoint, low point, climax).  
- Map beats → pages: aim for **1 beat per 2–4 pages**.  
- Place reveals on **right‑hand page‑turns** (page 5, 7, 9, …).

**Checks**
- Each page has a purpose (turn, escalation, reveal, character choice).  
- No more than **1 new idea** per page.

---
## Phase 3 — Page Grids & Panel Economy (🎨 ART + 🛠 PE)
**Goal:** choose a default grid and enforce panel/balloon budgets.

- `[PAGE GRID]` pick a default (e.g., 6‑panel) and allow **2 exceptions** per issue.  
- `[PANELING]` one action per panel; foreground/mid/background staging.  
- Budgets: panels/page ≤ {6}; balloons/panel ≤ {3}; words/panel ≤ {25}.

**Drills**
- Rewrite a crowded page into the same content in **4 panels**.  
- Storyboard a chase across **3 pages** with changing grid for pace.

---
## Phase 4 — Scripting Passes (🔁 BOTH)
**Goal:** multi‑pass writing like your art pipeline.

1) **Outline pass:** beats → page summaries (1–2 lines each).  
2) **Layout pass:** pick grid per page; place splash/page‑turns.  
3) **Action pass:** describe panel actions & camera without dialogue.  
4) **Dialogue pass:** add balloons/captions within budget.  
5) **Clarity pass:** eyelines, 180° rule, who speaks first layout.  
6) **Polish pass:** trim words; make endings cliff, button, or echo.

Rule: change ≤ 2 variables per pass.

---
## Phase 5 — Production & QA (🎨 ART)
- **Read at thumbnail:** does each page read in 3 seconds?  
- **Balloon priority:** speaker order left→right/top→bottom.  
- **Contrast:** vary panel sizes/density around key moments.  
- **Continuity:** track props, costumes, time of day.  
- **Lettering sanity:** avoid balloon tails crossing; 10–15% margin.

---
# Six Reusable Macros (copy/paste, fill braces)

## 1) Series/Issue One‑Pager (Bible)
```
[LOGLINE] {protagonist} must {goal} despite {obstacle}, or {stakes}.
[THEME] {x vs y}, shown via {character dynamic}.
[CHARACTERS] {Protag: role, flaw}; {Deuteragonist: role, foil}; {Antagonist: drive}.
[SETTING] {time/place}; {visual motif}; {iconic location}.
[STRUCTURE] {3-act | 4-act}; target {20–24} pages; tone {mood tags}.
[STYLE BIBLE] {art style refs}, {lettering vibe}, {palette anchor}.
[NEGATIVES] no lore dumps; no scene with >2 expository balloons.
[OUTPUT] create beat list and page plan; seed {series_id/issue_01}
```
*Tip:* keep names pronounceable; give every main character a **verb** they own (e.g., “Cato **calculates**”).

---

## 2) Issue Beat Sheet → Page Plan
```
[ISSUE] {#01}; pages {22}; grid {6-panel default}; exceptions {2 splashes}
[BEATS] 1) cold open {hook}; 2) inciting {disruption}; 3) decision; 4) midpoint reversal; 5) low point; 6) rally; 7) climax; 8) tag
[PAGE MAP] assign beats to pages: {p1-2}, {p3-4}, … ensure reveals on right-hand turns
[NEGATIVES] no more than 1 idea per page; avoid double reveals on same spread
[OUTPUT] page-by-page summaries; seed {issue_01/plan_v1}
```
*Tip:* mark **turn pages** explicitly (p5, p7, p9…) and aim big panels before turns.

---

## 3) Page Script Template (Full Script)
```
[PAGE] {p#} of {total}; grid {3x3|6-panel|widescreen}; purpose {reveal|choice|escalation}
[PANELS]
1) (ID {p#-1}) Action: {who does what}; Camera: {angle, distance}; Setting: {where}; Emotion: {beat}
   Dialogue: {CHAR}: {line} (≤ 25 words); {CHAR2}: {line}; SFX: {onoman.}
2) (ID {p#-2}) Action: {...}
...
[CAPTIONS] {optional internal | narrator}
[NEGATIVES] avoid more than {3} balloons; keep eyelines; maintain 180°
[OUTPUT] finished page script; seed {issue_01/p{#}}
```
*Tip:* write **action beats first**, add dialogue later; keeps panels visual.

---

## 4) Panel Camera & Composition Macro
```
[PANEL] (ID {p#-#}) Purpose {introduce|conflict|react|reveal}
[COMPOSITION] {rule-of-thirds | centered | diagonal}; depth {FG/MG/BG}
[CAMERA] {WS | MS | CU | ECU}; angle {eye | low | high | dutch}; lens {35mm | 85mm}
[FOCUS] focal subject {who}; silhouette clarity; lighting {key/fill/rim}
[LETTERING] balloon count {1–2}; speaker order {L→R}; tail routes clear
[NEGATIVES] no unclear eyelines; don’t cross 180°; no crowding margins
[OUTPUT] clean panel brief; seed {issue_01/p#-#}
```
*Tip:* one **action** per panel; multiple actions become separate panels.

---

## 5) Character Sheet (Story & Visual)
```
[NAME] {full}; role {function}; archetype {mentor|rival|trickster}
[WANT/NEED] wants {external goal}; needs {internal growth}
[FLAW] {core weakness}; [TELL] visual shorthand {prop|gesture|silhouette cue}
[COLOR/SHAPE] palette {HEX triplet}; shape language {round|angular|mixed}
[POSE/EXPRESSIONS] 3: {idle}, {determined}, {defeated}
[TURNAROUND] notes for {front|profile|back}; costume layers
[NEGATIVES] avoid generic silhouette; avoid same palette as {other char}
[OUTPUT] 1-page ref; seed {cast/{name_slug}}
```
*Tip:* tie **flaw** to **pose** (e.g., shoulders forward for avoidance).

---

## 6) Art Direction / Style Bible Snippet
```
[LINE] {clean ink | gritty | dry-brush}; [VALUE] {high-contrast | soft}
[COLOR] {limited palette | duotone}; [TEXTURE] {halftone 25% | paper grain}
[LETTERING] {hand-lettered vibe | geometric sans}; SFX style {angular | bubbly}
[LAYOUT] default grid {6-panel}; exceptions {2 splashes}; margins {in mm}; bleed {y/n}
[REFS] {2–3 books/shows} for tone; {artist ref} for line; {palette ref}
[NEGATIVES] no heavy gradients; no photo textures; avoid illegible SFX
[OUTPUT] style card v1; seed {style/v1}
```
*Tip:* keep **style decisions** in one card; enforce across pages to prevent drift.

---
## Five Core Comics Principles (Appendix G‑Comics)
1) 🎨 **Clarity Over Cool:** if the reader can’t tell who did what, when, and why, nothing else matters.  
2) 🎨 **One Action per Panel:** compressing beats kills readability; split actions.  
3) 🔁 **Page‑Turn Reveals:** place twists on right‑hand page turns; build big panels before them.  
4) 🎨 **Balloon Economy:** ≤ 25 words/panel, ≤ 3 balloons/panel; prioritize the first speaker’s position.  
5) 🔁 **Visual Hierarchy:** use panel size/contrast to crown the focal moment on each page.

---
## Assistant Notes (Appendix H)
- **Tag awareness:** Use 🛠/🎨/🔁 markers. Prioritize 🔁 tips for mixed audiences.  
- **Ordering:** When generating content, create **beats → page plan → panels → dialogue** in that order.  
- **Budgets:** Enforce panel/balloon/word caps. If over, propose a split or a cut.  
- **Reproducibility:** Use seeds as `{issue_id/page/panel}`; log changes like code.  
- **References:** 2–3 tone refs; use *deltas* (“like Ref A’s pacing, but grounded setting like Ref B”).  
- **QA:** Thumbnail read, eyeline/180° check, page‑turn placement, lettering margins.

---
## Versioning & Files (🛠 PE)
- Folders: `/series_bible/`, `/issues/01/`, `/art_direction/`, `/refs/`.  
- Files: `Issue_01_BeatSheet_v1.md`, `Issue_01_Pages_v1.md`, `Style_Card_v1.md`, `Cast_{name}.md`.  
- Naming seeds: `issue01_p12_panel03`. Keep a short changelog per issue.

