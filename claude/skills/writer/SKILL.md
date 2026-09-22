---
name: writer
description: Use when drafting, rewriting, or editing text that other people will read, such as technical documentation, READMEs, emails, chat messages, code and review comments, and PR descriptions. Produces text that is easy to read without being simplified.
---

# Writer

Write for a smart reader who doesn't share your context. They can follow complex ideas, so don't simplify the ideas. They weren't in your head or your conversation, so supply the context they lack and make every connection explicit. Spend their attention on the content, not on decoding the text.

Concision means removing effort for the reader, not just words. A dense paragraph can be short and still hard to read.

## Before writing

- Identify the reader, what they already know, and what they should understand or do afterward. Infer this from the request and surrounding material, and follow the user's stated preferences. If it's unclear and would change the text substantially, ask. Otherwise, proceed and state your assumption briefly.
- Match tone to the relationship and setting. A message to a teammate isn't a memo to a steering group.
- Write in the language the reader expects, usually the language of the request or the surrounding material.
- Decide the main point. If you can't state it in one or two sentences, work that out first.

## Choose what to include

- Include what helps the reader understand, decide, or act. Leave out the rest, however interesting.
- Give more depth to points with more complexity or consequences. Not every section deserves equal detail.
- Describe the subject as it stands. Include earlier discussion, rejected alternatives, or history only when the reader needs them or they are the topic.
- Keep meaning, conditions, and uncertainty. Never invent facts, and never drop a qualification just to save words.

## Structure

- Lead with the point, ask, or answer. Then give the reasoning and detail the reader needs to trust it or act on it.
- Give context before detail: what something is and why it matters, then how it works.
- Start each paragraph with its point, so the first sentences alone carry the argument.
- Make headings and subject lines state the content, not the category: "Rollback plan for release 3.2," not "Plan."
- Match structure to length. Messages are a few short paragraphs; headings and bullets are for documents people scan or return to. Use bullets for parallel items, not for reasoning. Reasoning needs connecting words: because, so, but, unless.
- Put each point in one place. Don't close by restating the opening.

## Sentences and words

- One main idea per sentence. Split a sentence when the reader must hold one clause in mind to understand the rest.
- Name who acts: "The job retries three times," not "Retries are performed."
- Prefer verbs to abstract nouns: "decide," not "make a decision."
- Prefer positive phrasing: "Only admins can delete projects," not "Non-admins cannot delete projects."
- Use the reader's vocabulary, including technical terms they know. Define terms they may not know once, where first used. Replace internal labels and shorthand with what they refer to.
- Use one term per concept. Switching synonyms makes readers wonder whether you mean different things.
- Be concrete: numbers, names, examples, commands. "Takes about 40 seconds" beats "is slow."
- Make every "this," "it," and "that" point to an obvious noun.
- Qualify only where uncertainty is real, and say what it depends on.

## Calibration example

- Too heavy: "Due to the ingress controller's TLS termination configuration being inconsistent with the mesh's mTLS policy, requests intermittently fail."
- Talking down: "Sometimes requests fail. This is because of a security setting. Two settings don't match. We need to fix them."
- Right: "Some requests fail because the ingress controller and the service mesh disagree on TLS. The ingress terminates TLS, but the mesh policy requires mTLS on the next hop. Aligning the two policies fixes it."

## Avoid

Too heavy:
- Nested clauses, stacked qualifiers, and noun pileups ("cluster ingress policy configuration update")
- Undefined acronyms, jargon from outside the reader's field, references to context the reader never saw
- Walls of text, or fragmented bullets that leave the reader to reconstruct the logic

Talking down:
- Explaining what the reader clearly knows, or restating a point in other words
- Signposting filler: "It's important to note," "Simply," "In other words," "Let's dive in"
- Choppy sentences that strip nuance, or analogies where a direct explanation is clear

Machine-sounding:
- Openers and closers that add nothing: "Great question," "I hope this helps," recap paragraphs
- Bold, emoji, and headings used as decoration
- Reflexive three-item lists, "not X but Y" framing, hedges on every sentence, and em-dashes where a period or comma works

## By type

| Type | Guidance |
|---|---|
| Chat message | Point or ask in the first line. Short paragraphs, no headings. |
| Email | Subject names the topic and any ask. Ask and deadline in the first paragraph. One topic per email. |
| Technical docs | Organize around what the reader is trying to do. Include prerequisites, working examples, and expected results. Describe what is true now; history belongs in changelogs. |
| Code comments | Explain why, constraints, and non-obvious behavior; the code shows what. |
| Review and issue comments | State the concern, why it matters, and what you suggest. Say whether it blocks. |

For commit messages and PR descriptions, follow the `commit` and `create-pr` skills for format and this skill for prose.

## When editing existing text

- Keep the author's voice and intent. Change what hurts clarity, not what you would merely phrase differently.
- When asked to shorten, cut low-value points first. Compressing every sentence makes text denser, not easier.
- Never add facts. Never drop conditions, caveats, or uncertainty to save words.
- Briefly list substantive changes, such as removed sections or reworded claims, so the author can check them.

## Final check

Reread as the reader, cold:
- Read only the first sentence of each paragraph. Do they tell the whole story in order?
- Where would the reader stop, reread, or ask what something means? Fix it.
- What could they skip without losing anything? Cut it.
- What would they need to ask before acting? Add it.
- Does it make sense without the conversation that produced it?
