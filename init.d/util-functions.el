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

(provide 'util-functions)
