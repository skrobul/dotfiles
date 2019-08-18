;;; packages.el --- marekvue layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Marek Skrobacki <skrobul@home>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `marekvue-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `marekvue/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `marekvue/pre-init-PACKAGE' and/or
;;   `marekvue/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst marekvue-packages
  '(
    add-node-modules-path
    company-lsp
    flycheck
    smartparens
    vue-mode)
  "The list of Lisp packages required by the marekvue layer."
)



(defun marekvue/post-init-add-node-modules-path ()
  (spacemacs/add-to-hooks #'add-node-modules-path '(css-mode-hook
                                                    vue-html-mode-hook
                                                    js-mode-hook)))

(defun marekvue/init-vue-mode ()
  "Initialize vue package"
  (use-package vue-mode
    :mode
    (("\\.vue\\'"        . vue-mode))
    :config
    (setq mmm-submode-decoration-level 0)
    :commands lsp-vue-enable))

(defun marekvue/post-init-smartparens()
  (add-to-list 'vue-mode-hook #'smartparens-mode))

(defun marekvue/post-init-flycheck ()
  (spacemacs/enable-flycheck 'vue-mode))

(defun marekvue/init-lsp-vue ()
  (use-package lsp-vue
    :init
    (add-hook 'vue-mode-hook #'lsp-vue-mmm-enable)
    ))
    ;; :config
    ;; (when vue-format-before-save
    ;;   (add-hook 'before-save-hook 'spacemacs/vue-format-before-save))))

(defun marekvue/post-init-company-lsp ()
  (spacemacs|add-company-backends
    :backends company-lsp
    :modes vue-mode))


;;; packages.el ends here
