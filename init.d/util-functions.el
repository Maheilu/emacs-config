;; only builtin packages loaded
(defun add-multiple-to-list (list &rest vals)
    (mapc (lambda (val) (add-to-list list val)) vals))

(defun add-buffer-local-sub-hook (global-hook local-hook func)
  (add-hook global-hook `(lambda () (add-hook ',local-hook #',func nil 'local))))

(defun update-project-list ()
  "aktualisiert project.els bekannte Projekte"
  (interactive)
  (let ((search-dirs (list "~/.config/" "~/Projekte/" user-emacs-directory)))
    (project-forget-zombie-projects)
    (mapc (lambda (dir) (project-remember-projects-under dir t))
	  search-dirs)))

(defun open-config ()
  "öffnet init.el"
  (interactive)
  (find-file user-init-file))

(defun open-init.d ()
  "find-file in init.d"
  (interactive)
  ;; TODO put init.d in find file completion
  (find-file (concat user-emacs-directory "init.d/")))

(defun gdb-in-new-frame ()
  "öffnet aktiven Buffer in neuem Frame und startet gdb-many-windows"
  (interactive)
  (select-frame (make-frame))
  (call-interactively #'gdb)
  (gdb-many-windows))

(defun eshell-in-new-frame ()
  "öffnet eshell in neuem Frame"
  (interactive)
  (select-frame (make-frame))
  (call-interactively #'eshell))

(defvar enable-theme-hook nil "selbstgeschriebener hook für nach dem laden eines Themes")
(advice-add #'enable-theme :after (lambda (&rest r) (run-hooks 'enable-theme-hook)) '((name . "run-enable-theme-hook")))

(provide 'util-functions)
