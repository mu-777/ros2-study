FROM mu777/ros2:foxy_desktop

RUN apt update && apt install -y --no-install-recommends \
    sudo gosu less bash-completion \
    git vim iputils-ping net-tools dnsutils \
    python3-colcon-common-extensions python3-argcomplete \
    && rm -rf /var/lib/apt/lists/*

RUN echo ALL ALL=\(ALL:ALL\) NOPASSWD: ALL>> /etc/sudoers

COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]