#let problem_counter = counter("problem")

#let template(doc) = [
  #set page(
    paper: "a4",
    margin: (
      top: 1cm, 
      left: 1cm,
      right: 1cm,
      bottom: 1.75cm),
  )
  #set text(
    font: "New Computer Modern",
  )
  #doc
]

#let footer_header(title, author, course, due_time, group, body) = {
  set page(
    footer: locate(
      loc => if (counter(page).at(loc).first()==1){
        none
      } else {
        let page_number = counter(page).at(loc).first()
        let total_pages = counter(page).final(loc).last()
        line(length: 100%)
        [Стр. #page_number из #total_pages]
        [#h(1fr)#author | #course: #title]
      }
    ),
  )
  body
}

#let title_page(title, author, course, due_time, group, body) = {
  block(
    height:20%,
    fill:none
  )
  align(center, text(20pt)[*#course*])
  align(center, text(17pt)[*#title*])
  align(center, [Дедлайн: #due_time])
  block(
    height: 30%, 
    fill: none
  )
  align(center, text(16pt)[*#author*])
  align(center, text(11pt)[*#group*])
  pagebreak(weak: false)
  body
}

#let problem(name: none, body) = {
  if name != none {
    name = " (" + name + ")"
  }
  [= Задание #problem_counter.step() #problem_counter.display()#name.]
  block(
    fill:rgb(240, 240, 255),
    width: 100%,
    inset:8pt,
    radius: 4pt,
    stroke:rgb(31, 31, 199),
    body
  )
}

#let solution(no_header: false, body) = {
  if not no_header {
    [== Решение:]
  } else {
    none
  }
  block(
    fill: rgb(240, 255, 240),
    width: 100%,
    inset: 8pt,
    radius: 4pt,
    stroke: rgb(31, 199, 31),
    body
  )
}

#let answer(type: "answer", body) = {
  let title = none;
  if type == "result" {
    title = [*Итого:*]
  } else if type == "answer" {
    title = [*Ответ:*]
  }
  block(
    fill: rgb(240, 240, 255),
    width: 100%,
    inset: 8pt,
    radius: 4pt,
    stroke: rgb(31, 31, 199),
    [
      #grid(
        columns: (auto, 1fr),
        gutter: 3pt,
        [#title],
        [#body],
      )
    ] 
  )
}