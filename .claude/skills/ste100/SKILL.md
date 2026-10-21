---
name: ste100
description: |
  Apply ASD-STE100 Simplified Technical English. Three modes: REWRITE a
  document or passage into STE, CHECK text and report violations, or SWITCH
  so that every reply follows STE until the user says to stop. Use when the
  user types /ste100, says "STE", "Simplified Technical English",
  "ASD-STE100", "rewrite this in STE", "check this against STE", "switch to
  STE", "strict STE", or "STE mode off".
---

# ASD-STE100 Simplified Technical English

Rules are paraphrased from ASD-STE100 Issue 9. The reference files come from AminBlg/SimpleEnglish (MIT, see `references/LICENSE-SimpleEnglish`). The official dictionary is not included. Full vocabulary compliance needs the official standard (free on request at asd-ste100.org). Say this one time per conversation, in one sentence, when the user asks for compliance.

## Select the mode

| User says | Mode |
|---|---|
| "rewrite", "convert", a file path or pasted text plus "STE" | REWRITE |
| "check", "audit", "is this STE" | CHECK |
| "switch to STE", "use STE", "strict STE", "STE mode on" | SWITCH |
| "STE mode off", "stop STE", "normal style" | Leave SWITCH; return to the CLAUDE.md style guide |

If the request matches no row, ask which mode the user wants.

Each mode has a vocabulary level. **Standard** is the default: the rules below. **Strict** applies when the user says "strict" or "compliance": also read `references/strict-vocabulary.md` and apply its dictionary rulings.

## Core rules (all modes)

0. **Meaning comes first.** Do not change facts, drop qualifiers, or add claims to satisfy a rule. If a rule and the meaning conflict, keep the meaning and flag the sentence.
1. **Classify each passage.** Procedural text: imperative, 20 words per sentence at most, one instruction per sentence. Descriptive text: simple tenses, 25 words per sentence at most, one topic per paragraph, six sentences per paragraph at most.
2. **Do not change** code, identifiers, commands, flags, file paths, quoted text, product names, or numbers.
3. **Condition before command**, with a comma: "If the build fails, read the log."
4. **Verbs:** active voice; simple tenses only; no present perfect; no "-ing" verb forms (technical nouns such as "logging" are permitted); use a verb, not a noun ("compress the file", not "do compression of the file").
5. **Modals:** can, will, must. Replace should, would, may, might, could with the modal ladder in `references/rule-catalog.md`.
6. **Complete grammar:** no contractions; keep articles and "that"; no telegraph style.
7. **Punctuation:** no semicolons, no em-dashes. Write two sentences.
8. **One word, one meaning, one part of speech** for the whole text. Prefer the one-word verb to the phrasal verb ("install", not "set up").
9. **Noun clusters** of three words at most. Break longer chains with a preposition.
10. **Delete words that carry no fact.** Use `references/word-swaps.md`.
11. **Lists and tables** are permitted when they carry structure: colon on the lead-in, uppercase start, one instruction per item, no nesting.
12. **Warnings:** command or condition first, then the risk.

## REWRITE

1. Read the full source.
2. Write the output to a new file next to the source, named `<name>.ste.<ext>`. Overwrite the source only if the user says so. For pasted text, reply with the rewrite.
3. Apply the core rules, then the self-check.
4. Report in two or three sentences: the output path, the vocabulary level, and each sentence flagged under rule 0.

## CHECK

1. Read `references/rule-catalog.md` first. Never cite a rule number from memory.
2. Report each violation as a table row: rule number, the text that violates it, a compliant rewrite.
3. Give a total count of violations by section of the catalog.

## SWITCH

Every reply follows the core rules until the user leaves the mode. The CLAUDE.md style guide still controls content, structure, citations, and length. STE controls the sentences. When the two conflict, STE wins while this mode is on. Two exceptions: keep epistemic hedges that carry real uncertainty (replace "may" with "can" or "it is possible that"), and keep standard technical terms without definitions.

## Self-check before you deliver

1. Count the words in the three longest sentences. Split each one over the limit.
2. Search for `'`, `;`, `—`, `has been`, `have been`, `should`, `would`, `may`, `might`, `could`, `, making`, `in order to`. Fix each hit.
3. Strict level: also do the strict self-check in `references/strict-vocabulary.md`.
