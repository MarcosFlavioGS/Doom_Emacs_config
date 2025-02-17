;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Marcos Flavio"
      user-mail-address "mfghost69@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 16))
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'atom-one-dark)
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(setq-default indent-tabs-mode t)  ; Use tabs for indentation
(setq-default tab-width 4)         ; Set tab width to 4 spaces (or your preferred width)

;; Rebind keys for wraping in curly and square brackets. NOTE: This overides backward-paragraph (eg: M-{ and M-[ )
(global-set-key (kbd "M-[") 'insert-pair)
(global-set-key (kbd "M-{") 'insert-pair)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; tree-sitter-hl-mode
(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(add-hook 'before-save-hook 'ocamlformat-before-save)

(use-package prettier-js-mode
  :hook (js-mode . prettier-js-mode)
  :hook (typescript-mode . prettier-js-mode)
  :hook (tsx-ts-mode . prettier-js-mode)

  :config (setq prettier-js-args '(
                                   "--print-width" "110"
                                   "--trailing-comma" "all"
                                   "--tab-width" "2"
                                   "--semi" "true"
                                   "--single-quote" "true"
                                   )))

(use-package lsp-mode
  :hook
  ((python-mode . lsp)))

;;(setq prettier-js-args '("--print-width" "110"))

;; (use-package lsp-mode
;;  :commands lsp
;;  :ensure t
;;  :diminish lsp-mode
;;  :hook
;;  (elixir-mode . lsp)
;;  :init
;;  (add-to-list 'exec-path "~/.elixir-ls"))

;;(setq lsp-elixir-ls-version "v0.24.0")

(setq lsp-zig-zls-executable "zls")

;;dap-mode for python
(require 'dap-python)
;; if you installed debugpy, you need to set this
;; https://github.com/emacs-lsp/dap-mode/issues/306
(setq dap-python-debugger 'debugpy)

(require 'dap-elixir)

(require 'dap-cpptools)

(require 'dap-gdb-lldb)

(require 'lsp-java)

(add-hook 'java-mode-hook #'lsp)

(require 'flycheck-elixir)
(add-hook 'elixir-mode-hook 'flycheck-mode)

(eval-after-load 'flycheck
    '(flycheck-credo-setup))
(add-hook 'elixir-mode-hook 'flycheck-mode)

(add-hook 'elixir-mode-hook 'mix-minor-mode)

;;

(after! projectile
  (add-to-list 'projectile-ignored-projects "~/")) ; Replace ~/ with your $HOME path

(add-hook 'scala-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'lsp-format-buffer nil t)))


;; C3 config ------------------------------------------->
;;  
(setq treesit-language-source-alist ;; Grammar for the tree-sitter
  '((c3 "https://github.com/c3lang/tree-sitter-c3")))

(use-package! c3-ts-mode
  :mode "\\.c3\\'"
  :config
  (add-hook 'c3-ts-mode-hook #'tree-sitter-hl-mode)) ;; Use Straight to get the c3-ts-mode from the github

;; (use-package lsp-mode
;;   :config
;;   ;; Register the C3 language server
;;   (add-to-list 'lsp-language-id-configuration '(c3-ts-mode . "c3"))
;;   (lsp-register-client
;;    (make-lsp-client
;;     :new-connection (lsp-stdio-connection "c3lsp")
;;     :major-modes '(c3-ts-mode)
;;     :server-id 'c3lsp)))

;; ;; Enable lsp-mode in c3-ts-mode
;; (add-hook 'c3-ts-mode-hook #'lsp)
;; ----------------------------------------------------->

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
