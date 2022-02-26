FROM mu777/ros2:foxy_desktop

RUN apt update && apt install -y --no-install-recommends \
    sudo gosu less bash-completion astyle \
    build-essential libpython3-dev python3-pip \
    git vim iputils-ping net-tools dnsutils \
    python3-colcon-common-extensions python3-argcomplete python3-rosdep \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install -U \
    argcomplete

RUN rosdep init && rosdep update

RUN echo ALL ALL=\(ALL:ALL\) NOPASSWD: ALL>> /etc/sudoers

COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]