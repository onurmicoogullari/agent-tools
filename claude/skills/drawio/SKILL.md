---
name: drawio
description: Use when creating diagrams, flowcharts, architecture diagrams, ER diagrams, sequence diagrams, class diagrams, network diagrams, mockups, wireframes, .drawio files, or draw.io exports.
---

# Draw.io Diagram

Generate native `.drawio` files. If the user requests PNG, SVG, or PDF, export with embedded XML when the draw.io CLI is available.

## Workflow

1. Generate draw.io XML in `mxGraphModel` format.
2. Write a descriptive lowercase hyphenated `.drawio` file in the current project/worktree.
3. If `npx @drawio/postprocess` is already available, run it to improve edge routing. Do not install it.
4. If the user requested `png`, `svg`, or `pdf`, locate the draw.io CLI and export with embedded XML.
5. If export succeeds, keep the exported file. The `.drawio` source may be deleted only when the export embeds the XML.
6. Open the result if appropriate; otherwise print the file path.

## Output Format

- No format mentioned: `name.drawio`
- PNG: `name.drawio.png`
- SVG: `name.drawio.svg`
- PDF: `name.drawio.pdf`

PNG, SVG, and PDF exports should include the diagram XML so the file remains editable in draw.io.

## CLI Locations

- macOS: `/Applications/draw.io.app/Contents/MacOS/draw.io`
- Linux: `drawio` on `PATH`
- WSL2: `/mnt/c/Program Files/draw.io/draw.io.exe`
- Windows: `C:\Program Files\draw.io\draw.io.exe`

Export command:

```bash
drawio -x -f <format> -e -b 10 -o <output> <input.drawio>
```

Useful flags:

- `-x`: export mode
- `-f`: output format
- `-e`: embed diagram XML
- `-o`: output path
- `-b`: border width
- `-t`: transparent background for PNG

## XML Requirements

Every file must include the root cells:

```xml
<mxGraphModel adaptiveColors="auto">
  <root>
    <mxCell id="0"/>
    <mxCell id="1" parent="0"/>
  </root>
</mxGraphModel>
```

Rules:

- Never include XML comments.
- Escape XML attribute values: `&amp;`, `&lt;`, `&gt;`, `&quot;`.
- Use unique `id` values.
- Every edge needs a child `<mxGeometry relative="1" as="geometry"/>`.
- Use native draw.io XML, not Mermaid, when the requested output is `.drawio`.

For complex style or XML details, fetch the official draw.io XML reference before generating the file: `https://raw.githubusercontent.com/jgraph/drawio-mcp/main/shared/xml-reference.md`.
