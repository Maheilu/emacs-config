(evil-define-key '(normal emacs) 'global (kbd "C-x C-k") #'kill-current-buffer) 
(evil-define-key '(normal emacs) 'global (kbd "+") #'er/expand-region)
(evil-define-key '(normal emacs) 'global (kbd "-") #'er/contract-region)
(evil-define-key '(normal emacs) 'global (kbd "C-x l") #'link-hint-open-link)
(evil-define-key '(normal emacs) 'global (kbd "C-x C-l") #'link-hint-copy-link)
(evil-define-key '(normal emacs) 'global (kbd "C-x c") #'open-config)

(evil-define-key '(normal emacs) 'global (kbd "C-x n .")
  (lambda () "Open high_level_tasks.org" (interactive)
    (find-file (concat org-directory "/high_level_tasks.org"))))

;; minibuffers etc.
(define-key vertico-map (kbd "C-q") #'vertico-quick-insert)
(define-key vertico-map (kbd "M-q") #'vertico-quick-exit)
(define-key vertico-map (kbd "C-.") #'embark-act)
(define-key vertico-map (kbd "C-,") #'embark-dwim)
(evil-define-key '(normal emacs) 'global (kbd "C-h b") #'embark-bindings)
(evil-define-key '(normal emacs) 'global (kbd "C-x b") #'consult-project-buffer)
(evil-define-key '(normal emacs) 'global (kbd "C-x C-b") #'consult-buffer)
(evil-define-key '(normal emacs) 'global (kbd "C-x d") #'consult-dir)
(evil-define-key '(normal emacs) 'global (kbd "C-x C-d") #'dired-jump)
(evil-define-key '(normal insert emacs) 'global (kbd "C-.") #'embark-act)
(evil-define-key '(normal insert emacs) 'global (kbd "C-,") #'embark-dwim)

;; completion
(if (equal system-type 'windows-nt)
    (progn (define-key global-map (kbd "C-<tab>") #'completion-at-point)
	   (define-key corfu-map (kbd "C-<tab>") #'corfu-next)
	   (define-key corfu-map (kbd "<backtab>") #'corfu-previous)
	   (define-key corfu-popupinfo-map (kbd "C-<iso-lefttab>") #'corfu-popupinfo-toggle))
  (progn (define-key corfu-map (kbd "M-TAB") #'corfu-next)
	 (define-key corfu-map (kbd "<backtab>") #'corfu-previous) ;; Shift+Tab
	 (define-key corfu-popupinfo-map (kbd "M-<iso-lefttab>") #'corfu-popupinfo-toggle))) ;; Alt+Shift+Tab
(define-key corfu-map (kbd "M-q") #'corfu-quick-insert)
(evil-define-key '(normal insert emacs) 'global (kbd "M-q") #'corfu-candidate-overlay-complete-at-point)

(provide 'keybinds)
