#import "@preview/cetz:0.3.4"
#import "@preview/modern-cv:0.9.0": *
#import "@preview/fontawesome:0.6.0": *
#import "@preview/linguify:0.4.2": *

// Extended resume template with configurable profile picture
// profile-picture accepts either:
//   - image: applies default styling (clipped, with configurable radius)
//   - block/content: uses as-is for full customization
#let resume(
  author: (:),
  profile-picture: none,
  date: datetime.today().display("[month repr:long] [day], [year]"),
  accent-color: default-accent-color,
  colored-headers: true,
  show-footer: true,
  language: "en",
  font: ("Source Sans Pro", "Source Sans 3"),
  header-font: "Roboto",
  paper-size: "a4",
  use-smallcaps: true,
  show-address-icon: false,
  description: none,
  keywords: (),
  body,
) = {
  if type(accent-color) == str {
    accent-color = rgb(accent-color)
  }

  let desc = if description == none {
    "Resume " + author.firstname + " " + author.lastname
  } else {
    description
  }

  show: body => context {
    set document(
      author: author.firstname + " " + author.lastname,
      title: "Resume",
      description: desc,
      keywords: keywords,
    )
    body
  }

  set text(
    font: font,
    lang: language,
    size: 11pt,
    fill: color-darkgray,
    fallback: true,
  )

  set page(
    paper: paper-size,
    margin: (left: 15mm, right: 15mm, top: 10mm, bottom: 10mm),
    footer-descent: 0pt,
  )

  set par(spacing: 0.75em, justify: true)
  set heading(numbering: none, outlined: false)

  show heading.where(level: 1): it => block(
    above: 1em,
    below: 0.75em,
  )[
    #set text(size: 16pt, weight: "regular")
    #set align(left)
    #let color = if colored-headers { accent-color } else { color-darkgray }
    #text[#strong[#text(color)[#it.body]]]
    #box(width: 1fr, line(length: 100%))
  ]

  show heading.where(level: 2): it => {
    set text(color-darkgray, size: 12pt, style: "normal", weight: "bold")
    it.body
  }

  show heading.where(level: 3): it => {
    set text(size: 10pt, weight: "regular")
    if use-smallcaps { smallcaps(it.body) } else { it.body }
  }

  let name = {
    align(center)[
      #pad(bottom: 5pt)[
        #block[
          #set text(
            size: 32pt,
            style: "normal",
            weight: "light",
            font: header-font,
          )
          // #text(accent-color)[#author.firstname]
          #text[#author.firstname]
          #text[#author.lastname]
        ]
      ]
    ]
  }

  let positions = {
    set text(accent-color, size: 9pt, weight: "regular")
    align(center)[
      #if use-smallcaps [
        #smallcaps(author.positions.join(text[#"  "#sym.dot.c#"  "]))
      ] else [
        #author.positions.join(text[#"  "#sym.dot.c#"  "])
      ]
    ]
  }

  let address = {
    set text(size: 9pt, weight: "regular")
    align(center)[
      #if ("address" in author) [
        #if show-address-icon [
          #box(fa-icon("location-crosshairs", fill: color-darknight))
          #box[#text(author.address)]
        ] else [
          #text(author.address)
        ]
      ]
    ]
  }

  let contacts = {
    set box(height: 9pt)
    let separator = box(width: 5pt)

    align(center)[
      #set text(size: 9pt, weight: "regular", style: "normal")
      #block[
        #align(horizon)[
          #if ("birth" in author) [
            #box(fa-icon("cake", fill: color-darknight))
            #box[#text(author.birth)]
            #separator
          ]
          #if ("phone" in author) [
            #box(fa-icon("square-phone", fill: color-darknight))
            #box[#link("tel:" + author.phone)[#author.phone]]
            #separator
          ]
          #if ("email" in author) [
            #box(fa-icon("envelope", fill: color-darknight))
            #box[#link("mailto:" + author.email)[#author.email]]
          ]
          #if ("homepage" in author) [
            #separator
            #box(fa-icon("home", fill: color-darknight))
            #box[#link(author.homepage)[#author.homepage]]
          ]
          #if ("github" in author) [
            #separator
            #box(fa-icon("github", fill: color-darknight))
            #box[#link("https://github.com/" + author.github)[#author.github]]
          ]
          #if ("gitlab" in author) [
            #separator
            #box(fa-icon("gitlab", fill: color-darknight))
            #box[#link("https://gitlab.com/" + author.gitlab)[#author.gitlab]]
          ]
          #if ("linkedin" in author) [
            #separator
            #box(fa-icon("linkedin", fill: color-darknight))
            #box[#link(
              "https://www.linkedin.com/in/" + author.linkedin,
            )[#author.firstname #author.lastname]]
          ]
          #if ("twitter" in author) [
            #separator
            #box(fa-icon("twitter", fill: color-darknight))
            #box[#link(
              "https://twitter.com/" + author.twitter,
            )[\@#author.twitter]]
          ]
          #if ("scholar" in author) [
            #let fullname = str(author.firstname + " " + author.lastname)
            #separator
            #box(fa-icon("google-scholar", fill: color-darknight))
            #box[#link(
              "https://scholar.google.com/citations?user=" + author.scholar,
            )[#fullname]]
          ]
          #if ("orcid" in author) [
            #separator
            #box(fa-icon("orcid", fill: color-darknight))
            #box[#link("https://orcid.org/" + author.orcid)[#author.orcid]]
          ]
          #if ("website" in author) [
            #separator
            #box(fa-icon("globe", fill: color-darknight))
            #box[#link(author.website)[#author.website]]
          ]
          #if ("telegram" in author) [
            #separator
            #box(fa-icon("telegram", fill: color-darknight))
            #box[#link("https://t.me/" + author.telegram)[#author.telegram]]
          ]
        ]
      ]
    ]
  }

  // Prepare profile picture content
  let profile-picture-content = if profile-picture != none {
    if type(profile-picture) == content and profile-picture.func() == image {
      // It's an image, apply default styling
      block(
        clip: true,
        stroke: 0pt,
        radius: 2cm,
        width: 4cm,
        height: 4cm,
        profile-picture,
      )
    } else {
      // It's already a block/content, use as-is
      profile-picture
    }
  } else {
    none
  }

  if profile-picture-content != none {
    grid(
      columns: (100% - 4cm, 4cm),
      rows: 100pt,
      gutter: 10pt,
      [
        #name
        #positions
        #address
        #contacts
      ],
      align(left + horizon)[
        #profile-picture-content
      ],
    )
  } else {
    name
    positions
    address
    contacts
  }

  body
}

#show link: underline

#let accent-purple-tint = rgb("#7b477e")
#let light-purple-tint = rgb("#f3eaf4")
#let profile-picture-size = 3.625cm

#show: resume.with(
  author: (
    firstname: "Fedor",
    lastname: "Ivanov",
    email: "ivnfedor@gmail.com",
    phone: "+7 (996) 336-35-01",
    github: "fedor-ivn",
    linkedin: "fedorivn",
    telegram: "fedor_ivn",
    positions: (
      "Software Engineer & Tech Lead",
    ),
  ),
  profile-picture: block(
    clip: true,
    stroke: 0pt,
    radius: 0pt,
    width: profile-picture-size,
    height: profile-picture-size,
    image("assets/profile.jpeg"),
  ),
  date: datetime.today().display(),
  language: "en",
  colored-headers: true,
  show-footer: false,
  accent-color: accent-purple-tint,
)

// === Skill tag styling (easy to customize) ===
#let skill-tag-fill = light-purple-tint  // Light purple tint
#let skill-tag-stroke = accent-purple-tint  // Accent purple border
#let skill-tag-radius = 3pt
#let skill-tag-size = 8pt

#let skill-tag(content) = box(
  fill: skill-tag-fill,
  stroke: 0.5pt + skill-tag-stroke,
  radius: skill-tag-radius,
  inset: (x: 6pt, y: 3pt),
  text(size: skill-tag-size, content),
)

#let skill-tags(..skills) = {
  skills.pos().map(s => skill-tag(s)).join(h(4pt))
}

#let resume-entry-with-logo(
  title: none,
  location: "",
  date: "",
  description: "",
  title-link: none,
  logo: none,
  accent-color: default-accent-color,
  location-color: default-location-color,
) = {
  block(above: 1em, below: 0.75em)[
    #grid(
      column-gutter: 8pt,
      align: horizon,
      columns: (auto, auto),
      rows: (20pt, auto),
      grid.cell(
        colspan: 1,
        box(width: 25pt, height: 25pt, align(center, logo)),
      ),
      grid.cell[
        #pad[
          #justified-header(title, location)
          #if description != "" or date != "" [
            #secondary-justified-header(description, date)
          ]
        ]
      ],
    )
  ]
}

#let resume-entry-content(
  content,
  summary: none,
  skills: none,
) = {
  block(above: 1em, below: 0.75em)[
    #if summary != none [
      #summary
      #v(0.25em)
    ]
    
    #resume-item[#content]

    #if skills != none [
      #skill-tags(..skills)
    ]
  ]
}

#let certificate-entry(title, issuer, year) = {
  block(above: 0.5em, below: 0.5em)[
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      strong[#title], [#issuer (#year)],
    )
  ]
}

#let section-note(content) = {
  block(above: 0.75em, below: 0em)[#content]
}

= Experience

#resume-entry-with-logo(
  title: "Blockchain Engineer & Tech Lead",
  location: "Remote",
  date: "Feb 2024 – Present",
  description: link("https://blockscout.com")[Blockscout],
  logo: image("assets/logos/blockscout.png"),
)
#resume-entry-content(
  [
    - Architected an #link("https://github.com/blockscout/blockscout-rs/tree/main/interchain-indexer")[open-source Rust indexer] for cross-chain bridge messages, delivering Avalanche ICM/ICTT coverage across 400+ L1s (#sym.approx\160K bridging routes) --- Blockscout's self-hostable alternative to Routescan --- actively extending to LayerZero (159M+ messages, 168 chains).
    - Led end-to-end delivery for Celo (Blockscout's busiest instance: 25K DAU, #sym.approx\1.84M txs/day), Filecoin FVM, and Zilliqa by executing core backend development and leading cross-functional team --- generating #sym.approx\$420K in development revenue and converting all 3 chains to \$300K+/year in hosting contracts; earned commendations from Celo.
    - Reclaimed #sym.approx\340 TiB (#sym.approx\61%) across 48 Blockscout instances through research schema normalizations --- address interning, log-topic deduplication, on-demand bytecode fetching --- plus designed a citus-columnar archival tier for internal transactions (benchmarked #sym.approx\10x compression).
  ],
  skills: ("Rust", "Elixir", "Web3", "Indexing", "PostgreSQL"),
)

#resume-entry-with-logo(
  title: "Site Reliability Engineer (DWH)",
  location: "Innopolis, Russia",
  date: "Apr 2023 – Nov 2023",
  description: link("https://tinkoff.ru")[Tinkoff],
  logo: image("assets/logos/tbank.jpg"),
)
#resume-entry-content(
  summary: [
    Managed high-load analytic databases and storage systems (GreenPlum, Hadoop, LizardFS, and ClickHouse) in a data warehouse with over 13PB of data and more than 10K DAU.
  ],
  [
    - Automated LizardFS installation using Ansible roles; enhanced observability with custom probers, alerts, runbooks, and Grafana dashboards.
    - Developed a comprehensive library of Docker images for GreenPlum and LizardFS to support automated testing of ETL pipelines.
    - Initiated alert retrospectives that reduced false positives and non-critical alerts by 30%.
  ],
  skills: ("Ansible", "Docker", "GreenPlum", "ClickHouse", "Grafana"),
)

#resume-entry-with-logo(
  title: "Blockchain Track Lead",
  location: "Innopolis, Russia",
  date: "Sep 2021 – Apr 2022",
  description: link("https://innopolis.university")[Innopolis University],
  logo: image("assets/logos/iu.png"),
)
#resume-entry-content(
  summary: [
    Led the development of the Blockchain Track for the All-Russian National Technology Olympiad (3 stages, Innopolis University).
  ],
  [
    - Designed a comprehensive final task for a Web 3.0 application to assess participants' blockchain, backend, and frontend skills.
    - Streamlined grading through automated checks and LMS integration, significantly reducing workload and minimizing human error.
    - Managed a team of 5: set goals, deadlines, and handled unforeseen challenges throughout a season with over 1000 participants.
    - Earned commendations from both participants and management for successful execution.
  ],
  skills: ("Solidity", "Web3", "Python", "Testing", "Frontend"),
)

#resume-entry-with-logo(
  title: "Backend Engineer",
  location: "Remote",
  date: "May 2020 – Sep 2021",
  description: "Promo Interactive",
  logo: image("assets/logos/promo.png"),
)
#resume-entry-content(
  [
    - Reduced query latency from 30s to 0.5s for Danone's lab software serving ~800 technicians.
    - Built a logistics automation product licensed at \$1,500/month.
  ],
)

= Projects

#resume-entry(
  title: "Course on Linux Command Line",
  location: "",
  date: "",
  description: "Stepik",
)
#resume-entry-content(
  [
    - Generated \$32,800 in revenue from >1,000 enrolled students by launching a Linux course on #link("https://stepik.org/course/171984/promo")[Stepik] with auto-grading and a self-hosted Cloud IDE.
    - Cut ongoing maintenance to #sym.approx\6h/month by shipping a Scala/ZIO microservice for Stepik LMS integration and a Python-based task evaluator.
  ],
  skills: ("Linux", "Ansible", "Docker", "Terraform", "Python", "Scala"),
)

// #resume-entry(
//   title: "Other Projects",
//   location: "",
//   date: "",
//   description: "",
// )
// #block(above: 1em)[
//   - #link("https://gitlab.com/SnejUgal/bot-api-mock")[Bot API Mock]: Haskell library simulating a Bot API server for testing a Telegram bot.
//   - #link("https://github.com/fedor-ivn/project-f/")[Project F]: A toy functional Lisp-like language in C++, built for a Compilers course.
//   - #link("https://github.com/InnoSWP/b21-02-anonymous-feedback")[Anonymous Feedback]: Real-time feedback collection tool for classroom sessions.
//   - #link("https://gitlab.informatics.ru/2019-2020/online/s101/group-04/dmess")[Dmess]: A messenger built with Django and Vue.js.
// ]

// = Skills

// #resume-skill-item(
//   "Languages",
//   (strong("C++"), strong("Python"), "Java", "C#", "JavaScript", "TypeScript"),
// )
// #resume-skill-item("Spoken Languages", (strong("English"), "Spanish"))
// #resume-skill-item(
//   "Programs",
//   (strong("Excel"), "Word", "PowerPoint", "Visual Studio"),
// )

= Education
// How we can say in just 2-3 words that my thesis was presented in international workshops/conferences?

// https://popl25.sigplan.org/details/wits-2025-papers/3/Towards-Generic-Higher-Order-Unification-Implementations-in-Haskell

// https://hal.science/hal-05148806/document

// https://cs.newpaltz.edu/unif2025/program.html (look for Generic Second-Order Matching, Higher-Order Preunification and Pattern Unification Implementations in Haskell)
#resume-entry-with-logo(
  title: "Bachelor in Computer Science, Software Development Track",
  location: "Innopolis, Russia",
  date: "2021 – 2025",
  description: link("https://innopolis.university")[Innopolis University],
  logo: image("assets/logos/iu.png"),
)
#resume-entry-content[
  GPA *5.0* #sym.dot.c Graduated with Honors. Thesis on higher-order unification in Haskell accepted at #link("https://popl25.sigplan.org/details/wits-2025-papers/3/Towards-Generic-Higher-Order-Unification-Implementations-in-Haskell")[WITS 2025]#footnote[Co-located with #link("https://popl25.sigplan.org/")[POPL 2025].] and #link("https://cs.newpaltz.edu/unif2025/program.html")[UNIF 2025].
]

#resume-entry-with-logo(
  title: "Programming Curriculum",
  location: "Online",
  date: "2017 – 2020",
  description: [Moscow School of Programmers at Yandex],
  logo: image("assets/logos/mshp.png"),
)
#resume-entry-content[
  GPA *5.0* #sym.dot.c Graduated with Honors. Led a team for a final project recognized as the best in the stream.
]

// = Certificates

// #certificate-entry(
//   "Diploma for excellent academic achievements",
//   "Innopolis University",
//   "2023",
// )
// #certificate-entry(
//   "Commendation for development of an Olympiad",
//   "NTO Committee",
//   "2022",
// )
// #certificate-entry("The winning team (Blockchain track)", "NTO", "2021")
// #certificate-entry(
//   "Summer School in Blockchain",
//   "Innopolis University",
//   "2020",
// )

// #let certificates_url = "https://drive.google.com/file/d/1AT5iVNn6YGGP-TxuuYN-IaSRFS514hLn/view?usp=sharing"

// #section-note[The certificates are available in #link(certificates_url)[Google Drive].]

// = Research

// #resume-entry(
//   title: "Research Publications",
//   location: "",
//   date: "",
//   description: "",
// )
// #block(above: 1em)[
//   See the full list in the publications file: #link("../src/publications.yml")[Publications List].
// ]
