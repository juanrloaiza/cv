#let general-config(lang: "es", body) = {
  set text(lang: lang, font: "PT Sans", size: 10pt)
  set par(justify: true)
  set page(paper: "us-letter", margin: 0.8in, numbering: "1")

  set grid(columns: (9%, auto), gutter: 1em)
  show grid.cell.where(x: 0): set text(size: 0.8em)

  body
}
