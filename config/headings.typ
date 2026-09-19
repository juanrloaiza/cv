#let headings(body) = {
  show heading.where(level: 1): set text(size: 1.5em)

  show heading.where(level: 2): set block(
    width: 100%,
    stroke: (bottom: 0.5pt),
    inset: (y: 4pt),
    below: 0.85em,
    above: 2em,
  )

  show heading.where(level: 3): set block(above: 1em, below: 1em)

  show heading.where(level: 4): it => {
    set block(above: 1em)
    set text(style: "italic", weight: 400)

    it
  }

  body
}
