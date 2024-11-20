;;; $DOOMDIR/+ui.el -*- lexical-binding: t; -*-


(load! "lisp/bitmaps")
(load! "lisp/frames")


;;; -----------------------------------------------------------------------------
;;; Theme
;;; -----------------------------------------------------------------------------
(setq doom-theme 'doom-github-classic-dark)


;;; -----------------------------------------------------------------------------
;;; Font
;;; -----------------------------------------------------------------------------
(setq doom-font (font-spec :family "MesloLGM Nerd Font" :size 14 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Monaco" :size 13))


;;; -----------------------------------------------------------------------------
;;; Frame
;;; -----------------------------------------------------------------------------
(setq default-frame-alist
      '((internal-border-width . 0)))


;;; -----------------------------------------------------------------------------
;;; Titlebar
;;; -----------------------------------------------------------------------------
(after! solaire-mode
  (add-hook 'solaire-global-mode-hook #'my/solaire-mode-hack-titlebar-color  t)
  (add-hook 'doom-init-ui-hook #'my/solaire-mode-hack-titlebar-color t))

(add-hook 'window-size-change-functions #'my/hack-clear-titlebar-title)

;; not even sure if this is doing anything
(setq frame-title-format " "
      ns-use-proxy-icon nil)


;;; -----------------------------------------------------------------------------
;;; Sidebar
;;; -----------------------------------------------------------------------------
(after! treemacs
  (setq treemacs-collapse-dirs 0
        treemacs-git-mode nil))

(add-hook! treemacs-mode 'hide-mode-line-mode)

(after! treemacs-nerd-icons
  (load! "lisp/my-treemacs-theme")
  (my/treemacs-theme-reload))


;;; -----------------------------------------------------------------------------
;;; Line numbers
;;; -----------------------------------------------------------------------------
(setq display-line-numbers-type t)


;;; -----------------------------------------------------------------------------
;;; Modeline
;;; -----------------------------------------------------------------------------
(setq doom-modeline-modal nil)


;;; -----------------------------------------------------------------------------
;;; IntelliSense
;;; -----------------------------------------------------------------------------
(after! lsp-ui
  (setq lsp-ui-sideline-enable nil))







;; dont think this does anything?
;; (after! (:and solaire-mode treemacs)
;;   (push '(treemacs-window-background-face . solaire-default-face) solaire-mode-remap-alist)
;;   (push '(treemacs-hl-line-face . solaire-hl-line-face) solaire-mode-remap-alist))

;; dont think this does anything?
;; (after! highlight-indent-guides
;;   (setq highlight-indent-guides-method 'bitmap
;;         highlight-indent-guides-responsive 'top
;;         highlight-indent-guides-auto-character-face-perc 10
;;         highlight-indent-guides-auto-top-character-face-perc 20
;;         highlight-indent-guides-bitmap-function 'my/highlight-indent-guides--bitmap-dots)
;;   (highlight-indent-guides-mode -1)
;;   (remove-hook! (prog-mode text-mode conf-mode) #'highlight-indent-guides-mode))

;; (set-face-attribute 'font-lock-comment-face nil :slant 'italic)





;; the below stuff works in theory, it will brighten the color of the text on the current line
;; we have to just hook in to when treemacs is calling the hl-line apply and then also
;; apply this i think

;; (defun my-brighten-color-for-face (face)
;;   "Return a brightened version of the foreground color for FACE."
;;   (when (facep face)
;;     (let ((color (face-foreground face nil 'default)))
;;       (when color
;;         (color-lighten-name color 20)))))  ; Adjust the 20% to your liking

;; (defvar my-line-brightened-overlays nil
;;   "List of overlays for brightening the foreground color of text on the current line.")

;; (defun my-apply-brightened-faces-on-line ()
;;   "Apply brightened foreground colors to faces on the current line individually."
;;   (interactive)
;;   (let ((line-start (line-beginning-position))
;;         (line-end (line-end-position)))
;;     ;; First, clear existing overlays.
;;     (mapc 'delete-overlay my-line-brightened-overlays)
;;     (setq my-line-brightened-overlays nil)  ; Reset the list after cleanup.

;;     (save-excursion
;;       (goto-char line-start)
;;       (while (< (point) line-end)
;;         (let* ((pos (point))
;;                (face (get-text-property pos 'face))
;;                (next-change (or (next-single-property-change pos 'face nil line-end) line-end))
;;                (brightened-color (my-brighten-color-for-face face)))
;;           (when brightened-color
;;             (let ((ov (make-overlay pos next-change)))
;;               (overlay-put ov 'face `(:foreground ,brightened-color))
;;               ;; Add this overlay to our list for future management.
;;               (push ov my-line-brightened-overlays)))
;;           (goto-char next-change))))))
