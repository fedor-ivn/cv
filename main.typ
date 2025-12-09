#import "@preview/cetz:0.3.4"
#import "@preview/modern-cv:0.9.0": *
#import "@preview/modern-cv:0.9.0" as modern-cv-pkg
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

  show heading.where(level: 1): it => [
    #set text(size: 16pt, weight: "regular")
    #set align(left)
    #set block(above: 1em)
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
          #set text(size: 32pt, style: "normal", weight: "regular", font: header-font)
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
            #box[#link("https://www.linkedin.com/in/" + author.linkedin)[#author.firstname #author.lastname]]
          ]
          #if ("twitter" in author) [
            #separator
            #box(fa-icon("twitter", fill: color-darknight))
            #box[#link("https://twitter.com/" + author.twitter)[\@#author.twitter]]
          ]
          #if ("scholar" in author) [
            #let fullname = str(author.firstname + " " + author.lastname)
            #separator
            #box(fa-icon("google-scholar", fill: color-darknight))
            #box[#link("https://scholar.google.com/citations?user=" + author.scholar)[#fullname]]
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

#show: resume.with(
  author: (
    firstname: "Fedor",
    lastname: "Ivanov",
    email: "ivnfedor@gmail.com",
    phone: "+7 (996) 336-35-01",
    github: "fedor-ivn",
    // twitter: "fedorivn1",
    linkedin: "fedorivn",
    telegram: "fedor_ivn",
    positions: (
      "Blockchain Engineer",
    ),
  ),
  profile-picture: block(
    clip: true,
    stroke: 0pt,
    radius: 0pt,
    width: 3.625cm,
    height: 3.625cm,
    image("./profile.jpeg"),
  ),
  date: datetime.today().display(),
  language: "en",
  colored-headers: true,
  show-footer: false,
  accent-color: rgb("#7b477e"),
)

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
  block(above: 1em, below: 0.65em)[
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

= Experience

#resume-entry-with-logo(
  title: "Blockchain Engineer & Project Owner",
  location: "Remote",
  date: "Feb 2024 – Present",
  description: "Blockscout",
  logo: image("logos/blockscout.png"),
)
#block(above: 1em)[
  Spearheaded end-to-end custom feature development and drove core platform enhancements at Blockscout, a leading Ethereum block explorer.

  #v(0.25em)

  #resume-item[
    - Owned custom projects for Celo, Zilliqa, and Filecoin, coordinating Design, Frontend, Microservices, and DevOps teams to deliver features from proposal to production.
    - Led Celo’s Stage 2 migration to OP-stack, streamlining cross-functional workflows and ensuring technical oversight.
    - Enhanced platform performance by improving GraphQL security, implementing a PostgreSQL prepared-statement optimization (~50% faster), and refactoring Docker workflows to reduce published images by 50%.
    - Researched indexing technologies (The Graph, Subsquid, Substreams) and integrated insights into client customizations to advance Blockscout’s capabilities.
    - Actively engage in tech calls, proposing solutions that align development efforts with long-term business goals.
  ]
]

#resume-entry-with-logo(
  title: "Site Reliability Engineer (DWH)",
  location: "Innopolis, Russia",
  date: "Apr 2023 – Nov 2023",
  description: "Tinkoff",
  logo: image("logos/tbank.jpg"),
)
#block(above: 1em)[
  Managed high-load analytic databases and storage systems (GreenPlum, Hadoop, LizardFS, and ClickHouse) in a data warehouse with over 13PB of data and more than 10K daily active users.

  #v(0.25em)

  #resume-item[
    - Automated LizardFS installation using Ansible roles; enhanced observability with custom probers, alerts, runbooks, and Grafana dashboards.
    - Developed a comprehensive library of Docker images for GreenPlum and LizardFS to support automated testing of ETL pipelines.
    - Initiated alert retrospectives that reduced false positives and non-critical alerts by nearly 30%.
  ]
]

#resume-entry-with-logo(
  title: "Blockchain Track Lead",
  location: "Innopolis, Russia",
  date: "Sep 2021 – Apr 2022",
  description: "Innopolis University",
  logo: image("logos/iu.png"),
)
#block(above: 1em)[
  Led the development of the Blockchain Track for the All-Russian National Technology Olympiad (three stages, Innopolis University).

  #v(0.25em)

  #resume-item[
    - Designed a comprehensive final task for a Web 3.0 application to assess participants’ blockchain, backend, and frontend skills.
    - Streamlined grading through automated checks and LMS integration, significantly reducing workload and minimizing human error.
    - Managed a team of five: set goals, deadlines, and handled unforeseen challenges throughout a season with over 1 000 participants.
    - Earned commendations from both participants and management for successful execution.
  ]
]

#resume-entry-with-logo(
  title: "Python Backend",
  location: "Remote",
  date: "May 2021 - Sep 2021s",
  description: "Promo Interactive",
  logo: image("logos/promo.png"),
)
#block(above: 1em)[
  Maintained Danone’s internal tool for testing dairy products—a substantial legacy codebase inherited from a third-party vendor.
]

#resume-entry-with-logo(
  title: "Python Backend",
  location: "Kazan, Russia",
  date: "May 2020 - Sep 2020",
  description: "\"STIL\" LTD",
  logo: box(fa-icon("building", fill: color-darkgray, size: 20pt)),
)
#block(above: 1em)[
  Developed an automation system to streamline business processes within a logistics company; integrated with external services including 1C, Wialon, and GdePosylka.
]

= Projects

#resume-entry(
  title: "Course on Linux Command Line",
  location: "",
  date: "",
  description: "Stepik",
)
#block(above: 1em)[
  Designed and developed a course that simplifies complex Linux concepts and fosters a holistic understanding. The course includes numerous practical tasks with automated checks and leverages a self-hosted Online IDE for a seamless learning experience. It is available on #link("https://stepik.org/course/171984/promo#toc")[Stepik].

  #v(0.25em)

  #resume-item[
    - Garnered positive feedback from the community; nearly 1 000 students enrolled.
    - Adopted a cloud development environment (CDE) using Coder, managed via Ansible, Docker, Terraform, and GitLab CI/CD. The CDE is accessible at #link("https://coder.innomastery.ru")[Coder].
    - Engineered a microservice in Scala with the ZIO framework to integrate the CDE with Stepik LMS.
  ]
]

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

#resume-entry-with-logo(
  title: "Bachelor in Computer Science, Software Development track",
  location: "Innopolis, Russia",
  date: "2021 – Present",
  description: "Innopolis University",
  logo: image("logos/iu.png"),
)
#block(above: 1em)[
  GPA *5.0* #sym.bar Awarded an increased scholarship for excellent academic achievements.
]

#resume-entry-with-logo(
  title: "Programming Curriculum (3 years)",
  location: "Online",
  date: "2017 – 2020",
  description: "Moscow School of Programmers at Yandex",
  logo: image("logos/mshp.png"),
)
#block(above: 1em)[
  GPA *5.0* #sym.bar Led a team for a final project recognized as the best in the stream.
]

= Certificates

#resume-entry(
  title: "Diploma for excellent academic achievements",
  location: "Innopolis University",
  date: "2023",
  description: "",
)

#resume-entry(
  title: "Commendation for development of an Olympiad",
  location: "NTO Committee",
  date: "2022",
  description: "",
)

#resume-entry(
  title: "The winning team (Blockchain track)",
  location: "NTO",
  date: "2021",
  description: "",
)

#resume-entry(
  title: "Summer School in Blockchain",
  location: "Innopolis University",
  date: "2020",
  description: "",
)

#resume-entry(
  title: "Certificate, with honors",
  location: "Moscow Programming School at Yandex",
  date: "2020",
  description: "",
)

#v(5pt)

#let certificates_url = "https://drive.google.com/file/d/1AT5iVNn6YGGP-TxuuYN-IaSRFS514hLn/view?usp=sharing"

#show link: underline
The certificates are available in #link(certificates_url)[Google Drive].

= Research

#resume-entry(
  title: "Research Publications",
  location: "",
  date: "",
  description: "",
)
#block(above: 1em)[
  See the full list in the publications file: #link("../src/publications.yml")[Publications List].
]
