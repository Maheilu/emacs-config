(evil-define-key '(normal emacs) 'global
  (kbd "C-x C-k") #'kill-current-buffer
  (kbd "+") #'er/expand-region
  (kbd "-") #'er/contract-region
  (kbd "C-l l") #'link-hint-open-link
  (kbd "C-l C-l") #'link-hint-copy-link
  (kbd "C-l p") #'link-hint-open-link-at-point
  (kbd "C-l C-p") #'link-hint-copy-link-at-point
  (kbd "C-x c") #'open-config
  (kbd "C-x C") #'open-init.d
  (kbd "C-x f") #'consult-flymake
  (kbd "C-x n .") (defun open-high-level-tasks () "Open high_level_tasks.org"
                         (interactive)
                         (find-file (concat org-directory "/high_level_tasks.org")))
  (kbd "M-I") #'imenu
  (kbd "M-i") #'consult-imenu)
(evil-define-key '(normal insert emacs) 'global
  (kbd "M-e") #'expand-abbrev)

;; transpose
(evil-define-key '(normal emacs) 'global
  (kbd "t c") #'transpose-chars
  (kbd "t l") #'transpose-lines
  (kbd "t w") #'transpose-words
  (kbd "t s") #'transpose-sexps)

;; avy
(evil-define-key '(normal insert emacs) 'global
  (kbd "M-a") #'avy-goto-char-timer
  (kbd "M-l") #'avy-goto-line)
(evil-define-key '(normal insert emacs) 'org-mode-map
  (kbd "M-h") #'avy-org-goto-heading-timer)
(evil-define-key '(normal emacs) 'global
  (kbd "] a") #'avy-next
  (kbd "[ a") #'avy-prev)
(with-eval-after-load 'avy
  (setq avy-timeout-seconds 0.1        ;; Melee Ganon jumpsquat; aka forever
        avy-keys '(?w ?a ?s ?d ?h ?j ?k ?l ? )
        avy-style 'de-bruijn
        avy-all-windows 'all-frames))

;; minibuffers etc.
(evil-define-key nil vertico-map
  (kbd "C-q") #'vertico-quick-insert
  (kbd "M-q") #'vertico-quick-exit
  (kbd "C-.") #'embark-act
  (kbd "C-,") #'embark-dwim
  (kbd "C-:") #'describe-symbol)
(evil-define-key '(normal emacs) 'global
  (kbd "C-h b") #'embark-bindings
  (kbd "C-x b") #'consult-project-buffer
  (kbd "C-x C-b") #'consult-buffer
  (kbd "C-x d") #'consult-dir
  (kbd "C-x C-d") #'dired-jump)
(evil-define-key '(normal insert emacs) 'global (kbd "C-.") #'embark-act
  (kbd "C-,") #'embark-dwim
  (kbd "C-:") #'describe-symbol)

;; completion
(if (equal system-type 'windows-nt)
    (evil-define-key '(normal insert emacs) 'global (kbd "M-q") #'completion-at-point)
  (evil-define-key '(normal insert emacs) 'global
    (kbd "M-<tab>") #'completion-at-point
    (kbd "M-q") #'corfu-candidate-overlay-complete-at-point))
(evil-define-key nil corfu-map
  (kbd "<tab>") #'corfu-next
  (kbd "<backtab>") #'corfu-previous ;; Shift+Tab
  (kbd "M-q") #'corfu-quick-insert)

;; org agenda mode
(evil-define-key '(normal emacs) org-agenda-mode-map
  (kbd "h") #'left-char
  (kbd "j") #'org-agenda-next-line
  (kbd "k") #'org-agenda-previous-line
  (kbd "l") #'right-char
  (kbd "w") #'evil-forward-word-begin
  (kbd "e") #'evil-forward-word-end
  (kbd "b") #'evil-backward-word-begin
  (kbd "F") #'org-agenda-earlier)

;; dired mode
(with-eval-after-load 'dired
  (evil-define-key '(normal emacs) dired-mode-map
    (kbd "SPC") #'dired-find-file
    (kbd "S-SPC") #'dired-up-directory))

;; outline mode
; disable some evil-collection bindings
(evil-define-minor-mode-key ('normal emacs) 'outline-minor-mode
  "[[" nil
  "]]" nil
  (kbd "M-h") nil
  (kbd "M-j") nil
  (kbd "M-k") nil
  (kbd "M-l") nil)

(provide 'keybinds)
