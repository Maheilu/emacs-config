(require 'eglot)
(add-to-list 'eglot-server-programs
             '((rust-mode rust-ts-mode) .
               ("rust-analyzer"
                :initializationOptions
                (:cargo (:buildScripts (:enable t))
                 :procMacro (:enable t)
                 :inlayHints (:bindingModeHints (:enable t)
                              :chainingHints (:enable t)
                              :closingBraceHints (:enable t
                                                  :minLines 1)
                              :closureCaptureHints (:enable t)
                              :closureReturnTypeHints (:enable "always")
                              :discriminantHints (:enable "always")
                              :expressionAdjustmentHints (:enable "always")
                              :lifetimeElisionHints (:enable "always")
                              :typeHints (:hideClosureInitialization t))))))

(provide 'rust-analyzer-setup)
