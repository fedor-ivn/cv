#import "../brilliant-CV/template.typ": *

#cvSection("Employment History")

#cvEntry(
    title: [Site Reliability Engineer (DWH)],
    society: [Tinkoff],
    logo: "../src/logos/tinkoff.png",
    date: [2023 - Present],
    location: [Innopolis, Russia],
    description: [
      My role was to maintain high-load analytic databases and storages
      including GreenPlum, Hadoop, LizardFS, and ClickHouse in DWH with
      more than 13PB of data and 10k DAU.
      
      *Key achievements*:

      - Backed the LizardFS product — automized installation with multiple
        Ansible roles, enchanced observability with custom probers, alerts,
        runbooks, and Grafana dashboards.

      - Made a substantial contribution to the ETL teams by developing a
        comprehensive library of Docker images for GreenPlum and LizardFS,
        designed to streamline automated testing within pipelines.

      - Proposed alert retrospectives within the team, reducing false positives
        and non-critical alerts, which led to a nearly 30% reduction in total
        alerts, enhancing focus on significant system events.
    ],
    // tags: ("Tags Example here", "Dataiku", "Snowflake", "SparkSQL")
)

#cvEntry(
    title: [Blockchain Track Lead, National Technology Olympiad],
    society: [Innopolis University],
    logo: "../src/logos/iu.png",
    date: [September 2021 - April 2022],
    location: [Innopolis, Russia],
    description: [
      My role was to lead the development of the Blockchain Track for the
      All-Russian National Technology Olympiad held in 3 stages by Innopolis
      University.

      *Key achievements:*

      - Crafted a comprehensive final task aimed to develop a Web 3.0
        application, designed to assess participants' blockchain, backend, and
        frontend competencies

      - Streamlined the grading process through automated checks and 
        integration with LMS, significantly reducing workload and minimizing
        human error

      - Gathered and managed a team of five, establishing clear goals and
        deadlines, adeptly handling unforeseen situations
        
      - Successfully oversaw a season with over 1000 participants, earning
        commendations from both participants and management
    ]
)

#cvEntry(
    title: [Python Backend],
    society: [Promo Interactive],
    logo: "../src/logos/promo.png",
    date: [Summer 2021],
    location: [Remote],
    description: [
      Maintained Danone's internal tool for testing dairy products, a
      substantial legacy codebase inherited from a third-party company.
    ]
)

#cvEntry(
    title: [Python Backend],
    society: ["STIL" LTD],
    // logo: "../src/logos/pqr_corp.png",
    date: [Summer 2020],
    location: [Kazan, Russia],
    description: [
      Developed an automation system to streamline business processes within a
      logistics company and integrated it with many external services including
      1C, Wialon, and GdePosylka.
    ]
)
