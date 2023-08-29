;; lsp
(add-hook 'c++-mode-hook #'eglot-ensure)
(add-hook 'python-mode-hook #'eglot-ensure)
(elpaca consult-eglot)
;; lisps
(elpaca parinfer-rust-mode)
;; R
(elpaca ess)

;;tree-sitter
(when (equal system-type 'gnu/linux)
  (setq treesit-language-source-alist
        '((cpp "https://github.com/tree-sitter/tree-sitter-cpp")
          (c "https://github.com/tree-sitter/tree-sitter-c")
	  (python "https://github.com/tree-sitter/tree-sitter-python")))
  (setq major-mode-remap-alist
        '((c++-mode . c++-ts-mode)
          (c-mode . c-ts-mode)
	  (python-mode - python-ts-mode)))
  (add-hook 'c++-ts-mode-hook (lambda () (run-mode-hooks 'c++-mode-hook)))
  (add-hook 'python-ts-mode-hook (lambda () (run-mode-hooks 'python-mode-hook)))
  (customize-set-variable 'treesit-font-lock-level 3))

(provide 'languages-setup)
