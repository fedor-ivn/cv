#import "../brilliant-CV/template.typ": *

#show link: underline

#cvSection("Projects")

#let linux_cmd_url = "https://stepik.org/course/171984/promo#toc"
#let grade_proxy_gh = "https://example.com"
#let coder_docs_url = "https://coder.com"
#let coder_url = "https://coder.innomastery.ru"

#cvEntry(
  title: [Course on Linux Command Line],
  society: "Stepik",
  date: "",
  location: "",
  description: [
    Designed and developed course focused on simplifying complex
    concepts and fostering a holistic understanding of Linux. The course
    features numerous practical tasks with automated checks and leverages a
    self-hosted Online IDE for the seamless learning experience. The course is
    paid and is available on #link(linux_cmd_url)[Stepik].

    *Key achievements:*

    - Constantly receive positive feedback from the community, with nearly 1000
      students enrolled in the course.

    - Adopted a cloud development environment (CDE) called
      #link(coder_docs_url)[Coder] for educational use, managing the
      infrastructure with tools like Ansible, Docker, Terraform, and GitLab
      CI/CD. The CDE is available via the #link(coder_url)[link].
    
    - Engineered a microservice using Scala and the ZIO framework to integrate
      the CDE with Stepik LMS.

  ],
  tags: ("Scala", "Docker", "Linux")
)

#let bot_api_mock_gh = "https://gitlab.com/SnejUgal/bot-api-mock"

#cvEntry(
  title: [Bot API Mock],
  society: "Haskell Course",
  date: "",
  location: "",
  // todo: ...
  description: [
    With a team, I developed a library that simulates a Bot API server,
    primarily used for testing a Telegram bot. This was created as the final
    project for the Haskell course at Innopolis University. The source code is
    available on #link(bot_api_mock_gh)[GitLab].

  ],
  tags: ("Haskell", "Stack", "Rust")
)

#let project_f_repo = "https://github.com/fedor-ivn/project-f/"

#let anonymous_feedback_repo = (
  "https://github.com/InnoSWP/b21-02-anonymous-feedback"
)

#let dmess_repo = (
  "https://gitlab.informatics.ru/2019-2020/online/s101/group-04/dmess"
)

#cvEntry(
  title: [Other projects],
  society: "",
  date: "",
  location: "",
  description: [
    - #link(project_f_repo)[Project F]: a toy, functional, LISP-like language
      implemented in C++. Built as a study project for the Compilers Course.

    - #link(anonymous_feedback_repo)[Anonymous Feedback]: helps to collect
      feedback from students during classes in real time.

    - #link(dmess_repo)[Dmess]: a messenger built with Django and Vue.js.
  ]
)
