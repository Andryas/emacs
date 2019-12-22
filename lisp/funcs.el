;; (un)Comment without selection. ----------------------------
 (defun comment-line-or-region ()
   "Comment or uncomment current line, or current text selection."
   (interactive)
   (if (region-active-p)
       (comment-or-uncomment-region
        (region-beginning)
        (region-end))
     (comment-or-uncomment-region
      (line-beginning-position)
      (line-beginning-position 2))))

;; Commented rules to divide code ----------------------------
(defun blank-line-p ()
  (string-match "^[[:space:]]*$"
                (buffer-substring-no-properties
                 (line-beginning-position)
                 (line-end-position))))

(defun wz-insert-rule-from-point-to-margin (&optional char)
  "Insert a commented rule with dashes (-) from the `point' to
   the `fill-column' if the line has only spaces. If the line has
   text, fill with dashes until the `fill-column'. Useful to
   divide your code in sections. If a non nil optional argument is
   passed, then it is used instead."
  (interactive)
  (if (blank-line-p)
      (progn (insert "-")
             (comment-line-or-region)
             (delete-char -2))
    nil)
  (if char
      (insert (make-string (- fill-column (current-column)) char))
    (insert (make-string (- fill-column (current-column)) ?-)))
  )

(defun wz-insert-rule-and-comment-3 ()
  "Insert a commented rule with 43 dashes (-). Useful to divide
   your code in sections."
  (interactive)
  (if (blank-line-p)
      (progn (insert "-")
             (comment-line-or-region)
             (delete-char -2))
    nil)
  (let ((column-middle (floor (* 0.625 fill-column))))
    (if (< (current-column) column-middle)
        (insert (make-string (- column-middle (current-column)) ?-)))))

;; Rmd Files -------------------------------------
;; Insert a new (empty) chunk to R markdown.
(defun wz-insert-chunk ()
  "Insert chunk environment Rmd sessions."
  (interactive)
  (if (derived-mode-p 'ess-mode)
      (insert "```\n\n```{r}\n")
    (insert "```{r}\n\n```")
    (forward-line -1)))

;; Evals current R chunk.
(defun wz-polymode-eval-R-chunk ()
  "Evals all code in R chunks in a polymode document (Rmd files)."
  (interactive)
  (if (derived-mode-p 'ess-mode)
      (let ((ptn (point))
            (beg (progn
                   (search-backward-regexp "^```{r.*}$" nil t)
                   (forward-line 1)
                   (line-beginning-position)))
            (end (progn
                   (search-forward-regexp "^```$" nil t)
                   (forward-line -1)
                   (line-end-position))))
        (ess-eval-region beg end nil)
        (goto-char ptn))
    (message "ess-mode weren't detected.")))

;; SQL format
(defun sql-beautify-region (beg end)
  "Beautify SQL in region between beg and END."
  (interactive "r")
  (save-excursion
    (shell-command-on-region beg end "anbt-sql-formatter" nil t)))
    ;; change sqlbeautify to anbt-sql-formatter if you
    ;;ended up using the ruby gem

(defun sql-beautify-buffer ()
 "Beautify SQL in buffer."
 (interactive)
 (sql-beautify-region (point-min) (point-max)))




;; Hotkeys ---------------------------------------------------
(global-set-key (kbd "M--") 'wz-insert-rule-from-point-to-margin)
(global-set-key (kbd "C--") 'wz-insert-rule-and-comment-3)
(global-set-key (kbd "M-=")
                (lambda ()
                  (interactive)
                  (wz-insert-rule-from-point-to-margin ?=)))
(global-set-key (kbd "M-;")   'comment-line-or-region)
(global-set-key (kbd "M-;") 'comment-line-or-region)
(global-set-key (kbd "M-s") 'sql-beautify-region)

(add-hook
 'markdown-mode-hook
 (lambda ()
   (local-set-key (kbd "C-i")   'wz-insert-chunk)
   (local-set-key (kbd "<f6>")    'wz-polymode-eval-R-chunk)))


(provide 'funcs)
