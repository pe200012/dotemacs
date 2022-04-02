(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-backends
   '(company-yasnippet company-dabbrev-code company-robe company-bbdb company-eclim company-semantic company-clang company-xcode company-cmake company-capf company-files
     (company-dabbrev-code company-gtags company-etags company-keywords)
     company-oddmuse company-dabbrev))
 '(company-box-doc-delay 0.1)
 '(company-box-icons-alist 'company-box-icons-all-the-icons)
 '(company-idle-delay 0.1)
 '(company-insertion-on-trigger nil)
 '(company-insertion-triggers '(32 41 46))
 '(company-lsp-cache-candidates 'auto)
 '(company-minimum-prefix-length 3)
 '(company-tooltip-align-annotations t)
 '(custom-enabled-themes '(leuven))
 '(custom-safe-themes
   '("a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" "0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" default))
 '(default-input-method nil)
 '(global-company-mode t)
 '(haskell-font-lock-symbols t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type 'stack-ghci)
 '(haskell-stylish-on-save t)
 '(haskell-tags-on-save t)
 '(ido-enable-flex-matching t)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice t)
 '(initial-major-mode 'lisp-mode)
 '(lsp-enable-semantic-highlighting nil)
 '(lsp-file-watch-threshold 1000000)
 '(lsp-ui-flycheck-enable t)
 '(package-archives
   '(("org" . "https://orgmode.org/elpa/")
     ("melpa" . "https://melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/")))
 '(package-selected-packages
   '(wakatime-mode spinner markdown-preview-eww markdown-mode python slime eldoc flymake dash diff-hl paren hl-line proof-general company-coq merlin-eldoc fish-mode magit corral slime-company js2-mode jsx-mode web-mode tide inf-ruby lsp-treemacs company-lsp lsp-ui lsp-mode ivy doom-modeline rubocop seeing-is-believing ruby-electric ruby-tools yari company-box doom-themes company-quickhelp flycheck-rtags cpputils-cmake lsp-haskell skewer-mode emmet-mode ccls lsp-ui-peek lsp-ui-sideline cmake-mode flymake-hlint intero hasktags helm-lsp mode-icons hindent rvm robe projectile enh-ruby-mode cmake-ide protobuf-mode flycheck-ocaml irony-eldoc flymake-yaml flycheck-yaml yaml-mode flycheck-yamllint highlight-indent-guides smart-cursor-color multiple-cursors company-lua lua-mode flymake-lua highlight-symbol rainbow-delimiters counsel monokai-theme neotree clang-format moonscript haskell-mode company-irony flycheck-irony flycheck irony utop tuareg emojify all-the-icons powerline elpy color-identifiers-mode all-the-icons-dired yasnippet-snippets yasnippet paradox smartparens line-number-display-width display-line-numbers-mode company company-mode smex use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq user-full-name "pe200012")
(setq user-mail-address "1326263755@qq.com")
;; (require 'cl-lib)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(setq recentf-max-saved-items 100)
(setq recentf-max-menu-items 100)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(set-fontset-font t nil (font-spec :size 20 :name "Source Hans Sans SC"))
(add-to-list 'default-frame-alist
	     '(font . "Iosevka Moe-11"))
(require 'package)
;; (package-initialize)
(setq wakatime-api-key "b5490808-fa87-460d-b8a8-aa2fa4cf7696")
(setq wakatime-cli-path "/home/pe200012/.wakatime/wakatime-cli-linux-amd64")
(load "~/.emacs-packages.el")
(load "~/firacode.el")

;;
(setq highlight-indentation-blank-lines t)

(add-hook 'after-init-hook
	  (lambda ()
	    (require 'smartparens-config)
	    (smartparens-global-mode)
	    (global-prettify-symbols-mode +1)
	    ))

(with-eval-after-load 'company
;  (add-to-list 'company-backends 'merlin-company-backend)
  (add-to-list 'company-backends 'company-robe)
  (add-to-list 'company-backends 'company-dabbrev-code)
  (add-to-list 'company-backends 'company-yasnippet))

(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))

'(add-hook 'merlin-mode-hook 'company-mode)

(defun haskell-interactive-toggle-print-mode ()
  (interactive)
  (setq haskell-interactive-mode-eval-mode
        (intern
         (ido-completing-read "Eval result mode: "
                              '("fundamental-mode"
                                "haskell-mode"
                                "espresso-mode"
                                "ghc-core-mode"
                                "org-mode")))))

(setq haskell-process-args-ghci
          '("-ferror-spans" "-fshow-loaded-modules"))

(setq haskell-process-args-cabal-repl
          '("--ghc-options=-ferror-spans -fshow-loaded-modules"))

(setq haskell-process-args-stack-ghci
          '("--ghci-options=-ferror-spans -fshow-loaded-modules"
            "--no-build" "--no-load"))

(setq haskell-process-args-cabal-new-repl
          '("--ghc-options=-ferror-spans -fshow-loaded-modules"))

(load (expand-file-name "~/quicklisp/slime-helper.el"))
; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "sbcl")


(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)
(add-hook 'typescript-mode-hook #'setup-tide-mode)
(setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "jsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
;; configure jsx-tide checker to run after your default jsx checker
;;(flycheck-add-mode 'javascript-eslint 'web-mode)
;;(flycheck-add-next-checker 'javascript-eslint 'jsx-tide 'append)

(defun my-flycheck-rtags-setup ()
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
  (setq-local flycheck-check-syntax-automatically nil))
;; c-mode-common-hook is also called by c++-mode
(add-hook 'c-mode-common-hook #'my-flycheck-rtags-setup)

;; Goto definition
(defun ido-imenu ()
  "Update the imenu index and then use ido to select a symbol to navigate to.
Symbols matching the text at point are put first in the completion list."
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols
            (symbol-list)
            (when (listp symbol-list)
              (dolist (symbol symbol-list)
                (let ((name nil) (position nil))
                  (cond
                   ((and (listp symbol) (imenu--subalist-p symbol))
                    (addsymbols symbol))

                   ((listp symbol)
                    (setq name (car symbol))
                    (setq position (cdr symbol)))

                   ((stringp symbol)
                    (setq name symbol)
                    (setq position
                          (get-text-property 1 'org-imenu-marker symbol))))

                  (unless (or (null position) (null name))
                    (add-to-list 'symbol-names name)
                    (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    ;; If there are matching symbols at point, put them at the beginning
    ;; of `symbol-names'.
    (let ((symbol-at-point (thing-at-point 'symbol)))
      (when symbol-at-point
        (let* ((regexp (concat (regexp-quote symbol-at-point) "$"))
               (matching-symbols
                (delq nil (mapcar
                           (lambda (symbol)
                             (if (string-match regexp symbol) symbol))
                           symbol-names))))
          (when matching-symbols
            (sort matching-symbols (lambda (a b) (> (length a) (length b))))
            (mapc
             (lambda (symbol)
               (setq symbol-names (cons symbol (delete symbol symbol-names))))
             matching-symbols)))))
    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (push-mark)
      (if (overlayp position)
          (goto-char (overlay-start position))
        (goto-char position)))))

(global-set-key (kbd "C-x C-i") 'ido-imenu)
;;

;; agda setup
;; auto-load agda-mode for .agda and .lagda.md

(load-file (let ((coding-system-for-read 'utf-8))
	     (shell-command-to-string "env agda-mode locate")))

(setq auto-mode-alist
   (append
     '(("\\.agda\\'" . agda2-mode)
       ("\\.lagda.md\\'" . agda2-mode))
     auto-mode-alist))

(provide '.emacs)
;;; .emacs ends here
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
