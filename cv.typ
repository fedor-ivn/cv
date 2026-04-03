#import "brilliant-CV/template.typ": *
#show: layout

#cvHeader(hasPhoto: true, align: left)
  #autoImport("education")
  #autoImport("professional")
  #autoImport("skills")
  #pagebreak()
  #autoImport("projects")
  #autoImport("publications")
  // todo: надо вообще сертификаты или нет?
  #autoImport("certificates")
#cvFooter()
