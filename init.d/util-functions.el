(defun update-project-list ()
  "aktualisiert project.els bekannte Projekte"
  (interactive)
  (let ((search-dirs (list "~/.config/" "~/Projekte/" user-emacs-directory)))
    (project-forget-zombie-projects)
    (mapc (lambda (dir)
	    (project-remember-projects-under dir t))
	  search-dirs)))

(provide 'util-functions)
