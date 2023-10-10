FROM alpine:3.18.3

COPY --from=vault:1.13.3 vault /usr/bin/

COPY --chmod=755 start.sh ./

ENTRYPOINT ["/bin/sh"]

EXPOSE 22

CMD ["start.sh"]
