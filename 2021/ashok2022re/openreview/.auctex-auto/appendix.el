(TeX-add-style-hook
 "appendix"
 (lambda ()
   (LaTeX-add-labels
    "table:epoch_time"
    "table:conv_few_shot"
    "table:seed_conv"
    "table:mini_imagenet_both"
    "table:20_ssl"
    "table:20_ssl_others"
    "table:grey_low_res"
    "table:domain"
    "table:cdfsl_conv"
    "table:conv_arch"
    "table:resnet_arch"))
 :latex)

