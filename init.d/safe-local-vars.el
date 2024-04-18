(add-multiple-to-list 'safe-local-variable-values
		      '(python-interpreter . ".venv/Scripts/python.exe")
		      '(python-shell-interpreter . ".venv/Scripts/python.exe")
              '(org-roam-directory . "/home/maheilu/Projekte/Seminar-R")
		      '(org-roam-db-location . "/home/maheilu/Projekte/Seminar-R/org-roam.db")
              '(haskell-process-use-ghci . t)
              '(haskell-indent-spaces . 4))

(provide 'safe-local-vars)
