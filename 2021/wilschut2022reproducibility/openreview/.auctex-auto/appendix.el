(TeX-add-style-hook
 "appendix"
 (lambda ()
   (LaTeX-add-labels
    "sec:appendix:auc"
    "tab:appendix:auc_rcexplainer"
    "tab:appendix:auc_pgexplainer"
    "appendix:hardware"
    "tab:appendix:hwspec"
    "appendix:GNN_training"
    "fig:MNIST_training_GNN"
    "fig:qual_MNIST"
    "appendix:hyperparameters"))
 :latex)

