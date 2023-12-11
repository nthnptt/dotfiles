#command improvement
alias ls=exa

#php
alias composer="docker run --rm --interactive --tty --volume $PWD:/app --volume ${COMPOSER_HOME:-$HOME/.composer}:/tmp composer"
alias php="docker run -e "TERM=xterm-256color" -it --tty --rm -v $(pwd):/app/ -w /app/  php:8.3-cli php"
