;;======================================================================
;; emacs customization file
;; author: Fernando Mayer
;;======================================================================

;;======================================================================
;; general or global customizations
;;======================================================================

;; add ~/.emacs.d/ to the load-path
;(add-to-list 'load-path "~/.emacs.d/")

;; activate highlighting for the current line
;; a list with possible colors is available with M-x list-colors-display
;; ref: http://emacsblog.org/2007/04/09/highlight-the-current-line
(global-hl-line-mode 1)
;(set-face-background 'hl-line "#111")

;; Show line-number and column-number in the mode line
(line-number-mode 1)
(column-number-mode 1)

;; initiate with 2 vertical buffers
(split-window-horizontally)

;; break lines at specified column (<= 80, defaults 72)
(setq-default fill-column 72)

;; turns on auto-fill-mode to automatically break lines
(setq-default auto-fill-function 'do-auto-fill)

;; activates highlighting when selecting blocks of text
(setq-default transient-mark-mode t)

;; x-select-enable-clipboard makes copied text available from/for emacs
;; buffers
(setq x-select-enable-clipboard t)

;; disable auto-save (#*#) and auto-backup (~) files
(setq auto-save-default nil)
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

;; para habilitar os acentos no xubuntu 14.04
(require 'iso-transl)

;; To revert-buffer without confirmation
;; Source: http://www.emacswiki.org/emacs-en/download/misc-cmds.el
(defun revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive)
    (revert-buffer t t))
; AND bind it to F5
(global-set-key [f5] 'revert-buffer-no-confirm)

;; M-= to get division line with 70 =.
(global-set-key [?\M-=] (kbd "## C-u 7 0 ="))

;; M-- to get division line with 70 -.
(global-set-key [?\M--] (kbd "## C-u 7 0 -"))

;; C-- to get division line with 43 -.
(global-set-key [?\C--] (kbd "## C-u 4 3 -"))

;; Add highlighting for certain keywords.
;; http://lists.gnu.org/archive/html/emacs-orgmode/2010-09/txtb5ChQJCDny.txt
;; http://emacs.1067599.n5.nabble.com/Adding-keywords-for-font-lock-experts-td95645.html
(make-face 'special-words) 
(set-face-attribute 'special-words nil :foreground "White" :background "Firebrick") 

(dolist
    (mode '(fundamental-mode
            gnus-article-mode
            org-mode
            shell-mode
            muse-mode
            ess-mode
            polymode-mode
            markdown-mode
            TeX-mode)) 
  (font-lock-add-keywords
   mode 
   '(("\\<\\(COMMENT\\|DONE\\|TODO\\|STOP\\|IMPORTANT\\|NOTE\\|OBS\\|ATTENTION\\|REVIEW\\)" 
      0 'font-lock-warning-face t) 
     ("\\<\\(BUG\\|WARNING\\|DANGER\\|FIXME\\)" 
      0 'special-words t)))
  )

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
;; In Arch based systems, DONT install emacs-goodies-el, just install
;; emacs-color-theme package from the repositories
(require 'color-theme)

;; This is the color-theme-tangosoft, which require
;; color-theme-tangosft.el in your ~/.emacs.d/ . See
;; https://github.com/kjhealy/tangosoft-theme
;; (load "~/.emacs.d/color-theme-tangosoft")
;; (color-theme-tangosoft)

;; This is for solarized (http://ethanschoonover.com/solarized)
;; Just clone it into ~/.emacs.d
;; git clone git@github.com:sellout/emacs-color-theme-solarized.git
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
;; (R) markdown mode
;;======================================================================

;; make markdown mode visible. Install from
;; http://jblevins.org/projects/markdown-mode/
;; or emacs-goodies-el in Debian based systems
;; In Arch based systems DONT install emacs-goodies-el, install the
;; markdown-mode via git

;; markdown-mode
;; git clone git://jblevins.org/git/markdown-mode.git
(setq load-path
      (append '("~/.emacs.d/markdown-mode")
              load-path))

;; polymode
;; git clone https://github.com/vspinu/polymode.git
(setq load-path
      (append '("~/.emacs.d/polymode/"  "~/.emacs.d/polymode/modes")
              load-path))
(require 'poly-R)
(require 'poly-markdown)
(require 'poly-noweb)
;; activation of polymodes
;; https://github.com/vspinu/polymode/blob/master/polymode-configuration.el
;;; MARKDOWN
(add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode))
;;; ORG
(add-to-list 'auto-mode-alist '("\\.org" . poly-org-mode))
;;; R related modes
(add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmarkdown" . poly-markdown+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmk" . poly-markdown+r-mode))
(add-to-list 'auto-mode-alist '("\\.rapport" . poly-rapport-mode))
(add-to-list 'auto-mode-alist '("\\.Rhtml" . poly-html+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rbrew" . poly-brew+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rcpp" . poly-r+c++-mode))
(add-to-list 'auto-mode-alist '("\\.cppR" . poly-c++r-mode))
(provide 'polymode-configuration)

;; Insert a new (empty) chunk to R markdown
(defun insert-chunk ()
  "Insert chunk environment Rmd sessions."
  (interactive)
  (insert "```{r}\n\n```")
  (forward-line -1)
  )
; key binding
(global-set-key (kbd "C-c i") 'insert-chunk)

;; mark a word at a point
;; http://www.emacswiki.org/emacs/ess-edit.el
(defun ess-edit-word-at-point ()
  (save-excursion
    (buffer-substring
     (+ (point) (skip-chars-backward "a-zA-Z0-9._"))
     (+ (point) (skip-chars-forward "a-zA-Z0-9._")))))
;; eval any word where the cursor is (objects, functions, etc)
(defun ess-eval-word ()
  (interactive)
  (let ((x (ess-edit-word-at-point)))
    (ess-eval-linewise (concat x)))
)
; key binding
(global-set-key (kbd "C-c r") 'ess-eval-word)

;; the first tentative
;; (defun ess-eval-word0 ()
;;   (interactive)
;;   (backward-word)
;;   (mark-word)
;;   (ess-eval-region (region-beginning) (region-end) 'nowait)
;; )

;;======================================================================
;; LaTeX (and AUCTeX) customizations
;;======================================================================


;; In Arch Linux, these lines are needed to enable AUCTex
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

;; make pdflatex default (instead of latex)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)

;; This is DEFUNCT since ESS handles all these nowadays
;; run Sweave directly inside a .Rnw file
;; ref: http://kieranhealy.org/esk/starter-kit-stats.html
;; (add-to-list 'auto-mode-alist '("\\.Rnw\\'" . Rnw-mode))
;; (add-to-list 'auto-mode-alist '("\\.Snw\\'" . Rnw-mode))
;; ;; Make TeX and RefTex aware of Snw and Rnw files
;; (setq reftex-file-extensions
;;       '(("Snw" "Rnw" "nw" "tex" ".tex" ".ltx") ("bib" ".bib")))
;; (setq TeX-file-extensions
;;       '("Snw" "Rnw" "nw" "tex" "sty" "cls" "ltx" "texi" "texinfo"))
;; ;; Lets you do 'C-c C-c Sweave' from your Rnw file
;; (add-hook 'Rnw-mode-hook
;;           (lambda ()
;;             (add-to-list 'TeX-command-list
;;                          '("Sweave" "R CMD Sweave %s"
;;                            TeX-run-command nil (latex-mode) :help "Run Sweave") t)
;;             (add-to-list 'TeX-command-list
;;                          '("LatexSweave" "%l %(mode) %s"
;;                            TeX-run-TeX nil (latex-mode) :help "Run Latex after Sweave") t)
;;             (setq TeX-command-default "Sweave")))

;; Make evince default pdf viewer
;; http://lists.gnu.org/archive/html/auctex/2010-11/msg00011.html
(setq TeX-view-program-list '(("Evince" "evince %o")))
(setq TeX-view-program-selection '((output-pdf "Evince")))

;; To prevent "Error occured after last TeX file closed"
;; http://tex.stackexchange.com/questions/124246/uninformative-error-message-when-using-auctex
(setq LaTeX-command-style '(("" "%(PDF)%(latex) -file-line-error %S%(PDFout)")))

;;======================================================================
;; ESS and R related customizations
;;======================================================================

;; calls ess. See
;; http://ess.r-project.org/
;; git clone git@github.com:emacs-ess/ESS.git
(load "~/.emacs.d/ESS/lisp/ess-site")
(require 'ess-site)
(setq-default ess-dialect "R")

;; show function arguments in ESS buffers
(require 'ess-eldoc)
; also show in iESS buffers
;(add-hook 'inferior-ess-mode-hook 'ess-use-eldoc)

;; http://permalink.gmane.org/gmane.emacs.ess.general/8419
;; Script font lock highlight.
(setq ess-R-font-lock-keywords
      '((ess-R-fl-keyword:modifiers . t)
        (ess-R-fl-keyword:fun-defs . t)
        (ess-R-fl-keyword:keywords . t)
        (ess-R-fl-keyword:assign-ops . t)
        (ess-R-fl-keyword:constants . t)
        (ess-fl-keyword:fun-calls . t)
        (ess-fl-keyword:numbers . t)
        (ess-fl-keyword:operators . t)
        (ess-fl-keyword:delimiters . t)
        (ess-fl-keyword:= . t)
        (ess-R-fl-keyword:F&T . t)
        (ess-R-fl-keyword:%op% . t)
        ))

;; Console font lock highlight.
(setq inferior-R-font-lock-keywords
      '((ess-S-fl-keyword:prompt . t)
        (ess-R-fl-keyword:messages . t)
        (ess-R-fl-keyword:modifiers . t)
        (ess-R-fl-keyword:fun-defs . t)
        (ess-R-fl-keyword:keywords . t)
        (ess-R-fl-keyword:assign-ops . t)
        (ess-R-fl-keyword:constants . t)
        (ess-fl-keyword:matrix-labels . t)
        (ess-fl-keyword:fun-calls . t)
        (ess-fl-keyword:numbers . t)
        (ess-fl-keyword:operators . t)
        (ess-fl-keyword:delimiters . t)
        (ess-fl-keyword:= . t)
        (ess-R-fl-keyword:F&T . t)
        (ess-R-fl-keyword:%op% . t)
        ))

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

;;......................................................................
;; Julia
;;......................................................................
;; https://github.com/emacs-ess/ESS/wiki/Julia
(setq inferior-julia-program-name "~/Programas/julia/usr/bin/julia-release-basic")

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
;; Auto complete mode
;;======================================================================

;; auto-complete
;; instalar https://aur.archlinux.org/packages/auto-complete/
(add-to-list 'load-path "/usr/share/emacs/site-lisp/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
	     "/usr/share/emacs/site-lisp/auto-complete/ac-dict")
(ac-config-default)

;; To activate ESS auto-complete for R
(setq ess-use-auto-complete 'script-only)

;;======================================================================
;; Functions (for insane things!)
;;======================================================================

;;----------------------------------------------------------------------
;; Duplicate lines (like in Geany).
;; http://stackoverflow.com/questions/88399/how-do-i-duplicate-a-whole-line-in-emacs

(defun duplicate-line ()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (newline)
  (yank)
  )

(global-set-key (kbd "\C-c d") 'duplicate-line)

;;----------------------------------------------------------------------
;; Cut and copy without selection.
;; http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html

(defun copy-line-or-region ()
  "Copy current line, or current text selection."
  (interactive)
  (if (region-active-p)
      (kill-ring-save
       (region-beginning)
       (region-end)
       )
    (kill-ring-save
     (line-beginning-position)
     (line-beginning-position 2)
     )
    )
  )

(defun cut-line-or-region ()
  "Cut the current line, or current text selection."
  (interactive)
  (if (region-active-p)
      (kill-region
       (region-beginning)
       (region-end)
       )
    (kill-region
     (line-beginning-position)
     (line-beginning-position 2)
     )
    )
  )

(global-set-key (kbd "S-<delete>") 'cut-line-or-region)  ; cut.
(global-set-key (kbd "C-<insert>") 'copy-line-or-region) ; copy.


;;----------------------------------------------------------------------
;; (un)Comment without selection.

(defun comment-line-or-region ()
  "Comment or uncomment current line, or current text selection."
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region
       (region-beginning)
       (region-end)
       )
    (comment-or-uncomment-region
     (line-beginning-position)
     (line-beginning-position 2)
     )
    )
  )

(global-set-key (kbd "M-;") 'comment-line-or-region)

;;----------------------------------------------------------------------
;; Move lines.
;; http://www.emacswiki.org/emacs/MoveLine

(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(global-set-key (kbd "M-<") 'move-line-up)
(global-set-key (kbd "M->") 'move-line-down)

;;----------------------------------------------------------------------
;; Move regions.

(defun move-region (start end n)
  "Move the current region up or down by N lines."
  (interactive "r\np")
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (let ((start (point)))
      (insert line-text)
      (setq deactivate-mark nil)
      (set-mark start))))

(defun move-region-up (start end n)
  "Move the current line up by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) -1 (- n))))

(defun move-region-down (start end n)
  "Move the current line down by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) 1 n)))

(global-set-key (kbd "M-[") 'move-region-up)
(global-set-key (kbd "M-]") 'move-region-down)

;;----------------------------------------------------------------------
;; Improved version of occur. Quick navigation.
;; http://ignaciopp.wordpress.com/2009/06/10/customizing-emacs-occur/

(defun my-occur (&optional arg)
  "Make sure to always put occur in a vertical split, into a
   narrower buffer at the side. I didn't like the default
   horizontal split, nor the way it messes up the arrangement of
   windows in the frame or the way in which the standard way uses
   a neighbor window."
  (interactive "P")
  ;; store whatever frame configuration we are currently in
  (window-configuration-to-register ?y)
  (occur (read-from-minibuffer "Regexp: "))
  (if (occur-check-existence)
      (progn
        (delete-other-windows)
	;; (split-window-horizontally)
	;; (enlarge-window-horizontally -30)
        (split-window-vertically)
        (enlarge-window -10)
	;; (set-cursor-color "green")
        )
    )
  (occur-procede-accordingly)
  (next-error-follow-minor-mode) ;;+
  )

(defun occur-procede-accordingly ()
  "Switch to occur buffer or prevent opening of the occur window
   if no matches occurred."
  (interactive "P")
  (if (not(get-buffer "*Occur*"))
      (message "There are no results.")
    (switch-to-buffer "*Occur*")))

(defun occur-check-existence()
  "Signal the existence of an occur buffer depending on the
   number of matches."
  (interactive)
  (if (not(get-buffer "*Occur*")) nil t)
  )

;; Key binding.
(define-key global-map (kbd "C-S-o") 'my-occur)

;; http://www.emacswiki.org/emacs/OccurMode
;; To show more context lines, use
;; C-U 5 M-x occur regexp-to-search

(defun occur-mode-quit ()
  "Quit and close occur window. I want to press 'q' and leave
   things as they were before in regard of the split of windows
   in the frame. This is the equivalent of pressing C-x 0 and
   reset windows in the frame, in whatever way they were, plus
   jumping to the latest position of the cursor which might have
   been changed by using the links out of any of the matches
   found in occur."
  (interactive)
  (switch-to-buffer "*Occur*")
  ;; in order to know where we put the cursor they might have jumped from occur
  (other-window 1)                  ;; go to the main window
  (point-to-register ?1)            ;; store the latest cursor position
  (switch-to-buffer "*Occur*")      ;; go back to the occur window
  (kill-buffer "*Occur*")           ;; delete it
  (jump-to-register ?y)             ;; reset the original frame state
  ;; (set-cursor-color "rgb:ff/fb/53") ;; reset cursor color
  (register-to-point ?1))           ;; re-position cursor

;; Some key bindings defined below. Use "p" ans "n" as in dired mode
;; (without Cntrl key) for previous and next line; just show occurrence
;; without leaving the "occur" buffer; use RET to display the line of
;; the given occurrence, instead of jumping to i,t which you do clicking
;; instead; also quit mode with Ctrl-g.

(define-key occur-mode-map (kbd "q") 'occur-mode-quit)
;; (define-key occur-mode-map (kbd "C-RET") 'occur-mode-goto-occurrence-other-window)
;; (define-key occur-mode-map (kbd "C-<up>") 'occur-mode-goto-occurrence-other-window)
;; (define-key occur-mode-map (kbd "RET") 'occur-mode-display-occurrence)
;; (define-key occur-mode-map (kbd "p") 'previous-line)
;; (define-key occur-mode-map (kbd "n") 'next-line)


;;======================================================================
;; end of .emacs
;;======================================================================
