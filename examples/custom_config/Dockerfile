FROM leapsight/bondy:develop AS builder

COPY --chown=bondy:bondy etc/bondy.conf /bondy/etc/bondy.conf.template

# RUN /bondy/etc/replace-env-vars -i /bondy/etc/bondy.conf -o /bondy/etc/bondy.conf