#import "@preview/fontawesome:0.6.0": *

#let lang = "es"
#let translations = yaml("data/i18n/translations.yml")
#let t(key) = {
  return translations.at(key).at(lang)
}

#let countries = yaml("data/i18n/countries.yml")
#let translateCountry(country_key) = {
  return countries.at(country_key).at(lang)
}

#set text(lang: lang, font: "Libertinus Serif", size: 10pt)
#set par(justify: true)
#set page(paper: "us-letter", margin: 0.8in, numbering: "1")

#show heading.where(level: 1): set text(size: 1.5em)
#show heading.where(level: 2): set block(below: 1em, above: 2em)
#show heading.where(level: 3): set block(above: 1em)
#show heading.where(level: 4): set text(weight: "semibold")

#let highlightColor = black

#let parseDate(dateString) = {
  let dateArray = dateString.split("-")
  let year = dateArray.at(0)
  let month = dateArray.at(1)
  let day = dateArray.at(2)

  [#day.#month.#year]
}

= Juan Raúl Loaiza Arias

#t("affiliation")

#block(width: 100%)[
  #set align(horizon)

  #fa-icon("envelope") #h(0.25em) #link("mailto:jloaiza@uahurtado.cl")[jloaiza\@uahurtado.cl]
  #h(0.5em) · #h(0.5em)
  #fa-icon("globe") #h(0.25em) #link("www.juanrloaiza.com")
]

#set grid(columns: (10%, auto), gutter: 1em)
#show grid.cell.where(x: 0): set text(size: 0.8em)

== #t("education")

#let education = yaml("data/01 education.yml")
#for el in education.rev() {
  grid(
    [#str(el.start_year) - #str(el.end_year)],
    [
      #text(fill: highlightColor)[*#el.degree.at(lang)*]\
      #el.faculty, #el.institution \
      #t("thesis"): "#el.thesis.title" \
      #t("supervision"): #el.thesis.supervisors.join(", ", last: " & ") \
      #t("qualification"): #el.thesis.qualification
    ],
  )
}

#v(1em)
#columns(2)[
  #let areas = yaml("data/02 areas.yml")
  == #t("specialization")

  #for area in areas.specialization {
    [- #area.at(lang)]
  }

  #colbreak()

  == #t("competence")

  #for area in areas.competence {
    [- #area.at(lang)]
  }

]

== #t("publications")

=== #t("peer-reviewed")

#set cite(form: "full", style: "apa")

#show regex("Loaiza( Arias)?"): set text(weight: "bold", fill: highlightColor)

==== #t("english")

- @Loaiza2025a
- @Loaiza2025b
- @Loaiza2024a
- @Loaiza2022b
- @Loaiza2021
- @Loaiza2017

==== #t("spanish")

// - @BurdmanForthcoming
- @Loaiza2025
- @Loaiza2022
- @CardonaSuarez2016

=== #t("book-chapters-and-books")

- @Loaiza2022a
- @LoaizaArias2016
- @LoaizaArias2016a

=== #t("commentaries-and-others")

- @Loaiza2025d
- @Loaiza2025c
- @Eickers2017
- @LoaizaArias2020

#show bibliography: none
#bibliography(
  "data/03 publications.bib",
  title: none,
  full: true,
)


== #t("employment")

#let employment = yaml("data/04 employment.yml")
#for el in employment {
  grid(
    [#str(el.start_year) -
      #if "end_year" in el.keys() [#str(el.end_year)]
    ],
    [
      *#eval(el.role.at(lang), mode: "markup")*\
      #el.faculty, #el.institution \
      #el.location.at(lang)
    ],
  )
}

== #t("funding")

#let funding = yaml("data/05 funding.yml")
#for f in funding {
  grid(
    [
      #set par(justify: false)
      #f.dates
    ],
    [
      * #eval(f.name, mode: "markup")*\
      #if "project" in f.keys() [
        #t("project"): "#eval(f.project, mode: "markup")" #if f.lang != lang [ (_#eval(f.translation, mode: "markup")_) ] \ ]
      #if "amount" in f.keys() [
        #t("amount"): #f.amount \
      ]
      #f.institution (#if { "city" in f.keys() } [#f.city, ]#translateCountry(f.country))
    ],
  )
}

== #t("awards")

#let awards = yaml("data/06 awards.yml")
#for aw in awards {
  grid(
    [
      #set par(justify: false)
      #aw.dates
    ],
    [
      * #eval(aw.name, mode: "markup")*\
      #aw.institution (#if { "city" in aw.keys() } [#aw.city, ]#translateCountry(aw.country))
    ],
  )
}

== #t("talks")

#let talks = yaml("data/07 talks.yml")
#let isInvited(talk) = { "invited" in talk.keys() and talk.invited == true }
#let isNotInvited(talk) = { not isInvited(talk) }
#let sortTalks(talkA, talkB) = {
  let dateArrayA = talkA.date.split("-")
  let dateArrayB = talkB.date.split("-")

  let yearA = dateArrayA.at(0)
  let yearB = dateArrayB.at(0)

  return yearA > yearB
}

=== #t("talks-refereed")

#for t in talks.filter(isNotInvited).sorted(by: sortTalks).slice(0, 15) {
  grid(
    [
      #set par(justify: false)
      #parseDate(t.date)
    ],
    [
      * #eval(t.title, mode: "markup")*\
      #t.conference.
      #if "institution" in t.keys() [#t.institution]\
      #set text(size: 9pt)
      #if "city" in t.keys() [#t.city, ]#if "country" in t.keys() [#translateCountry(t.country)] else [Online]
    ],
  )
}

=== #t("talks-invited")
#for t in talks.filter(isInvited).slice(0, 10) {
  grid(
    [
      #set par(justify: false)
      #parseDate(t.date)
    ],
    [
      * #eval(t.title, mode: "markup")*\
      #t.conference.
      #if "institution" in t.keys() [#t.institution]\
      #set text(size: 9pt)
      #if "city" in t.keys() [#t.city, ]#if "country" in t.keys() [#translateCountry(t.country)] else [Online]
    ],
  )
}

== #t("academic-service")

#show grid.cell.where(x: 0): set text(size: 10pt)

#grid(
  columns: (1fr, auto),
  gutter: 2em,
  [
    === #t("reviewer")

    #let reviews = yaml("data/10 reviewer.yml")
    #reviews.sorted().join(", ")
  ],

  [
    === #t("membership")

    - Red Latinoamericana de Estudios Afectivos
    - International Society for Research on Emotions (ISRE)
    - Asociación Latinoamericana de Filosofía Analítica (ALFAn)
    - Sociedad Chilena de Filosofía de la Ciencia (SOCHIFIC)
    - Sociedad Colombiana de Filosofía (SCF)

    === #t("languages")

    #for l in yaml("data/09 languages.yml").at(lang) [
      - #l
    ]],
)


