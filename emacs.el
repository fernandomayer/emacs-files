;;======================================================================
;; emacs customization file
;; author: Fernando Mayer
;;======================================================================

;;======================================================================
;; general or global customizations
;;======================================================================

;; add ~/.emacs.d/ to the load-path
(add-to-list 'load-path "~/.emacs.d/")

;; activate highlighting for the current line
;; a list with possible colors is available with M-x list-colors-display
;; ref: http://emacsblog.org/2007/04/09/highlight-the-current-line
(global-hl-line-mode 1)
;(set-face-background 'hl-line "#111")

;; Show line-number and column-number in the mode line
(line-number-mode 1)
(column-number-mode 1)

;; initiate with 2 vertical buffers
;(split-window-horizontally)

;; break lines at specified column (<= 80, defaults 72)
(setq-default fill-column 72)

;; turns on auto-fill-mode to automatically break lines
(setq-default auto-fill-function 'do-auto-fill)

;; activates highlighting when selecting blocks of text
(setq-default transient-mark-mode t)

;; x-select-enable-clipboard makes copied text available from/for emacs
;; buffers
(setq x-select-enable-clipboard t)

;; disable automatic backup copies (~)
(setq make-backup-files nil)

;; Automatic brackets, etc
;; ref: http://www.emacswiki.org/emacs/ESSAutoParens
;; enable skeleton-pair insert globally
(setq skeleton-pair t)
;;(setq skeleton-pair-on-word t)
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\'") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\`") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "<") 'skeleton-pair-insert-maybe)

;; custom variables
(custom-set-variables
	;; stop cursor blinking
	'(blink-cursor-mode nil)
	;; removes tool bar
	'(tool-bar-mode nil)
	;; mark matching brackets
	'(show-paren-mode t)
	;; removes terminal bell (make it visible only)
	'(visible-bell t))

;; C-TAB move between buffers
(global-set-key [(control tab)] 'other-window)

;; enable iswitchb mode: C-x b now shows a list of buffers
;; ref: http://emacs-fu.blogspot.com.br/2009/02/switching-buffers.html
(iswitchb-mode t)

;;......................................................................
;; DEFUNCT options
;;......................................................................

;; F2 as undo
;(global-set-key [f2] 'undo)

;; F6 kill buffers
;(global-set-key [f6] 'kill-this-buffer)

;; 4 spaces for tabs
;(setq tab-width 4)

;;......................................................................

;;======================================================================
;; colors customizations
;;======================================================================

;; color-theme.el is nedded, see
;; http://www.emacswiki.org/emacs-en/ColorTheme
;; In Debian based systems, install the package emacs-goodies-el
(require 'color-theme)

;; This is the color-theme-tangosoft, which require
;; color-theme-tangosft.el in your ~/.emacs.d/ . See
;; https://github.com/kjhealy/tangosoft-theme
;; (load "~/.emacs.d/color-theme-tangosoft")
;; (color-theme-tangosoft)

;; This is for solarized (http://ethanschoonover.com/solarized)
;; Just clone it into ~/.emacs.d
;; https://github.com/sellout/emacs-color-theme-solarized
(load "~/.emacs.d/emacs-color-theme-solarized/color-theme-solarized")
(require 'color-theme-solarized)
;; always initialize on dark, but you can change here for *-light
(color-theme-solarized-dark)
;; or you can change it live with
;; M-x color-theme-solarized-[light|dark]

;;......................................................................
;; DEFUNCT options
;;......................................................................

;; sets background and foreground colors
;(set-background-color "black")
;(set-foreground-color "white")

;;......................................................................

;;======================================================================
;; markdown mode
;;======================================================================

;; make markdown mode visible. Install from
;; http://jblevins.org/projects/markdown-mode/
;; or emacs-goodies-el in Debian based systems
;; The original way to activate it is
;; (autoload 'markdown-mode "markdown-mode.el"
;;    "Major mode for editing Markdown files" t)
;; (setq auto-mode-alist
;;    (cons '("\\.md" . markdown-mode) auto-mode-alist))
;; NOTE: the .md file extension is not a consensus for markdown, so use
;; here whatever extension you use for it (e.g. .text, .mdwn, ...)
;; However, I wanted gfm-mode (Github Flavored Markdown) to be the
;; default mode for markdown. So I'm using this
(require 'markdown-mode)
(add-hook 'markdown-mode-hook 'turn-off-auto-fill)
(add-to-list 'auto-mode-alist '("\\.md$" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . gfm-mode))
;; from
;; https://github.com/citizen428/emacs.d/blob/master/config/misc-conf.el

;;======================================================================
;; LaTeX (and AUCTeX) customizations
;;======================================================================

;; make pdflatex default (instead of latex)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)

;; run Sweave directly inside a .Rnw file
;; ref: http://kieranhealy.org/esk/starter-kit-stats.html
(add-to-list 'auto-mode-alist '("\\.Rnw\\'" . Rnw-mode))
(add-to-list 'auto-mode-alist '("\\.Snw\\'" . Rnw-mode))
;; Make TeX and RefTex aware of Snw and Rnw files
(setq reftex-file-extensions
      '(("Snw" "Rnw" "nw" "tex" ".tex" ".ltx") ("bib" ".bib")))
(setq TeX-file-extensions
      '("Snw" "Rnw" "nw" "tex" "sty" "cls" "ltx" "texi" "texinfo"))
;; Lets you do 'C-c C-c Sweave' from your Rnw file
(add-hook 'Rnw-mode-hook
          (lambda ()
            (add-to-list 'TeX-command-list
                         '("Sweave" "R CMD Sweave %s"
                           TeX-run-command nil (latex-mode) :help "Run Sweave") t)
            (add-to-list 'TeX-command-list
                         '("LatexSweave" "%l %(mode) %s"
                           TeX-run-TeX nil (latex-mode) :help "Run Latex after Sweave") t)
            (setq TeX-command-default "Sweave")))
;; Make evince default pdf viewer
;; http://lists.gnu.org/archive/html/auctex/2010-11/msg00011.html
(setq TeX-view-program-list '(("Evince" "evince %o")))
(setq TeX-view-program-selection '((output-pdf "Evince")))

;;======================================================================
;; ess and R related customizations
;;======================================================================

;; calls ess. See
;; http://ess.r-project.org/
;(load "~/.emacs.d/ess-12.04-3/lisp/ess-site")
(require 'ess-site)
(setq-default ess-dialect "R")

;; show function arguments in ESS buffers
(require 'ess-eldoc)
; also show in iESS buffers
;(add-hook 'inferior-ess-mode-hook 'ess-use-eldoc)

;; turns on yas/minor-mode in ESS buffers (requires yasnippet installed)
;; see http://capitaomorte.github.com/yasnippet/faq.html
;; if it doesn't work, use
;; M-x yas/minor-mode
;(add-hook 'ess-mode-hook 'yas/minor-mode-on)
;(require 'yasnippet)

;; uses the autocompletion of arguments from r-autoyas. Must have
;; r-autoyas.el in ~/.emacs.d/
;; see https://github.com/mlf176f2/r-autoyas.el
;(load "~/.emacs.d/r-autoyas")
;(require 'r-autoyas)
;(add-hook 'ess-mode-hook 'r-autoyas-ess-activate)

;; Recommended customizatios found in "R Internals" manual
;; http://cran.r-project.org/doc/manuals/R-ints.html#R-coding-standards
;;......................................................................

;; C code
(add-hook 'c-mode-hook
	  (lambda () (c-set-style "bsd")))

;; ESS code
(add-hook 'ess-mode-hook
	  (lambda ()
	    (ess-set-style 'RRR) ; C++ is default. See ess-custom.el
	    ;; Because
	    ;;                                 DEF GNU BSD K&R C++
	    ;; ess-indent-level                  2   2   8   5   4
	    ;; ess-continued-statement-offset    2   2   8   5   4
	    ;; ess-brace-offset                  0   0  -8  -5  -4
	    ;; ess-arg-function-offset           2   4   0   0   0
	    ;; ess-expression-offset             4   2   8   5   4
	    ;; ess-else-offset                   0   0   0   0   0
	    ;; ess-close-brace-offset            0   0   0   0   0
	    (add-hook 'local-write-file-hooks
		      (lambda ()
			(ess-nuke-trailing-whitespace)))))
(setq ess-nuke-trailing-whitespace-p 'ask)
;; or even
;; (setq ess-nuke-trailing-whitespace-p t)

;; Perl code
(add-hook 'perl-mode-hook
	  (lambda () (setq perl-indent-level 4)))
;;......................................................................

;; uses the R parser for code formatting:
;; select region and C-M-\ or M-x indent-region
;; http://www.emacswiki.org/emacs/ESSRParser
(defun ess-indent-region-as-R-function (beg end)
  (let ((string (replace-regexp-in-string
		 "\"" "\\\\\\&"
		 (replace-regexp-in-string
		  "\\\\\"" "\\\\\\&" (buffer-substring-no-properties beg end))))
	(buf (get-buffer-create "*ess-command-output*")))
    (ess-force-buffer-current "Process to load into:")
    (ess-command (format "local({oo<-options(keep.source=FALSE);
cat('\n',paste(deparse(parse(text=\"%s\")[[1L]]),collapse='\n'),'\n',sep='')
options(oo)})\n"  string) buf)
    (with-current-buffer buf
      (goto-char (point-max))
      ;; (skip-chars-backward "\n")
      (let ((end (point)))
	(goto-char (point-min))
	(goto-char (1+ (point-at-eol)))
	(setq string (buffer-substring-no-properties (point) end))
	))
    (delete-region beg end)
    (insert string)
    ))

(add-hook 'ess-mode-hook '(lambda () (set (make-local-variable 'indent-region-function)
					  'ess-indent-region-as-R-function)))

;; enables ESS Outline Mode, see
;; http://www.emacswiki.org/emacs/ESSOutlineMode
(add-hook 'ess-mode-hook
	  '(lambda ()
	     (outline-minor-mode)
	     (setq outline-regexp "\\(^#\\{4,5\\} \\)\\|\\(^[a-zA-Z0-9_\.]+ ?<-
?function(.*{\\)")
	     (defun outline-level ()
	       (cond ((looking-at "^##### ") 1)
		     ((looking-at "^#### ") 2)
		     ((looking-at "^[a-zA-Z0-9_\.]+ ?<- ?function(.*{") 3)
		     (t 1000)))
	     ))
;; Simpler keybindings with the win key: (global for now, FIXME!!)
;; probably some might not work right on actual windows...
(global-set-key (kbd "s-a") 'show-all)

(global-set-key (kbd "s-T") 'hide-body)     ;; Hide all body but not subh.
(global-set-key (kbd "s-t") 'hide-other)    ;; Hide all but current+top

(global-set-key (kbd "s-d") 'hide-subtree)  ;; hide body and subh.
(global-set-key (kbd "s-s") 'show-subtree)  ;; show body and subheadings
(global-set-key (kbd "s-D") 'hide-leaves)   ;; hide body from subheadings
(global-set-key (kbd "s-S") 'show-branches) ;; show subheadings w/o body

(global-set-key (kbd "s-b") 'outline-backward-same-level)
(global-set-key (kbd "s-f") 'outline-forward-same-level)
(global-set-key (kbd "s-B") 'outline-up-heading)

(global-set-key (kbd "s-p") 'outline-previous-visible-heading)
(global-set-key (kbd "s-n") 'outline-next-visible-heading)
(global-set-key (kbd "s-P") 'outline-previous-heading)
(global-set-key (kbd "s-N") 'outline-next-heading) 

;;======================================================================
;; orgmode customizations
;;======================================================================

;; ref: http://orgmode.org/org.html#Introduction
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;; ref: http://orgmode.org/manual/Closing-items.html
;(setq org-log-done 'time) ; only timestamp
(setq org-log-done 'note) ; timestamp with note (optional)

;;======================================================================
;; Maxima mode
;;======================================================================

;; ref: http://emacswiki.org/emacs/MaximaMode
(add-to-list 'load-path "/usr/local/share/maxima/5.18.1/emacs/")
(autoload 'maxima-mode "maxima" "Maxima mode" t)
(autoload 'imaxima "imaxima" "Frontend for maxima with Image support" t)
(autoload 'maxima "maxima" "Maxima interaction" t)
(autoload 'imath-mode "imath" "Imath mode for math formula input" t)
(setq imaxima-use-maxima-mode-flag t)

;;......................................................................
;; DEFUNCT options
;;......................................................................

;; to use the colorout package in emacs
;(require 'ansi-color)
;(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;;......................................................................

;;======================================================================
;; end of .emacs
;;======================================================================
