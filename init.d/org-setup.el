(elpaca org
  (setq org-directory "~/Dokumente/org/"
        org-agenda-files (concat org-directory ".agenda_list")
        org-agenda-window-setup 'current-window
        org-agenda-todo-list-sublevels t
        org-agenda-todo-ignore-deadlines nil
        org-agenda-todo-ignore-scheduled 'future
        org-agenda-span 'month
        org-agenda-skip-scheduled-if-deadline-is-shown nil
        org-startup-folded t
        org-hierarchical-todo-statistics nil
        org-format-latex-options
        '(:foreground default :background default :scale 1.5
          :html-foreground "Black" :html-background "Transparent" :html-scale 1.0
          :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))
  (with-eval-after-load 'ol
    (setf (cdr (assoc 'file org-link-frame-setup)) #'find-file))

  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
  (add-hook 'org-mode-hook #'org-display-inline-images)
  ;; delay until modes for programming are installed/initialized
  (with-eval-after-load 'languages-setup
    (setq org-babel-load-languages '((emacs-lisp . t)
                                     (C . t)
                                     (shell . t)
                                     (python . t)
                                     (R . t)
                                     (julia . t)
                                     (calc . t)))))
(elpaca org-roam
  (setq org-roam-directory org-directory
        org-roam-capture-templates
        '(("d" "my-default" plain "%?"
           :target (file+head "${slug}.org" "#+title: ${title}")
           :unnarrowed t
           :immediate-finish t
           :jump-to-captured t)
          ("m" "Mechatronik" plain "%?"
           :target (file+head "Mechatronik/${slug}.org" "#+title: ${title}")
           :unnarrowed t
           :immediate-finish t
           :jump-to-captured t)
          ("D" "DnD related captures")
          ("Dk" "DnD Kampagne 2022+")
          ("Dkn" "Notiz" plain "%?"
           :target (file+head "DnD/PE2022/${slug}.org" "#+title: ${title}")
           :unnarrowed t
           :immediate-finish t
           :jump-to-captured t)
          ("dkm" "Map Notiz" plain "%?"
           :target (file+head "DnD/PE2022/Maps/${slug}.org" "#+title: ${title}")
           :unnarrowed t
           :immediate-finish t
           :jump-to-captured t)
          ("dki" "Item Notiz" plain "%?"
           :target (file+head "DnD/PE2022/Items/${slug}.org" "#+title: ${title}")
           :unnarrowed t
           :immediate-finish t
           :jump-to-captured t))))

(when (equal system-type 'gnu/linux)
  (elpaca citeproc (setq org-cite-csl-styles-dir "~/Zotero/styles"))
  (elpaca citar
    (setq org-cite-insert-processor 'citar
          org-cite-follow-processor 'citar
          org-cite-activate-processor 'citar)
    (add-hook 'org-mode-hook #'citar-capf-setup))
  (elpaca citar-embark))
(setq calendar-date-style 'iso)

(provide 'org-setup)
