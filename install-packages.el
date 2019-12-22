;; ATTENTION: Run it in terminal in batch mode.
;;   emacs --script install-packages.el

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-list-packages)

;; Runs the installation of each package.
(package-install 'solarized-theme)
(package-install 'helm)
(package-install 'ess)
(package-install 'smartparens)
(package-install 'company)
(package-install 'yafolding)
(package-install 'auto-complete)
(package-install 'neotree)
(package-install 'multiple-cursors)
(package-install 'move-text)
(package-install 'key-combo)
(package-install 'imenu-list)
(package-install 'simple-httpd)
(package-install 'web-mode)
(package-install 'polymode)
(package-install 'poly-markdown)
