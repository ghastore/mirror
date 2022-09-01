FROM alpine

LABEL "name"="Git Repo Mirror"
LABEL "description"="Universal mirroring repository tool."
LABEL "maintainer"="z17 CX <mail@z17.cx>"
LABEL "repository"="https://github.com/ghastore/mirror.git"
LABEL "homepage"="https://github.com/ghastore"

COPY *.sh /
RUN apk add --no-cache bash git git-lfs

ENTRYPOINT ["/entrypoint.sh"]
