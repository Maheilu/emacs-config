(elpaca org
  (setq org-directory "~/Dokumente/org/")
  (setq org-babel-load-languages '((emacs-lisp . t)
                                   (C . t)
                                   (shell . t)
                                   (python . t)
                                   (R . t)))
  (setq org-agenda-files (concat org-directory ".agenda_list"))
  (setq org-agenda-todo-list-sublevels t)
  (setq org-agenda-todo-ignore-deadlines 'far)
  (setq org-agenda-todo-ignore-scheduled 'future)
  (setq org-agenda-span 'month)
  (setq org-agenda-skip-scheduled-if-deadline-is-shown t)
  (setq org-startup-folded t)
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
  (add-hook 'org-mode-hook #'org-display-inline-images)
  (add-hook 'org-mode-hook #'hl-todo-mode)
  (setq org-hierarchical-todo-statistics nil))
(elpaca org-roam
  (setq org-roam-directory org-directory)
  (setq org-roam-capture-templates
        '(("d" "my-default" plain "%?"
           :target (file+head "${slug}.org" "#+title: ${title}")
           :unnarrowed t
           :immediate-finish t
           :jump-to-captured t)))
  (setq org-return-follows-link t))
(elpaca org-super-agenda
  (org-super-agenda-mode 1)
  (setq org-super-agenda-groups
	'((:name "Today"  
                 :time-grid t
                 :todo "TODAY")
	  (:name "Top-Priority"
                 :priority "A")
	  (:priority<= "B" :order 1))))
(provide 'org-setup)
