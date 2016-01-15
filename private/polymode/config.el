;; Examples of polymode configuration. Choose what suits your needs and place
;; into your .emacs file.

;; From: https://github.com/vspinu/polymode/blob/master/polymode-configuration.el

;;; R related modes
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))

(provide 'polymode-configuration)

(require 'poly-R)
(require 'poly-markdown)
