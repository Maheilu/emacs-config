(setq eldoc-echo-area-prefer-doc-buffer t)
(elpaca vertico
  (vertico-mode t)
  (add-to-list 'load-path (expand-file-name "vertico/extensions" elpaca-repos-directory))
  (require 'vertico-quick))
(elpaca consult)
(elpaca marginalia (marginalia-mode t))
(elpaca embark)
(elpaca orderless
  (setq completion-styles '(orderless basic)
        completion-category-overrides '((file (styles basic partial-completion)))))
(elpaca embark-consult)
(elpaca consult-org-roam (consult-org-roam-mode 1))
(elpaca consult-dir)

(provide 'minibuffer-setup)
