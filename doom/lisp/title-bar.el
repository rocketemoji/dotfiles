;;; lisp/title-bar.el -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;; This is a WIP solution to attempt to change the window title bar color to match the
;; "darker" color of the sidebar, popups, minibuffer, etc. when using solaire-mode.
;;
;; The main premise is that the window manager itself seems to be taking the color of the default face and using that for the title bar color. So my thought was that we could potentially do a hack where we actually set the default face to the color we want, and then do a buffer local remap of all buffers that should be treated like editor buffers to give them the desired "editor" background color.
;;
;; However, one certainly must ask if that was the right approach then wouldn't solaire-mode do it that way in the first place, so there must be a very good reason why not to do that.

;; -------------------------------------------------------------------------
;; Approach 1
;;
;; Commenatry:
;; This approach hooks into when solaire-mode gets turned on so we can rely on their logic for figuring out when that needs to be called. Then, we check the buffer and decide if we should apply the remapping. And the way we do that is actually by checking if the minor solaire-mode was turned in the buffer itself because that is an indicator if we should treat the buffer as "real" or not, since solaire-mode is only turned on in buffers that are not "real" buffers.
;;
;; This approach seems to work for the most part, but has the following issues:
;; 1. The buffer first gets the wrong background color before it settles into the correct color, resulting in a flash which is terrible ux. - this could maybe be solved via just making things faster or maybe there is a way for us to set the buffer background color before it gets rendered?
;; 2. The stuff in the fringes is also looking weird. And looking at the solaire-mode source tells us there may indeed be some weird stuff going on.

;; TODO
;; - well it's still not applyign to every single buffer, so maybe that is also part of the answer with the performance
;; - also, get the bg color from the theme / solaire face rather than hardcode
(defface my/real-buffer-default-face
  `((t (:background nil)))
  "Face for the active buffer background."
  :group 'custom-faces)

(defvar-local my/real-buffer-default-face-remap-cookie nil
  "Remap cookie for active buffer background.")

(defun my/real-buffer-default-face-apply-remap ()
  "hacks. - this stuff should happen on every buffer load or wtvr"
  (with-current-buffer (window-buffer (selected-window))
    (setq-local my/real-buffer-default-face-remap-cookie
                (face-remap-add-relative 'default 'my/real-buffer-default-face))))

(defun my/real-buffer-default-face-apply-remap-maybe ()
  ""
  (with-current-buffer (window-buffer (selected-window))
    (when (and (bound-and-true-p solaire-global-mode)
               (not (bound-and-true-p solaire-mode)))
      (my/real-buffer-default-face-apply-remap))))

(defun my/real-buffer-default-face-remap-prepare (&rest _args)
  "this stuff should happen once per load/theme load"
  (set-face-attribute 'my/real-buffer-default-face nil :background (face-attribute 'default :background))
  (set-face-attribute 'default nil :background "#1b1f23")
  (dolist (buf (buffer-list))
    (my/real-buffer-default-face-apply-remap-maybe)))

(advice-add 'turn-on-solaire-mode :after #'my/real-buffer-default-face-apply-remap-maybe)
(advice-add #'load-theme :after #'my/real-buffer-default-face-remap-prepare)
