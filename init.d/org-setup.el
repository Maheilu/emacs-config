(elpaca org
  (setq org-directory "~/Dokumente/org/"
        org-babel-load-languages '((emacs-lisp . t)
                                   (C . t)
                                   (shell . t)
                                   (python . t)
                                   (R . t))
        org-agenda-files (concat org-directory ".agenda_list")
        org-agenda-todo-list-sublevels t
        org-agenda-todo-ignore-deadlines 'far
        org-agenda-todo-ignore-scheduled 'future
        org-agenda-span 'month
        org-agenda-skip-scheduled-if-deadline-is-shown t
        org-startup-folded t
        org-hierarchical-todo-statistics nil)
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
  (add-hook 'org-mode-hook #'org-display-inline-images)
  (add-hook 'org-mode-hook #'hl-todo-mode))
(elpaca org-roam
  (setq org-roam-directory org-directory
        org-roam-capture-templates
        '(("d" "my-default" plain "%?"
           :target (file+head "${slug}.org" "#+title: ${title}")
           :unnarrowed t
           :immediate-finish t
           :jump-to-captured t))
        org-return-follows-link t))
(elpaca org-super-agenda
  (org-super-agenda-mode 1)
  (setq org-super-agenda-groups
	'((:name "Today"  
                 :time-grid t
                 :todo "TODAY")
	  (:name "Top-Priority"
                 :priority "A")
	  (:priority<= "B" :order 1))))
(when (equal system-type 'gnu/linux)
  (elpaca citeproc (setq org-cite-csl-styles-dir "~/Zotero/styles"))
  (elpaca citar
    (setq org-cite-insert-processor 'citar
          org-cite-follow-processor 'citar
          org-cite-activate-processor 'citar)
    (add-hook 'org-mode-hook #'citar-capf-setup))
  (elpaca citar-embark))

(provide 'org-setup)
