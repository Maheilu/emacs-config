(defclass lsp-clangd (eglot-lsp-server) () "Subclass für Clangd")
(add-to-list 'eglot-server-programs
             (cons '(c++-mode c++-ts-mode)
                   (cons 'lsp-clangd (eglot-alternatives '("clangd")))))

;; https://joaotavora.github.io/eglot/#Setting-Up-LSP-Servers
;; patch client capabilities JSON for lsp-clangd
(cl-defmethod eglot-client-capabilities :around ((_server lsp-clangd))
  (let ((ret (cl-call-next-method)))
    (setf (cl-getf (cl-getf ret :textDocument)
                   :inactiveRegionsCapabilities)
          '(:inactiveRegions t))
    ret))
;; implement textDocument/inactiveRegions
(defvar-local lsp-clangd-inactive-region-overlays '())
(cl-defmethod eglot-handle-notification
  ((_server lsp-clangd)
   (_method (eql textDocument/inactiveRegions))
   &key regions textDocument &allow-other-keys)
  (if-let* ((path (expand-file-name (eglot--uri-to-path (cl-getf textDocument :uri))))
            (buffer (find-buffer-visiting path)))
      (with-current-buffer buffer
        (mapc #'delete-overlay lsp-clangd-inactive-region-overlays)
        (cl-loop
          for r across regions
          for (beg . end) = (eglot--range-region r)
          for ov = (make-overlay beg end)
          do
          (overlay-put ov 'face 'shadow)
          (push ov lsp-clangd-inactive-region-overlays)))))

(provide 'clangd-setup)
