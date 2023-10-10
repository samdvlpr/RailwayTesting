FROM alpine:3.18.3

COPY --chmod=755 start.sh ./

ENTRYPOINT ["/bin/sh"]

EXPOSE 22

COPY entrypoint.sh /

CMD ["start.sh"]

ENTRYPOINT ["/entrypoint.sh"]
