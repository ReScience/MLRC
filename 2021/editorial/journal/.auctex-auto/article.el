(TeX-add-style-hook
 "article"
 (lambda ()
   (TeX-run-style-hooks
    "latex2e"
    "header"
    "content"
    "rescience"
    "rescience10"
    "subfig"
    "multicol"))
 :latex)

