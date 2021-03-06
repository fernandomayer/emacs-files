;;======================================================================
;; Functions only
;;======================================================================

;;======================================================================
;; (R) markdown mode
;;======================================================================

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
;; ESS and R related customizations
;;======================================================================

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

;;----------------------------------------------------------------------
;; essh.el - ESS like shell mode
(defun essh-sh-hook ()                                             
  (define-key sh-mode-map "\C-c\C-r" 'pipe-region-to-shell)        
  (define-key sh-mode-map "\C-c\C-b" 'pipe-buffer-to-shell)        
  (define-key sh-mode-map "\C-c\C-j" 'pipe-line-to-shell)          
  (define-key sh-mode-map "\C-c\C-n" 'pipe-line-to-shell-and-step) 
  (define-key sh-mode-map "\C-c\C-f" 'pipe-function-to-shell)      
  (define-key sh-mode-map "\C-c\C-d" 'shell-cd-current-directory)) 
(add-hook 'sh-mode-hook 'essh-sh-hook)       
;;----------------------------------------------------------------------

;;======================================================================
;; Shell
;;======================================================================

;; Send line or region to a shell buffer
;; http://stackoverflow.com/questions/6286579/emacs-shell-mode-how-to-send-region-to-shell
;; (defun sh-send-line-or-region (&optional step)
;;   (interactive ())
;;   (let ((proc (get-process "shell"))
;;         pbuf min max command)
;;     (unless proc
;;       (let ((currbuff (current-buffer)))
;;         (shell)
;;         (switch-to-buffer currbuff)
;;         (setq proc (get-process "shell"))
;;         ))
;;     (setq pbuff (process-buffer proc))
;;     (if (use-region-p)
;;         (setq min (region-beginning)
;;               max (region-end))
;;       (setq min (point-at-bol)
;;             max (point-at-eol)))
;;     (setq command (concat (buffer-substring min max) "\n"))
;;     (with-current-buffer pbuff
;;       (goto-char (process-mark proc))
;;       (insert command)
;;       (move-marker (process-mark proc) (point))
;;       ) ;;pop-to-buffer does not work with save-current-buffer -- bug?
;;     (process-send-string  proc command)
;;     (display-buffer (process-buffer proc) t)
;;     (when step 
;;       (goto-char max)
;;       (next-line))
;;     ))

;; (defun sh-send-line-or-region-and-step ()
;;   (interactive)
;;   (sh-send-line-or-region t))
;; (defun sh-switch-to-process-buffer ()
;;   (interactive)
;;   (pop-to-buffer (process-buffer (get-process "shell")) t))

;; (global-set-key (kbd "C-j") 'sh-send-line-or-region-and-step)
;; (global-set-key (kbd "C-c C-z") 'sh-switch-to-process-buffer)

;; (define-key sh-mode-map [(control ?j)] 'sh-send-line-or-region-and-step)
;; (define-key sh-mode-map [(control ?c) (control ?z)] 'sh-switch-to-process-buffer)

;;======================================================================
;; Functions (for insane things!)
;;======================================================================

;;----------------------------------------------------------------------
;; Commented rules to divide code.

(defun insert-rule-and-comment-1 ()
  "Insert a commented rule with 70 dashes (-). Useful to divide
   your code in sections."
  (interactive)
  (insert (make-string 70 ?-))
  (comment-or-uncomment-region
   (line-beginning-position)
   (line-beginning-position 2))
  (backward-char 70)
  (backward-delete-char 1 2)
  (move-end-of-line nil)
  )

(global-set-key [?\M--] 'insert-rule-and-comment-1)

(defun insert-rule-and-comment-2 ()
  "Insert a commented rule with 70 equals (=). Useful to divide
   your code in sections."
  (interactive)
  (insert (make-string 70 ?=))
  (comment-or-uncomment-region
   (line-beginning-position)
   (line-beginning-position 2))
  (backward-char 70)
  (backward-delete-char 1 2)
  (move-end-of-line nil)
  )

(global-set-key [?\M-=] 'insert-rule-and-comment-2)

(defun insert-rule-and-comment-3 ()
  "Insert a commented rule with 43 dashes (-). Useful to divide
   your code in sections."
  (interactive)
  (insert (make-string 43 ?-))
  (comment-or-uncomment-region
   (line-beginning-position)
   (line-beginning-position 2))
  (backward-char 70)
  (backward-delete-char 1 2)
  (move-end-of-line nil)
  )

(global-set-key [?\C--] 'insert-rule-and-comment-3)

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

;;----------------------------------------------------------------------
;; All functions defined below were copied from:
;; http://www.emacswiki.org/emacs/ess-edit.el
;; https://github.com/emacsmirror/ess-edit/blob/master/ess-edit.el

(defun ess-edit-backward-move-out-of-comments (lim)
  "If inside comments, move the point backwards out."
  (let ((opoint (point)) stop)
    (if (save-excursion
	  (beginning-of-line)
	  (search-forward "#" opoint 'move))
	(while (not stop)
	  (skip-chars-backward " \t\n\f" lim)
	  (setq opoint (point))
	  (beginning-of-line)
	  (search-forward "#" opoint 'move)
	  (skip-chars-backward " \t#")
	  (setq stop (or (/= (preceding-char) ?\n) (<= (point) lim)))
	  (if stop (point)
	    (beginning-of-line))))))

(defun ess-edit-backward-move-out-of-quotes ()
  "If inside quotes, move the point backwards out."
  (let ((start 
	 (save-excursion
	   (beginning-of-line) (point))))
    (if (ess-edit-within-quotes start (point))
	(re-search-backward "[\'\"]" nil t))))

(defun ess-edit-within-quotes (beg end)
  "Return t if the number of quotes between BEG and END is odd.
   Quotes are single and double."
  (let (
	;; (countsq (ess-edit-how-many-quotes-region "\\(^\\|[^\\\\]\\)\'" beg end))
	;; (countdq (ess-edit-how-many-quotes-region "\\(^\\|[^\\\\]\\|^\"\"\\)\"" beg end)))
	(countsq (ess-edit-how-many-quotes-region beg end))
	(countdq (ess-edit-how-many-quotes-region beg end)))
    ;; (countsq (ess-edit-how-many-region "\'" beg end))
    ;; (countdq (ess-edit-how-many-region "\"" beg end)))
    (or (= (mod countsq 2) 1) (= (mod countdq 2) 1))))

;; modified copy of comint-how-many-region
(defun ess-edit-how-many-quotes-region (beg end)
  "Return number of matches for quotes skipping double quotes and escaped quotes from BEG to END."
  (let ((count 0))
    (save-excursion
      (save-match-data
	(goto-char beg)
	(while (re-search-forward "\"\\|\'" end t)
	  (if (or (save-excursion
		    (backward-char 3)
		    (looking-at "\\\\"))
		  (looking-at "\"\\|\'"))
	      (forward-char 1)
	    (setq count (1+ count))))))
    count))

(defun ess-edit-read-call (&optional arg move all)
  "Return the name of the R-function call at point as a string.
   If ARG return name of function call which is ARG function
   calls above point. If MOVE is non-nil leave point after
   opening parentheses of call. If all is non-nil return the full
   string."
  (interactive "p")
  (or arg (setq arg 1))
  (if (< arg 0) (error "Only backward reading of function calls possible."))
  (add-hook 'pre-command-hook 'ess-edit-pre-command-hook)
  ;; assume correct syntax, at least beyond previous paragraph-start 
  (let ((oldpoint (point))
	(lim (save-excursion
	       (backward-paragraph 1) (point)))
	fun beg end)
    ;; move outside comments and quotes first
    (ess-edit-backward-move-out-of-comments lim)
    (ess-edit-backward-move-out-of-quotes)
    ;;what if we are sitting on a function call?
    (if (save-excursion
	  (skip-chars-backward "a-zA-Z0-9.")
	  (looking-at "\\([a-zA-Z0-9.]+\\)\\((\\)"))
	(setq beg (match-beginning 1) end (match-end 1)
	      fun (list (match-string 1))
	      arg (- arg 1)))
    (while
	(and (> arg 0)
             (re-search-backward "[\"\'()]" lim t)
             (let ((matchcar (char-before (match-end 0)))
                   matchcall)
               (if (eq ?\( matchcar)
                   ;; test if sitting on proper function call
                   (if (not (progn
                              (skip-chars-backward "a-zA-Z0-9.")
                              (looking-at "\\([a-zA-Z0-9.]+\\)\\((\\)")))
                       nil
                     (if (string= "\\(if\\|else\\|for\\)"
                                  (setq matchcall (match-string 1)))
                         t
                       (setq beg (match-beginning 1) end (match-end 1)
                             fun (append (list matchcall) fun))
                       (if (= arg 1) nil (setq arg (- arg 1)))))
                 ;; skip balanced parentheses or quotes
                 (if (not (= ?\) matchcar))
                     (re-search-backward
                      (char-to-string matchcar) lim t)
                   (condition-case nil 
                       (progn
                         (forward-char 1)
                         (backward-sexp) t)
                     (t (goto-char oldpoint)
                        (error "Point is not in a proper function call or unbalanced parentheses paragraph."))))))))
    (if (not fun)
        (progn (goto-char oldpoint)
               (error "Point is not in a proper function call or unbalanced parentheses in this paragraph."))
      (ess-edit-highlight 0 beg end)
      (message (car fun))
      (goto-char (if move (+ (point) (skip-chars-forward "a-zA-Z0-9."))
                   oldpoint))
      (if all fun (car fun)))))

;; Two functions for activating and deactivation highlight overlays
(defun ess-edit-highlight (index begin end &optional buffer)
  "Highlight a region with overlay INDEX."
  (move-overlay (aref ess-edit-highlight-overlays index)
                begin end (or buffer (current-buffer))))

;; We keep a vector with several different overlays to do our highlighting.
(defvar ess-edit-highlight-overlays [nil nil])

;; Initialize the overlays
(aset ess-edit-highlight-overlays 0 (make-overlay 1 1))
(overlay-put (aref ess-edit-highlight-overlays 0) 'face 'highlight)
(aset ess-edit-highlight-overlays 1 (make-overlay 1 1))
(overlay-put (aref ess-edit-highlight-overlays 1) 'face 'highlight)

(defun ess-edit-indent-call-sophisticatedly (&optional arg force)
  (interactive "p")
  (let* ((arg (or arg 1))
	 (fun (ess-edit-read-call arg 'go))
	 (beg (+ (point) 1))
	 (end (progn (forward-sexp) (point)))
	 breaks
	 delete-p)
    ;;	  (eq last-command 'ess-edit-indent-call-sophisticatedly)
    (goto-char beg)
    (while (setq match (re-search-forward "[\"\'{([,]" end t))
      (if (string= (match-string 0) ",")
	  (setq breaks (cons (cons (point)
				   (if (looking-at "[ \t]*\n") t nil)) breaks))
	(if (or (string= (match-string 0) "\"")  (string= (match-string 0) "\'"))
	    (re-search-forward (match-string 0) nil t)
          (backward-char 1)
          (forward-sexp))))
    ;; if there are more breaks than half the number of
    ;; arguments then delete breaks else add linebreaks
    (setq delete-p
	  (if force nil
	    (> (length (delete nil (mapcar 'cdr breaks))) (* 0.5 (length breaks)))))
    (while breaks (goto-char (caar breaks))
           (if delete-p
               (if (cdar breaks)
                   (delete-region (caar breaks) (+ (point) (skip-chars-forward " \t\n"))))
             (if (not (cdar breaks))
                 (insert "\n")))
           (setq breaks (cdr breaks)))
    (goto-char (- beg 1))
    (ess-indent-exp)
    (ess-edit-read-call arg 'go)))

;; (global-set-key (kbd "C-c C-h") 'ess-eval-word)
(add-hook 'ess-mode-hook
          (lambda () (local-set-key (kbd "C-c C-h")
                                    'ess-edit-indent-call-sophisticatedly)))
