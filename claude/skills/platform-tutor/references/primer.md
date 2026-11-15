# Primers

A primer is a printable PDF of 2 to 4 A4 pages on one topic. The learner
reads it on his own and comes back to it later. It follows the same teaching
rules as an explanation in chat, but because it is meant to be reread, it
gets more care: real diagrams, a glossary and answers at the back.

## Workflow

1. **Agree on the topic and its scope.** "DNS" is one primer. "Networking" is
   too much for one. When the request is broad, suggest how to split it and
   make the first part.
2. **Research.** Check facts against official documentation. When you run in
   the `app-platform` repository, find where the topic appears and read those
   files, so that "In our platform" shows real paths and real behaviour.
3. **Write the HTML.** Copy `assets/primer-template.html` to the output folder
   as `<topic>.html` and fill in the sections. The template's comments
   explain each section.
4. **Build the PDF.** Run `scripts/build-pdf.sh <topic>.html`. It writes
   `<topic>.pdf` next to the HTML file.
5. **Check the PDF.** Read the PDF and look at every page. Look for a diagram
   split across two pages, text running out of a box, empty pages, and
   answers that ended up next to their questions. Fix the HTML and build
   again.
6. **Hand it over.** Give the path to the PDF. Keep the HTML next to it,
   because the HTML is what you edit next time.

Save to the folder the user names. Otherwise use
`~/Documents/platform-primers/<topic>/`. Don't save primers inside the
`app-platform` repository or inside this skill's folder. Skills are shared
and published, so they must never contain internal hostnames, architecture
or other client details.

Primers can include internal hostnames and architecture, so they are internal
material. Say so when you hand one over if it contains internal details.
Never include secrets.

## Sections

The template has these sections in this order. Leave a section out only when
it truly doesn't apply to the topic.

| Section | Contents |
|---|---|
| Title and subtitle | The topic, plus a subtitle that says what the reader will understand afterwards |
| In one sentence | What it is, in one sentence |
| Why it exists | The problem, told as a small story about what goes wrong without it |
| Analogy | One everyday analogy in a box, with a "where it breaks" line |
| How it works | Numbered steps that match the numbers in the main diagram |
| Key terms | A table of 5 to 10 terms with plain definitions |
| Try it yourself | 2 to 4 commands that only read. Show the expected output and say what to notice |
| In our platform | Where the topic shows up on the platform, with real file paths and an optional second diagram |
| When it goes wrong | A table of symptoms, likely causes and what to check first |
| Check yourself | 3 to 5 questions that make the reader apply the idea |
| Next topics | 2 to 4 topics to read next, one line each |
| Answers | On their own page at the end, so they don't give away the questions |

## Diagrams

Diagrams are inline SVG inside the HTML, so they print sharply and need no
other tools. Each primer has one main diagram in "How it works". Add a second
one in "In our platform" when the platform's version differs from the simple
case.

- **Show the mechanism, not decoration.** Every box is something real: a
  computer, a program or a message. Every arrow is something that actually
  moves. When an arrow has no label, ask what it carries.
- **One idea per diagram.** When a diagram needs more than about 7 boxes,
  split it.
- **Number the arrows** and use the same numbers in the text, so the reader
  can follow both together.
- **Print-friendly.** Use grey boxes with one accent colour for the part that
  matters most. Use the template's CSS classes rather than colours of your
  own. Keep text at 13px or larger in a viewBox about 680 wide, so it is
  readable on paper.
- **Label the boxes with nouns and the arrows with verbs or messages.** For
  example, the box is "DNS resolver" and the arrow is "Where is
  app.example.se?".
- Use the `<figure>` with a `<figcaption>` from the template. The caption
  says what to notice, not only what the diagram shows.

The template contains a complete example diagram. Copy its structure.
