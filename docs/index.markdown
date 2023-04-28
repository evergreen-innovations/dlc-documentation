---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

title: "DLC Generator"
layout: splash
permalink: /index.html
date: 2023-04-24
header:
  overlay_color: "#000"
  overlay_filter: "0.6"
  overlay_image: assets/images/wave.jpeg 
#   overlay_filter: rgba(18, 126, 128, 0.5)
excerpt: "Documentation lives here"
intro:
  - excerpt: "Do we have a good description to put here?"
feature_row:
  - image_path: assets/images/maths.jpeg
    alt: "placeholder image 1"
    title: "Theory"
    excerpt: "The math behind the scenes."
    url: "/theory/"
    btn_label: "Read More"
    btn_class: "btn--inverse"
  - image_path: assets/images/docs.jpeg 
    alt: ""
    title: "Documentation"
    excerpt: "Docs on using the web tool."
    url: "/documentation/"
    btn_label: "Read More"
    btn_class: "btn--inverse"
---
{% include feature_row id="intro" type="center" %}

{% include feature_row %}
