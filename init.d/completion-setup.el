(elpaca corfu
  (global-corfu-mode 1)
  (setq corfu-preview-current nil)
  (add-to-list 'load-path (expand-file-name "corfu/extensions/" elpaca-repos-directory))
  (require 'corfu-popupinfo)
  (corfu-popupinfo-mode 1)
  (require 'corfu-quick))
(elpaca cape)
(elpaca kind-icon (require 'kind-icon)
	(setq kind-icon-default-face 'corfu-default)
	(setq kind-icon-blend-background t)
	(setq kind-icon-blend-frac 0.00)
	(add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))
(elpaca corfu-candidate-overlay
  (corfu-candidate-overlay-mode 1))

(provide 'completion-setup)

